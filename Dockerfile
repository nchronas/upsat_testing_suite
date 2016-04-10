FROM resin/rpi-raspbian:jessie

RUN apt-get update \
	&& apt-get install -y ruby git \
	autoconf libtool libftdi-dev \
	# Remove package lists to free up space 
	&& rm -rf /var/lib/apt/lists/*

RUN git clone --recursive git://git.code.sf.net/p/openocd/code openocd-git && cd openocd-git

RUN ./bootstrap &&\
./configure --enable-sysfsgpio\
     --enable-maintainer-mode \
     --disable-werror \
     --enable-ft2232_libftdi \
     --enable-ep93xx \
     --enable-at91rm9200 \
     --enable-usbprog \
     --enable-presto_libftdi \
     --enable-jlink \
     --enable-vsllink \
     --enable-rlink \
     --enable-arm-jtag-ew \
     --enable-dummy \
     --enable-buspirate \
     --enable-ulink \
     --enable-presto_libftdi \
     --enable-usb_blaster_libftdi \
     --enable-ft2232_libftdi\
     --prefix=/usr\
&&\
make

ADD . /App

RUN git clone https://github.com/librespacefoundation/packetCraft.git

RUN gem install serialport

CMD ["ruby", "/App/helloworld.rb"]
 