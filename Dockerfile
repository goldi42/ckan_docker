FROM python:2.7-alpine3.6

LABEL name="CKAN Dev"
LABEL version="1.0.0"

EXPOSE 8080

WORKDIR /app

RUN apk update && apk add postgresql postgresql-dev nodejs nodejs-npm git gcc linux-headers musl-dev
#RUN postgres createuser -S -D -R -P ckan && postgres createdb -O ckan ckan -E utf-8
RUN npm install npm@5.0.4 -g
RUN pip install setuptools==20.4 && pip install gunicorn==19.7.1  && pip install -e 'git+https://github.com/ckan/ckan.git@ckan-2.5.5#egg=ckan' --src ./ && pip install -r ckan/requirements.txt

COPY config/development.ini ./config/development.ini
COPY bin ./bin


#Copy all Extensions to the Container
COPY extensions ./extensions
RUN pip install -r  extensions/requirements.txt && nodejs bin/build.js

RUN paster db init -c config/development.ini
CMD gunicorn --paste config/development.ini -b 127.0.0.1:8000
