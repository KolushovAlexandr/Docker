FROM odoo:14.0

USER root

RUN apt-get update && \
    apt-get install -y moreutils && \
    apt-get install -y git && \
    apt-get install -y nano && \
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

RUN touch /tmp/geckodriver.log
RUN chown -R 777 /tmp/

# Fix some python issues
RUN pip3 install wheel
# RUN python setup.py bdist_wheel

# Main requirements
RUN pip3 install wdb zeep websocket

# LAB
RUN pip3 install odoo_rpc_client openpyxl dotmap tabulate pika yattag numpy

# PARSER
RUN pip3 install selenium docxtpl

# VS
RUN pip3 install watchdog debugpy

# Headless Browser
RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list' \
    && apt-get update \
    && apt-get install google-chrome-stable -y

# firefox https://github.com/dimmg/dockselpy/blob/master/Dockerfile
RUN apt-get install bzip2

RUN GECKODRIVER_VERSION=`curl https://github.com/mozilla/geckodriver/releases/latest | grep -Po 'v[0-9]+.[0-9]+.[0-9]+'` && \
    wget https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_VERSION/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz && \
    tar -zxf geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/geckodriver && \
    rm geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz

RUN FIREFOX_SETUP=firefox-setup.tar.bz2 && \
    apt-get purge firefox && \
    wget -O $FIREFOX_SETUP "https://download.mozilla.org/?product=firefox-latest&os=linux64" && \
    tar xjf $FIREFOX_SETUP -C /opt/ && \
    ln -s /opt/firefox/firefox /usr/bin/firefox && \
    rm $FIREFOX_SETUP

RUN apt-get install libdbus-glib-1-2

USER odoo
