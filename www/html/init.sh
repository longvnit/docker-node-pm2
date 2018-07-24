#!/bin/bash

set -e

# update files hosts
if [ -e "server/hosts" ]; then
	echo '127.0.0.1 localhost' > /etc/hosts
	echo $(hostname -I) $(hostname) >> /etc/hosts
	cat server/hosts >> /etc/hosts
fi

# change directory to source folder (/var/www/html)

cd ${DOCUMENT_ROOT}

if [ ! -d "node_modules" ]; then
	npm install
else
	npm update
fi

#if [ ! -d "${NODE_LOG}" ]; then
#	mkdir -p ${NODE_LOG}
#fi

# Set PM2 logrorate
pm2 set pm2-logrotate:max_size 50M
pm2 set pm2-logrotate:compress true
pm2 set pm2-logrotate:retain 10

# PM2 run command
if [ -e ecosystem.json ]; then
	rm ecosystem.json
fi

if [ -e "server/ecosystem.dist" ]; then

	echo '> Start/Restart PM2 ...'
	cp server/ecosystem.dist ecosystem.json
	pm2 startOrRestart ecosystem.json --env production &
fi