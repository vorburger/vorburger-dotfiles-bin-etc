FROM sshd

# TODO rm util-linux-user, if chsh isn't required anymore, because default shell is already set during user creation?
RUN yum install -y git util-linux-user

RUN /usr/local/sbin/add-uid-key git "Volume mount /home/git/.ssh/ to replace (shadow) this authorized_keys file!"

# TODO Replace with --shell in useradd
RUN /usr/bin/chsh -s /usr/bin/git-shell git
