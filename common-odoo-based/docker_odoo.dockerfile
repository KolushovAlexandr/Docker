FROM python:3.8.5-slim-buster AS development_build
LABEL maintainer="arch.nesterov@gmail.com"
LABEL vendor="nesterow"
SHELL ["/bin/bash", "-xo", "pipefail", "-c"]
ENV LANG C.UTF-8
ENV TINI_VERSION v0.19.0
ENV DOCKERIZE_VERSION=v0.6.1
ENV ODOO_VERSION 14.0

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    dirmngr \
    fonts-noto-cjk \
    gnupg \
    libssl-dev \
    node-less \
    npm \
    python3-num2words \
    python3-pdfminer \
    python3-pip \
    python3-phonenumbers \
    python3-pyldap \
    python3-qrcode \
    python3-renderpm \
    python3-setuptools \
    python3-slugify \
    python3-vobject \
    python3-watchdog \
    python3-xlrd \
    python3-xlwt \
    xz-utils \
    postgresql-client \
    libpq-dev \
    build-essential \
    libxslt-dev \
    python3-dev \
    libtiff5-dev libjpeg62-turbo-dev libopenjp2-7-dev zlib1g-dev \
    libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python3-tk \
    libharfbuzz-dev libfribidi-dev libxcb1-dev \
    zlib1g-dev \
    libsasl2-dev python-dev libldap2-dev libssl-dev \
    && curl -o wkhtmltox.deb -sSL https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb \
    && echo 'ea8277df4297afc507c61122f3c349af142f31e5 wkhtmltox.deb' | sha1sum -c - \
    && apt-get install -y --no-install-recommends ./wkhtmltox.deb \
    && rm -rf /var/lib/apt/lists/* wkhtmltox.deb

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

RUN groupadd -r odoo && useradd -r -g odoo odoo
ADD https://codeload.github.com/odoo/odoo/tar.gz/${ODOO_VERSION} /tmp/odoo-${ODOO_VERSION}.tar.gz
RUN rm -rf /odoo && mkdir /odoo && \
    tar -zxf /tmp/odoo-${ODOO_VERSION}.tar.gz --directory / && \
    rm /tmp/odoo-${ODOO_VERSION}.tar.gz && \
    rm -rf /odoo-${ODOO_VERSION}/.git

WORKDIR /odoo-${ODOO_VERSION}

ADD https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz /opt/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz
COPY ./docker/odoo.entrypoint.sh /entrypoint.sh
RUN pip install setuptools wheel && \
    npm install -g rtlcss less && \
    chown odoo:odoo -R /odoo-${ODOO_VERSION} && \ 
    chown odoo:odoo -R /usr/local/lib/node_modules &&\
    pip install -r requirements.txt && \
    tar -C /usr/local/bin -xzvf "/opt/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz" && \
    rm "/opt/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz" && dockerize --version &&\ 
    chmod +x /entrypoint.sh && \
    mkdir -p /var/lib/odoo && \
    chown odoo:odoo -R /var/lib/odoo && \
    mkdir -p /home/odoo && \
    chown odoo:odoo -R /home/odoo

USER odoo
ENTRYPOINT ["tini", "--", "/entrypoint.sh"]

FROM development_build as production_build
USER root
COPY ./addons /addons
COPY ./config/odoo.conf /config/odoo.conf
COPY ./docker/odoo.entrypoint.sh /entrypoint.sh
RUN chown odoo:odoo -R /addons && chown odoo:odoo -R /config
WORKDIR /odoo-${ODOO_VERSION}
USER odoo
ENTRYPOINT ["tini", "--", "/entrypoint.sh"]

FROM development_build as debug_build
USER root
WORKDIR /odoo-${ODOO_VERSION}
RUN pip install watchdog sphinx sphinx-patchqueue debugpy && cd doc && make html
USER odoo
ENTRYPOINT ["tini", "--", "/entrypoint.sh"]

