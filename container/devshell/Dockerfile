FROM sshd

# NB: For CentOS instead of Fedora, one would use /etc/yum.conf instead of /etc/dnf/dnf.conf
RUN sed -i -e '/tsflags=nodocs/s/^/#/' /etc/dnf/dnf.conf \
 && yum install -y openssh-clients git findutils man-db man man-pages less \
 && yum reinstall -y $(rpm -qads --qf "PACKAGE: %{NAME}\n" | sed -n -E '/PACKAGE: /{s/PACKAGE: // ; h ; b }; /^not installed/ { g; p }' | uniq)
# ^^^ missing man pages; see https://github.com/containers/toolbox/issues/603

# see docs/podman.md
RUN sudo dnf install -y podman-remote
COPY podman docker /usr/bin/
