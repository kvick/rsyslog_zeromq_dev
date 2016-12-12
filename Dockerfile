FROM ubuntu:14.04
MAINTAINER taotetek@gmail.com
ADD rsyslog /usr/local/src/rsyslog
RUN apt-get remove rsyslog -y \
&& apt-get update \
&& apt-get upgrade -y \
&& apt-get install -y --no-install-recommends gawk wget ca-certificates zlib1g-dev uuid-dev libgcrypt11-dev pkg-config python-docutils libgnutls-dev byacc flex libcurl4-gnutls-dev git libtool build-essential autoconf automake \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
&& wget https://download.libsodium.org/libsodium/releases/libsodium-1.0.11.tar.gz \
&& tar zxvf libsodium-1.0.11.tar.gz \
&& cd libsodium-1.0.9; ./configure; make -j8 install; ldconfig; cd .. \
&& git clone https://github.com/zeromq/libzmq.git \
&& cd libzmq; ./autogen.sh; ./configure; make -j8 install; ldconfig; cd .. \
&& git clone https://github.com/zeromq/czmq.git \
&& cd czmq; ./autogen.sh; ./configure; make -j8 install; ldconfig; cd .. \
&& wget http://libestr.adiscon.com/files/download/libestr-0.1.10.tar.gz \
&& tar zxvf libestr-0.1.10.tar.gz \
&& cd libestr-0.1.10; ./configure; make -j8 install; ldconfig; cd .. \
&& wget http://download.rsyslog.com/libfastjson/libfastjson-0.99.4.tar.gz \
&& tar zxvf libfastjson-0.99.4.tar.gz; cd libfastjson-0.99.4; ./configure; make install; ldconfig; cd .. \
&& wget http://download.rsyslog.com/liblogging/liblogging-1.0.5.tar.gz \
&& tar zxvf liblogging-1.0.5.tar.gz \
&& cd liblogging-1.0.5; ./configure --enable-journal=no; make install; ldconfig; cd .. \
&& wget http://www.liblognorm.com/files/download/liblognorm-2.0.2.tar.gz \
&& tar zxvf liblognorm-2.0.2.tar.gz \
&& cd liblognorm-2.0.2; ./configure; make -j8 install; ldconfig; cd .. \
&& cd /usr/local/src/rsyslog \
&& make distclean \
&& ./autogen.sh --enable-impstats --enable-pmlastmsg --enable-omprog --enable-mmjsonparse --enable-imtcp --enable-mmnormalize --enable-mmfields --enable-mmsequence --enable-gnutls --enable-imczmq --enable-omczmq --enable-uuid;  make; make install; cd .. \
&& apt-get -y autoremove \
&& mkdir /etc/curve.d
ADD config/example_server /etc/curve.d/example_server
ADD config/example_server_secret /etc/curve.d/example_server_secret
ADD config/example_client /etc/curve.d/example_client
ADD config/rsyslog.conf /etc/rsyslog.conf
CMD /usr/sbin/rsyslogd -dn -i /var/run/rsyslogd.pid -f /etc/rsyslog.conf
