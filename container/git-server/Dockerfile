FROM sshd

RUN yum install -y git

RUN /usr/local/sbin/add-uid-key git /usr/bin/git-shell "Volume mount /home/git/.ssh/ to replace (shadow) this authorized_keys file!"
