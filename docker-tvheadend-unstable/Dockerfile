FROM lsiobase/alpine
MAINTAINER saarg

# Environment settings
ARG BUILD_DIR="/tmp/"
ARG TVH_SRC="/tmp/tvheadend"
ARG DVBAPPS="/tmp/dvb-apps"
ARG XMLTV="/tmp/xmltv-0.5.67"
ARG TVH_VER="e3e8a797"
ENV HOME="/config"

# Copy local files
COPY root/ /

# Install build dependencies for tvheadend
RUN \
 apk add --no-cache --virtual=build-dependencies \
		build-base pkgconf openssl-dev \
		git wget cmake \
		zlib-dev \
		uriparser-dev gettext-dev \
		libhdhomerun-dev \
		findutils coreutils ffmpeg-dev \

# PERL modules build dependencies
		perl-dev \
		libxml2-dev \
		patch \
		
# DVB-apps build dependencies
		mercurial && \
		
# Add runtime dependencies required in build stage
 apk add --no-cache \
		libcurl	\
		libssl1.0 \
		libcrypto1.0 \
		python \
		zlib \
		linux-headers \
		bsd-compat-headers \
		uriparser \
		bzip2 \

# Perl runtime dependencies required in build stage
		perl \
		perl-module-build \
		perl-path-class \
		perl-html-parser \
		perl-net-ssleay \
		perl-xml-parser \
		perl-xml-sax \
		perl-term-readkey \
		perl-libwww \
		perl-date-manip \
		perl-term-readkey \
		perl-file-slurp \
		perl-compress-raw-zlib \
		perl-io-compress \
		perl-archive-zip \
		perl-cgi \
		perl-datetime \
		perl-io-html \
		perl-html-parser \
		perl-html-tree \
		perl-http-cookies \
		perl-io \
		perl-io-stringy \
		perl-json \
		perl-parse-recdescent \
		perl-capture-tiny \
		perl-test-exception \
		perl-boolean \
		perl-test-requires \
		perl-module-pluggable \
		gzip \
		openssl \
		curl \
		wget && \ 

# Install runtime PERL modules needed for XMLTV build stage
curl -L http://cpanmin.us | perl - App::cpanminus && \
 cpanm IO::Socket::SSL && \ 
 cpanm XML::Writer && \ 
 cpanm HTML::TableExtract && \
 cpanm HTTP::Cache::Transparent && \
 cpanm SOAP::Lite && \
 cpanm IO::Scalar && \
 cpanm WWW::Mechanize && \
 cpanm XML::LibXML && \
 cpanm Unicode::UTF8simple && \
 cpanm Term::ProgressBar && \
 cpanm PerlIO::gzip && \
 cpanm Lingua::Preferred && \
 cpanm Lingua::EN::Numbers::Ordinate && \
 cpanm XML::Twig && \
 cpanm XML::TreePP && \
 cpanm Term::ProgressBar && \
 cpanm inc && \
 cpanm version && \
	

# Build and patch perl-unicode-string
cd "$BUILD_DIR" && \
wget http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/Unicode-String-2.09.tar.gz && \
tar xvzf Unicode-String-2.09.tar.gz && \
cd Unicode-String-2.09/lib/Unicode && \
patch -i /tmp/perl-unicode.patch && \
cd "$BUILD_DIR"\Unicode-String-2.09 && \
perl Makefile.PL && \
make && \
make test && \
make install && \

# Build DVB-apps
 cd "$BUILD_DIR" && \
 hg clone http://linuxtv.org/hg/dvb-apps && \
 cd dvb-apps && \
 make && \
 make install && \

 
# Build tvheadend
 cd "$BUILD_DIR" && \
 git clone https://github.com/tvheadend/tvheadend.git && \
 cd tvheadend && \
 git checkout  "$TVH_VER" && \
 ./configure --prefix=/usr \
#			--mandir=/usr/share/man \
#			--infodir=/usr/share/info \
			--localstatedir=/var \
			--enable-libav \
			--sysconfdir=/config \
			--enable-hdhomerun_client \
			--disable-hdhomerun_static \
			--disable-ffmpeg_static \
			--disable-libx264_static \
			--disable-libx265_static \
			--disable-libvpx_static \
			--disable-libtheora_static \
			--disable-libvorbis_static \
			--disable-libfdkaac_static \
			--disable-libmfx_static && \
make && \
make install && \
 
# Build XMLTV 
cd "$BUILD_DIR" && \
wget http://kent.dl.sourceforge.net/project/xmltv/xmltv/0.5.67/xmltv-0.5.67.tar.bz2 && \
tar xf xmltv-0.5.67.tar.bz2 && \
cd "$XMLTV" && \
/bin/echo -e "yes" | perl Makefile.PL PREFIX=/usr/ INSTALLDIRS=vendor && \
make && \
make test && \
make install && \



# Add runtime dependencies for tvheadend
apk add --no-cache \
		ffmpeg-libs \
		libhdhomerun-libs && \

# Uninstall build dependencies		
apk del --purge \
	build-dependencies && \

# Clean up
 rm -rf \
	/var/cache/apk/* /tmp/*

# Ports and volumes
EXPOSE 9981 9982
