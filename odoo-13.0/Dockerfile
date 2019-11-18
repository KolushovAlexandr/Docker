FROM odoo:13.0

USER root

RUN apt-get update && \
    apt-get install -y moreutils && \
    apt-get install -y git && \
    apt-get install -y nano

RUN mkdir -p /mnt/odoo-source/ && \
    mkdir -p /mnt/it-projects && \
    mkdir -p /mnt/it-projects/pos-addons && \
    mkdir -p /mnt/it-projects/mail-addons && \
    mkdir -p /mnt/it-projects/misc-addons && \
    mkdir -p /mnt/it-projects/access-addons && \
    mkdir -p /mnt/it-projects/website-addons

RUN chown -R odoo /mnt/

RUN pip3 install wdb zeep

RUN git clone --depth=1 -b 13.0 https://github.com/it-projects-llc/pos-addons.git     /mnt/it-projects/pos-addons && chown     -R odoo /mnt/it-projects/pos-addons
RUN git clone --depth=1 -b 13.0 https://github.com/it-projects-llc/mail-addons.git    /mnt/it-projects/mail-addons && chown    -R odoo /mnt/it-projects/mail-addons
RUN git clone --depth=1 -b 13.0 https://github.com/it-projects-llc/misc-addons.git    /mnt/it-projects/misc-addons && chown    -R odoo /mnt/it-projects/misc-addons
RUN git clone --depth=1 -b 13.0 https://github.com/it-projects-llc/access-addons.git  /mnt/it-projects/access-addons && chown  -R odoo /mnt/it-projects/access-addons
RUN git clone --depth=1 -b 13.0 https://github.com/it-projects-llc/website-addons.git /mnt/it-projects/website-addons && chown -R odoo /mnt/it-projects/website-addons

USER odoo
