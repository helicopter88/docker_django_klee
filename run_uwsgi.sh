#!/bin/bash
export PROJECT_PATH=/opt/src
export DJANGO_PATH=/opt/src/src/klee_web

${PROJECT_PATH}/python_runner.sh python ${DJANGO_PATH}/manage.py syncdb && \
${PROJECT_PATH}/python_runner.sh python ${DJANGO_PATH}/manage.py migrate --noinput && \
${PROJECT_PATH}/python_runner.sh python ${DJANGO_PATH}/manage.py collectstatic --noinput


/usr/local/bin/uwsgi /etc/uwsgi.ini
