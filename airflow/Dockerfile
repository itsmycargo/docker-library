FROM puckel/docker-airflow:latest

RUN pip install --user \
  apache-airflow[aws,gcp,google_auth,kubernetes,slack]==$(pip show apache-airflow|grep 'Version'|cut -f2 -d' ')

COPY requirements.txt .

RUN pip install --user -r requirements.txt && rm requirements.txt
