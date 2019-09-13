FROM fedora-updated

RUN yum install -y openssh-server \

 && /usr/libexec/openssh/sshd-keygen rsa \
 && /usr/libexec/openssh/sshd-keygen ecdsa \
 && /usr/libexec/openssh/sshd-keygen ed25519 \

 && sed -i 's/^PermitRootLogin yes$/PermitRootLogin no/' /etc/ssh/sshd_config \
 && sed -i 's/^PasswordAuthentication yes$/PasswordAuthentication no/' /etc/ssh/sshd_config \
 && sed -i 's/^X11Forwarding yes$/X11Forwarding no/' /etc/ssh/sshd_config

# sshd-keygen as in /usr/lib/systemd/system/sshd-keygen@.service
# NB /usr/libexec/openssh/sshd-keygen is a script != /usr/bin/ssh-keygen binary

# /usr/lib/systemd/system/sshd.service
# TODO source /etc/crypto-policies/back-ends/opensshserver.config
# TODO sshd $CRYPTO_POLICY

# https://docs.docker.com/engine/examples/running_ssh_service/
EXPOSE 22

# -D for production, or -eddd for debug
CMD ["/usr/sbin/sshd", "-D"]
