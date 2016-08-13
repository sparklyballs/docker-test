#!/usr/bin/with-contenv bash

#!/bin/bash
echo "Running startup script...."


#Check if nonexistent folder exists and create if needed
#if [ ! -d /nonexistent ]; then
#	echo "Creating directory /nonexistent."
#	mkdir -p /nonexistent/
#else 
#	echo "The directory /nonexisten already exist."
#fi


#Check if xmltv folder exists
#if [ ! -d /config/.xmltv ]; then
#	echo "Creating directory /config/.xmltv."
#	mkdir -p /config/.xmltv
#	ln -s  /config/.xmltv /nonexistent/
#else 
#	echo "The directory /config/.xmltv already exist."
#fi

#Check if link exists
#if [ ! -h /config/.xmltv ]; then
#	echo "Creating symlink to directory /nonexistent."
#	ln -s  /config/.xmltv /nonexistent/
#else
#	echo "Symlink to /nonexistent already exist."
#fi

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

#echo "Changing owner and permissions for /config/"
#chown -R abc:abc /config/
#chmod -R g+rw /config/


 
