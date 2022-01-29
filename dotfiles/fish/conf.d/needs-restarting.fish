if status is-interactive
  # https://bugzilla.redhat.com/show_bug.cgi?id=2048113
  test -f /usr/bin/dnf && not dnf needs-restarting -r -u -s >/dev/null && not dnf needs-restarting -r -u -s && echo && uptime -p
end
