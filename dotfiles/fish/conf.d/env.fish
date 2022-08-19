# https://fishshell.com/docs/current/cmds/set.html
# documents the different between -Ux (universal + ENV) and -gx (global + ENV);
# use U for stuff you will "never" change and g for things you may temporarily change.

# see also ../../alias
if test ! -n "$CODESPACES"
    set -Ux EDITOR nano
else
    set -Ux EDITOR "code --wait"
end

if test ! -n "$JAVA_HOME"
    set -gx JAVA_HOME /etc/alternatives/java_sdk/
end

# see docs/podman.md
# (This must come before the below so that this works in-container.)
if test -f /usr/bin/podman-remote
    set -Ux CONTAINER_HOST unix://run/user/1000/podman/podman.sock
end

# https://buildpacks.io/docs/app-developer-guide/building-on-podman/
if test -f /usr/bin/podman
    set -Ux DOCKER_HOST unix://(podman info -f "{{.Host.RemoteSocket.Path}}")
end
