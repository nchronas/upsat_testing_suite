FROM resin/rpi-raspbian:jessie

RUN apt-get update \
	&& apt-get install -y ruby git\
	# Remove package lists to free up space 
	&& rm -rf /var/lib/apt/lists/*

ADD . /App

RUN git clone https://github.com/librespacefoundation/packetCraft.git

CMD ["ruby", "/App/helloworld.rb"]
 