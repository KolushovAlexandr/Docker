FROM itprojectsllc/install-odoo:11.0-dev

USER root

RUN apt-get update && \
    apt-get install -y nano

# Main requirements
RUN pip3 install wdb


USER odoo
