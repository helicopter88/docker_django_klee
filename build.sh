#!/bin/bash
if [ ! -e /titb ]; then
	exit -1
fi

# Grab the python source code
cp -R /titb/src/klee_web klee_web

cp /etc/apt/sources.list.d/pgdg.list pgdg.list

cp /etc/postgresql/9.5/main/postgresql.conf postgresql.conf

sudo cp /etc/postgresql/9.5/main/pg_hba.conf pg_hba.conf

cp /etc/profile.d/klee-web-environment.sh klee-web-environment.sh

cp /src/python_runner.sh python_runner.sh

sudo docker build -t klee:django .
