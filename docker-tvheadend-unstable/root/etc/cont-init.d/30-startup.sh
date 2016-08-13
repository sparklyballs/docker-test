#!/usr/bin/with-contenv bash

#!/bin/bash
echo "Running startup script...."

#Add default recording path if no config exists
if [ ! -d /config/.hts/dvr/config ]; then
	echo "Creating default DVR config..."
	mkdir -p /config/.hts/tvheadend/dvr/config
	cp /defaults/7a5edfbe189851e5b1d1df19c93962f0 /config/.hts/tvheadend/dvr/config/7a5edfbe189851e5b1d1df19c93962f0
	chown -R abc:abc /config/.hts/tvheadend
else
	echo "Config already exists. Skipping default DVR config setup."
fi

#Comskip.ini check.
if [ ! -f /config/comskip/comskip.ini ]; then
	echo "Copying defult comskip.ini to /config/comskip/."
	mkdir -p /config/comskip
	cp /defaults/comskip.ini.org /config/comskip/comskip.ini
	chown -R abc:abc /config/comskip
else
	echo "/etc/comskip.ini already exists."
fi
