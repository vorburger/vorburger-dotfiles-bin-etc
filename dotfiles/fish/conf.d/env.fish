# https://fishshell.com/docs/current/cmds/set.html
# documents the different between -Ux (universal + ENV) and -gx (global + ENV);
# use U for stuff you will "never" change and g for things you may temporarily change.

set -Ux EDITOR nano

# TODO only if $JAVA_HOME is not already set?
set -gx JAVA_HOME /etc/alternatives/java_sdk/

# Pretty output, notably for bin/findx
set -Ux GREP_OPTIONS --color=auto

# https://buildpacks.io/docs/app-developer-guide/building-on-podman/
set -Ux DOCKER_HOST unix://(podman info -f "{{.Host.RemoteSocket.Path}}")
