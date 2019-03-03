FROM ubuntu:18.04
MAINTAINER bryanayers

LABEL description="Container for use with VS"

RUN \
apt -y update && \
apt -y install \
	build-essential \
	gdb \
	gdbserver \
	git \
	openssh-server \
	rsync \
	sudo \
	zip && \
mkdir /var/run/sshd && \
echo 'root:toor' | chpasswd && \
sed -i -E 's/#\s*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
apt clean

VOLUME /usr/src
WORKDIR /usr/src

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
