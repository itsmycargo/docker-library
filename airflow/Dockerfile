FROM apache/airflow:1.10.14-python3.8

USER root

RUN set -ex \
  && apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
    build-essential \
    gcc \
    libpq-dev \
    libsnappy-dev \
    unzip

USER airflow

COPY requirements.txt .

RUN set -ex \
    && sed -i "s/AIRFLOW_VERSION/$(pip show apache-airflow|grep 'Version'|cut -f2 -d' ')/" requirements.txt \
    && pip install --user -r requirements.txt && rm requirements.txt
