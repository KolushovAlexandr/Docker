FROM odoo:10.0

USER root

RUN apt-get update && \
    apt-get install -y moreutils && \
    apt-get install -y git && \
    apt-get install -y nano

#   for TG.
RUN apt-get install egenix-mx-base
RUN pip install braintree \
    pip install pip==19.0.1 \
    pip install --no-cache-dir egenix-mx-base

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
RUN pip install wheel
RUN pip install --upgrade pip
# RUN python setup.py bdist_wheel

# Main requirements
RUN pip install wdb zeep websocket

# POS requirements
RUN pip install wechatpy[cryptography] requests-mock python-alipay-sdk websocket-client
RUN pip install simplejson

# MISC requirements
RUN pip install icalendar boto3 pretty_bad_protocol dropbox google-api-python-client

# Headless Browser
RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list' \
    && apt-get update \
    && apt-get install google-chrome-stable -y

USER odoo
