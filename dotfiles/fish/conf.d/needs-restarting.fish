if status is-interactive

  # Because these checks noticeably slow down start-up of shells
  # (and typing the password for sudo checkrestart is a PITA),
  # we do these only once every day...

  set -l today (date +%Y-%m-%d)
  set -l daily_flag_file ~/.daily_checkrestart
  # Check if the flag file DOES NOT exist OR the last run date DOES NOT match today's date
  if not test -f $daily_flag_file; or not test (date -r $daily_flag_file +%Y-%m-%d) = $today

    # On Fedora (from https://bugzilla.redhat.com/show_bug.cgi?id=2048113)
    test -f /usr/bin/dnf && not dnf needs-restarting --cacheonly -r -s >/dev/null && not dnf needs-restarting -r -s && echo && uptime -p

    # On Debian
    test -f /usr/sbin/needrestart && /usr/sbin/needrestart

    # On Debian, with sudo
    test -f /usr/sbin/checkrestart && sudo /usr/sbin/checkrestart && sudo -K

    # On Ubuntu (and Debian?)
    test -f /var/run/reboot-required && cat /var/run/reboot-required.pkgs && echo 'Please reboot!'

    # Update daily flag file (see above)
    date +%Y-%m-%d > $daily_flag_file
  end
end
