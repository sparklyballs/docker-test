FROM lsiobase/alpine
MAINTAINER saarg

# Copy local files
COPY root/ /

# Add runtime dependencies required for Oscam
RUN \	
 apk add --no-cache \
	openssl \
	pcsc-lite \
	pcsc-lite-libs \
	usbutils \
	oscam \
	eudev-libs \
	pcsc-lite-dev \
	libcrypto1.0 \
	libssl1.0 \
	libusb && \

# Fix broken permissions from pcscd install.
chown root:root /usr/sbin/pcscd && \
chmod 755 /usr/sbin/pcscd && \

# Install Install PCSC drivers for OmniKey devices
cd /tmp/ && \
tar xvzf ifdokccid_linux_x86_64-v4.2.8.tar.gz && \
cd ifdokccid_linux_x86_64-v4.2.8 && \
./install && \

# Clean up
 rm -rf \
	/var/cache/apk/* /tmp/*

# Ports and volumes
EXPOSE 8888
