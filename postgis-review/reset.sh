#!/bin/bash
# Usage: reset.sh
#

set -eux

: "${PGDATABASE:=app}"
: "${SEED_BUCKET}"
: "${SEED_PREFIX}"

force=false
jobs=$(nproc)

O=$(getopt -- fp: "$@") || exit 1
eval set -- "$O"
while true; do
	case "$1" in
	-f) force=true; shift;;
	-n) jobs=$2; shift; shift;;
	--)	shift; break;;
	*)	echo Error; exit 1;;
	esac
done

echo "=== Reset Database ==="
echo "      Database: ${PGDATABASE}"
echo ""
echo "         Force: ${force}"
echo "     S3 Bucket: ${SEED_BUCKET}"
echo "Profile Prefix: ${SEED_PREFIX}"

# Restore connections to database
psql -d template1 -c "ALTER DATABASE \"${PGDATABASE}\" CONNECTION LIMIT DEFAULT" || true

# Check if database exists
db_exists="$(psql -d ${PGDATABASE} -Atc "SELECT 1" || true)"

# Check reset date
if [ "$db_exists" = "1" ];
then
	db_timestamp=$(psql -d template1 -Atc "SELECT COALESCE(description, '1970-01-01') FROM pg_shdescription RIGHT JOIN pg_database ON objoid = pg_database.oid WHERE datname = '${PGDATABASE}'")
	if [[ ! "$db_timestamp" =~ [0-9]{4}-[0-9]{2}-[0-9]{2} ]];
	then
		db_timestamp="1970-01-01"
	fi
	db_date=$(date -d "${db_timestamp}" +%s)

	seed_file=$(aws s3api list-objects --bucket "${SEED_BUCKET}" --prefix "${SEED_PREFIX}" | jq -r '.Contents|sort_by(.Key)[-1]|.Key')
	seed_timestamp=$(
		aws s3api list-objects --bucket "${SEED_BUCKET}" \
			--query "Contents[?contains(Key, '${seed_file}')]" | jq -r '.[]|.LastModified'
	)
	seed_date=$(echo "\"${seed_timestamp}\"" | jq -r 'strptime("%Y-%m-%dT%H:%M:%S.000Z")|mktime')

	if [ "$db_date" -lt "$seed_date" ];
	then
		echo "--> Stale database detected, force resetting..."
		echo "    Database timestamp: ${db_timestamp}"
		echo "        Seed timestamp: ${seed_timestamp}"
		force=true
	fi
fi

if [ "${force}" = "false" ];
then
	# Exit if database exists already
	if [ "$db_exists" = "1" ];
	then
		echo " --> Database exists already, skip create/reset"
		echo "     To reset database, set FORCE parameter to true."
		exit 0
	fi
fi

if [ "$db_exists" = "1" ];
then
	echo "-- Truncate Database..."
	(cat <<-EOF
		GRANT pg_signal_backend TO postgres;
		ALTER DATABASE "${PGDATABASE}" CONNECTION LIMIT 0;
		SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '${PGDATABASE}';
	EOF
	) | psql -v ON_ERROR_STOP=1 -d template1

	(cat <<-EOF
		DO $\$ DECLARE
			r RECORD;
		BEGIN
			FOR r IN (select nspname from pg_catalog.pg_namespace where nspname not like 'pg_%' and nspname != 'information_schema') LOOP
				EXECUTE 'DROP SCHEMA ' || quote_ident(r.nspname) || ' CASCADE';
			END LOOP;
		END $\$;
		CREATE SCHEMA IF NOT EXISTS public;
	EOF
	) | psql -v ON_ERROR_STOP=1 -d "${PGDATABASE}"
fi

echo "=== Seeding database ==="

echo "-- Downloading Database Seed..."
aws s3 cp "s3://${SEED_BUCKET}/${seed_file}" /tmp/database.sqlc

echo "-- Restoring Database..."
pg_restore --dbname="${PGDATABASE}" --no-owner --no-privileges --jobs="${jobs}" /tmp/database.sqlc

echo '--> Reset Application Environment'
is_rails="$(psql -d ${PGDATABASE} -Atc "SELECT 1 FROM ar_internal_metadata" || true)"
if [ "$is_rails" = "1" ];
then
	echo '--> Reset Rails Environment'
	psql -d "${PGDATABASE}" -c "UPDATE ar_internal_metadata SET value = 'development' WHERE key = 'environment'"
fi

echo '--> Setting reset timestamp comment'
psql -d "${PGDATABASE}" -c "COMMENT ON DATABASE \"${PGDATABASE}\" IS '$(date +'%Y-%m-%d %H:%M:%S')'"

echo '--> Allow Connections'
psql -d "${PGDATABASE}" -c "ALTER DATABASE \"${PGDATABASE}\" CONNECTION LIMIT -1;"

echo '--> All done.'

exit 0
