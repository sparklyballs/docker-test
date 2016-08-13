#!/usr/bin/with-contenv bash

# Check if /config/oscam/oscam.conf exists
if [ ! -f /config/oscam/oscam.conf ]; then
	mkdir -p /config/oscam
	cp /defaults/oscam.conf /config/oscam/oscam.conf
	chown -R abc:abc /config/oscam
fi
