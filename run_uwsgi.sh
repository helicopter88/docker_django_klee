#!/bin/bash
export PROJECT_PATH=/opt/src
export DJANGO_PATH=/opt/src/src/klee_web

${PROJECT_PATH}/python_runner.sh python ${DJANGO_PATH}/manage.py migrate --noinput && \
${PROJECT_PATH}/python_runner.sh python ${DJANGO_PATH}/manage.py collectstatic --noinput
${PROJECT_PATH}/python_runner.sh python ${DJANGO_PATH}/manage.py update_admin_user --username=admin --password=development
/usr/local/bin/uwsgi /etc/uwsgi.ini
