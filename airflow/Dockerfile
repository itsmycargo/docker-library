FROM puckel/docker-airflow:latest

RUN pip install --user \
  apache-airflow[aws,datadog,gcp,google_auth,jira,slack,statsd,kubernetes,sentry,ssh]==$(pip show apache-airflow|grep 'Version'|cut -f2 -d' ')

COPY requirements.txt .

RUN pip install --user -r requirements.txt && rm requirements.txt
