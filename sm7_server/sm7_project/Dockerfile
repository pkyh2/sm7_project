FROM python:3.8.0

ENV PYTHONUNBUFFERED 1

RUN apt-get -y update
RUN apt-get -y install vim

RUN mkdir /srv/sm7_server
ADD . /srv/sm7_server

# 해당 dir로 이동
WORKDIR /srv/sm7_server

RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN python manage.py migrate

# 네트워크 상에서 컨테이너로 들어오는 트래픽을 리스닝 하는 포트와 프로토콜을 지정하기 위해 사용된다.
EXPOSE 8001