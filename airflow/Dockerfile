FROM puckel/docker-airflow:latest

USER root

RUN set -ex \
  && apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
    gnupg \
  && echo deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main >> /etc/apt/sources.list.d/pgdg.list \
  && curl -s https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

COPY requirements.txt .

RUN set -ex \
    && buildDeps=' \
        libpq-dev \
    ' \
    && apt-get update -yqq \
    && apt-get upgrade -yqq \
    && apt-get install -yqq --no-install-recommends \
        $buildDeps \
        postgresql-client-11 \
    && pip install --no-warn-script-location \
      apache-airflow[aws,datadog,gcp,google_auth,jira,slack,statsd,kubernetes,sentry,ssh]==$(pip show apache-airflow|grep 'Version'|cut -f2 -d' ') \
    && pip install -r requirements.txt && rm requirements.txt \
    && apt-get purge --auto-remove -yqq $buildDeps \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base

USER airflow
