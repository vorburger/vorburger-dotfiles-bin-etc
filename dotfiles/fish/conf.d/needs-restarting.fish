if status is-interactive
  test -f /usr/bin/dnf && dnf needs-restarting -r -u -s
end
