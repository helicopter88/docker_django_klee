#!/bin/bash

python /opt/django/manage.py syncdb
python /opt/django/manage.py migrate --noinput
python /opt/django/manage.py collectstatic --noinput
/usr/local/bin/uwsgi /etc/uwsgi.ini
