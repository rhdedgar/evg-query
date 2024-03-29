# /usr/local/bin/start.sh will start the service

FROM python:2.7

# Pause indefinitely if asked to do so.
ARG OO_PAUSE_ON_BUILD
RUN test "$OO_PAUSE_ON_BUILD" = "true" && while sleep 10; do true; done || :

ADD scripts/ /usr/local/bin/

RUN sed '/st_mysql_options options;/a unsigned int reconnect;' /usr/include/mysql/mysql.h -i.bkp && \
    pip install MySQL-python && \
    pip install boto3 && \
    pip install botocore && \
    pip install requests2 && \
    pip install git+https://github.com/yaml/pyyaml@master && \
    mkdir -p /var/log/reports && \
    chmod -R g+rwX /etc/passwd /etc/group /var/log && \
    chmod -R 777 /usr/local/bin

# Start processes
CMD /usr/local/bin/start.sh
