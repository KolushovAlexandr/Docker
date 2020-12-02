FROM odoo:11.0

USER root

RUN apt-get update && \
    apt-get install -y moreutils && \
    apt-get install -y git && \
    apt-get install -y nano \
    apt-get install -y procps

RUN mkdir -p /mnt/1 && \
    mkdir -p /mnt/2 && \
    mkdir -p /mnt/3 && \
    mkdir -p /mnt/4 && \
    mkdir -p /mnt/5 && \
    mkdir -p /mnt/6 && \
    mkdir -p /mnt/7 && \
    mkdir -p /mnt/8 && \
    mkdir -p /mnt/9

RUN chown -R odoo /mnt/

# Fix some python issues
RUN pip3 install wheel
# RUN python setup.py bdist_wheel

# Main requirements
RUN pip3 install wdb zeep websocket

# POS requirements
RUN pip3 install wechatpy[cryptography] requests-mock python-alipay-sdk websocket-client

# MISC requirements
RUN pip3 install icalendar boto3 pretty_bad_protocol dropbox google-api-python-client

#LAB
RUN pip3 install odoo_rpc_client openpyxl dotmap tabulate pika yattag numpy

#PARSER

RUN pip3 install selenium docxtpl

# Headless Browser
RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list' \
    && apt-get update \
    && apt-get install google-chrome-stable -y

USER odoo
