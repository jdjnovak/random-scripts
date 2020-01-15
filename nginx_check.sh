#!/bin/bash

# This is a simple script that checks for whether the NGINX
# service is active or has been shut down. If it is found to 
# be down, we start the service

SRV=nginx.service

if [ `systemctl is-active "$SRV"` == "failed" ]; then
	echo "Service $SRV failed, starting";
	systemctl start nginx.service
fi
