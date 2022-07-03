FROM sshd

# For CentOS instead of Fedora, use /etc/yum.conf instead of /etc/dnf/dnf.conf
RUN sed -i -e '/tsflags=nodocs/s/^/#/' /etc/dnf/dnf.conf \
 && yum install -y openssh-clients git findutils man-db man man-pages less

# see docs/podman.md
RUN sudo dnf install -y podman-remote
COPY podman docker /usr/bin/
