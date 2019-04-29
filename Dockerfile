FROM docker.elastic.co/beats/metricbeat:6.6.2
MAINTAINER Prabhu prabh@prabhuanand.io

COPY metricbeat.yml /usr/share/metricbeat/metricbeat.yml
USER root
RUN chown root /usr/share/metricbeat/metricbeat.yml && chmod go-w /usr/share/metricbeat/metricbeat.yml
USER metricbeat

ENV ES_HOST http://localhost:9200 
LABEL version=$version