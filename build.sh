#!/bin/bash
if [ ! -e /titb ]; then
	exit -1
fi

cp /etc/profile.d/klee-web-environment.sh klee-web-environment.sh

cp /src/python_runner.sh python_runner.sh
