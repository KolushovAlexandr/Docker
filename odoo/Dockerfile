FROM odoo:11.0

USER root

RUN apt-get update && \
    apt-get install -y moreutils && \
    apt-get install -y git && \
    apt-get install -y nano

RUN mkdir -p /mnt/odoo-source && \
    chown -R odoo /mnt/

# Fix some python issues
RUN pip3 install wheel
# RUN python setup.py bdist_wheel

# Main requirements
RUN pip3 install wdb zeep websocket

# POS requirements
RUN pip3 install wechatpy[cryptography] requests-mock python-alipay-sdk websocket-client

# MISC requirements
RUN pip3 install icalendar boto3 pretty_bad_protocol dropbox google-api-python-client

# mount odoo source
RUN git clone --depth=1 -b 11.0 https://github.com/odoo/odoo.git /mnt/odoo-source/  && chown -R odoo /mnt/odoo-source

USER odoo
