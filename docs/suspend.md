# Linux Suspend Power Consumption

This article is about power use when suspended, [there is another one about when running](power.md).

On a Lenovo ThinkPad X1 Yoga Gen6 (Type Number `20XY-004AMZ`), I noticed the
battery drained from 78% to 68% while the laptop was un-opened for 13h in Standby (sleep) mode.

[According to this SO](https://askubuntu.com/a/1398067), if `sudo cat /sys/power/mem_sleep` shows
`[s2idle]`, then `sudo -i` and then `echo 'deep' > /sys/power/mem_sleep` should help.

When tried that, it failed with `echo: write error: Invalid argument`. This is because that _"deep"_
suspend mode is not enabled in the BIOS. Rebooting into the BIOS and change the _Suspend_ setting
from the default _something something Windows and Linux_ to the other choice about _Linux S3_
makes `sudo cat /sys/power/mem_sleep` show `s2idle [deep]`.

With that _Suspend_ still works. Waking up now needs to press the power button, not just any key.
It's possible to re-authenticate with the Fingerprint reader, which is nice.

You will see Kernel logs (e.g. in `dmesg`) change from `PM: suspend entry (s2idle)` to `PM: suspend entry (deep)`.

With that, TODO power drain? 63% battery at 23:25... and still 63% at 23:37, but that's not very interesting! ;-)

PS: When we try to write `s2idle` into `/sys/power/mem_sleep` in that BIOS mode, Suspend is weird:
The screen goes off, it seems like it's suspended (`/sys/power/suspend_stats/fail*` are all 0) - but
the keyboard and the red ThinkPad light stay on! That's quite confusing... ;-) This is the
_"Suspend-to-Idle"_ mode that's described on [Kernel doc power/interface.txt](https://www.kernel.org/doc/Documentation/power/interface.txt)
which you can also get with `echo 'freeze' >/sys/power/state`; where the `echo 'mem' >/sys/power/state`
is the _Suspend-to-RAM_ which one would normally want.

PPS: TODO Hibernates instead of Suspend, to save moar power?

* `/sys/power/image_size` says 6566203392 bytes... that's 6 GB... but Swap probably needs to be 16 GB?
* Beware of some Secure Boot interaction with non-encrypted swap... https://fedoramagazine.org/hibernation-in-fedora-36-workstation/

## Further Resources

* https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate
* TODO What's `GRUB_CMDLINE_LINUX_DEFAULT="quiet mem_sleep_default=deep"` ?
* TODO Why `acpi.ec_no_wakeup=1` ?
