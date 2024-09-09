if status is-interactive
  # On Fedora (from https://bugzilla.redhat.com/show_bug.cgi?id=2048113)
  test -f /usr/bin/dnf && not dnf needs-restarting -r -u -s >/dev/null && not dnf needs-restarting -r -u -s && echo && uptime -p

  # On Debian
  test -f /usr/sbin/needrestart && /usr/sbin/needrestart
  test -f /usr/sbin/checkrestart && sudo /usr/sbin/checkrestart && sudo -K

  # On Ubuntu (and Debian?)
  test -f /var/run/reboot-required && cat /var/run/reboot-required.pkgs && echo 'Please reboot!'
end
