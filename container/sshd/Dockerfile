FROM fedora-updated

# sshd-keygen as in /usr/lib/systemd/system/sshd-keygen@.service
# NB /usr/libexec/openssh/sshd-keygen is a script != /usr/bin/ssh-keygen binary
RUN yum install -y openssh-server \
 && /usr/libexec/openssh/sshd-keygen rsa \
 && /usr/libexec/openssh/sshd-keygen ecdsa \
 && /usr/libexec/openssh/sshd-keygen ed25519 \
 && sed -i 's/# %wheel/%wheel/' /etc/sudoers
# This ^^^ permits sudo WITHOUT (!) a password for anyone in group wheel (which add-uid-key does)

# 01-local.conf is also used in ../../setup.sh
ADD 01-local.conf /etc/ssh/sshd_config.d/
ADD add-uid-key /usr/local/sbin/
ADD sshd-start /usr/local/sbin/
RUN chmod +x /usr/local/sbin/sshd-start

# https://docs.docker.com/engine/examples/running_ssh_service/
EXPOSE 2222

CMD ["/usr/local/sbin/sshd-start"]
