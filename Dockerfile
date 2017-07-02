FROM python:2.7-alpine3.6
LABEL name="CKAN Base" version="1.0.0"

EXPOSE 8000

ENV environment=development \
ckan_version=2.5.5

VOLUME uploads
VOLUME extensions

WORKDIR /app
RUN apk update && apk add postgresql-dev git gcc linux-headers musl-dev bash
#RUN postgres createuser -S -D -R -P ckan && postgres createdb -O ckan ckan -E utf-8
RUN pip install setuptools==20.4 \
    && pip install gunicorn==19.7.1 \
    && pip install -e "git+https://github.com/ckan/ckan.git@ckan-${ckan_version}#egg=ckan" --src ./ \
    && pip install -r ckan/requirements.txt

COPY config ./config
COPY bin ./bin

CMD sh /app/bin/startup.sh $environment
