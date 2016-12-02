FROM debian:jessie

MAINTAINER philippe.levan@campus-numerique-in-the-alps.com

RUN apt-get -qq update && \
	DEBIAN_FRONTEND=noninteractive apt-get -qq -y --no-install-recommends install \
	nano \
	vim \
	mailutils \
	ssmtp \
    apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /root/treasure
WORKDIR "/root/treasure"

CMD ["/bin/bash"]
