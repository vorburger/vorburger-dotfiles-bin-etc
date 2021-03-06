FROM devshell

COPY dnf-install.sh /tmp/
RUN /tmp/dnf-install.sh

ADD https://www.vorburger.ch//gpg/ssh-authorized_keys /tmp/authorized_keys
RUN /usr/local/sbin/add-uid-key vorburger "$(cat /tmp/authorized_keys)"

USER vorburger
WORKDIR /home/vorburger/

# Do NOT do this, because then any time you touch any file during dev, it will redo above:
#   COPY . /home/vorburger/dev/vorburger-dotfiles-bin-etc/
COPY symlink.sh /home/vorburger/dev/vorburger-dotfiles-bin-etc/
COPY dotfiles/ /home/vorburger/dev/vorburger-dotfiles-bin-etc/dotfiles/

# as per ./README.md
RUN cd /home/vorburger/dev/ && git clone https://github.com/scopatz/nanorc.git && cd .. \
 && rm /home/vorburger/.bashrc \
 && /home/vorburger/dev/vorburger-dotfiles-bin-etc/symlink.sh

# We have to reset the user to root so that sshd (FROM parent images) will start (as intended)
USER root
WORKDIR /
