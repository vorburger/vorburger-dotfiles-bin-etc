FROM fedora-updated

LABEL maintainer="Michael Vorburger <mike@vorburger.ch>"

RUN yum install -y openssh-server

# 01-local.conf is also used in ../../setup.sh
ADD 01-local.conf /etc/ssh/sshd_config.d/
ADD add-uid-key /usr/local/sbin/
ADD sshd-start /usr/local/sbin/
RUN chmod +x /usr/local/sbin/sshd-start

# https://docs.docker.com/engine/examples/running_ssh_service/
EXPOSE 2222

CMD ["/usr/local/sbin/sshd-start"]
