FROM apache/airflow:1.10.10-python3.7

USER root

RUN set -ex \
  && apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
    libpq-dev

USER airflow

COPY requirements.txt .

RUN set -ex \
    && pip install --user \
      apache-airflow[aws,gcp,google_auth,slack,kubernetes,sentry,ssh]==$(pip show apache-airflow|grep 'Version'|cut -f2 -d' ') \
    && pip install --user -r requirements.txt && rm requirements.txt
