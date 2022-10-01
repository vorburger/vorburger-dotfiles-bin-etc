FROM sshd

# Add missing man pages; see https://github.com/containers/toolbox/issues/603
# (NB: For CentOS instead of Fedora, one would use /etc/yum.conf instead of /etc/dnf/dnf.conf),
# and permit sudo WITHOUT (!) a password for anyone in group wheel (which add-uid-key does),
# see also https://containertoolbx.org/distros.
RUN sed -i -e '/tsflags=nodocs/s/^/#/' /etc/dnf/dnf.conf \
 && yum install -y openssh-clients git findutils man-db man man-pages less \
 && yum reinstall -y $(rpm -qads --qf "PACKAGE: %{NAME}\n" | sed -n -E '/PACKAGE: /{s/PACKAGE: // ; h ; b }; /^not installed/ { g; p }' | uniq) \
 && sed -i 's/# %wheel/%wheel/' /etc/sudoers \
 && sudo dnf install -y podman-remote

# see docs/podman.md
COPY podman docker /usr/bin/
