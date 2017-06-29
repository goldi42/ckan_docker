FROM python:2.7-alpine3.6

LABEL name="CKAN Dev"
LABEL version="1.0.0"

EXPOSE 8080

WORKDIR /app

RUN apk update && apk add postgresql nodejs
RUN postgres createuser -S -D -R -P ckan && postgres createdb -O ckan ckan -E utf-8
RUN npm install npm@5.0.4 -g
RUN pip install setuptools==20.4 && pip install gunicorn==19.7.1  && pip install -e 'git+https://github.com/ckan/ckan.git@ckan-2.5.5#egg=ckan' && pip install -r ckan/requirements.txt

COPY config/development.ini ckan/development.ini
COPY bin ./bin


#Copy all Extensions to the Container
COPY ckan-ext ./ckan-ext
RUN pip install -r  ckan-ext/requirements.txt && nodejs bin/build.js

CMD ls -alh
