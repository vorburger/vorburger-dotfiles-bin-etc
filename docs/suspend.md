# Linux Suspend Power Consumption

This is about power use when suspended, [there is another one about when running](power.md).

Some modern laptop BIOS' ([quote](https://delta-xi.net/blog/#056)) _"removed traditional deep sleep (ACPI S3 sleep state) in favor of a new, Microsoft-driven sleep state called Windows Modern Standby, aka Si03. This sleep state doesn't fully turn off all components except for main memory, but puts the devices themselves into an ultra low-power state. This way, much like modern smartphones do, some devices can briefly wake up particular components of the system - most notably communication devices."_

## Lenovo ThinkPad X1 Carbon Gen 12

ToDo:
1. Change BIOS settings, re-test over night.
1. If NOK, run https://github.com/intel/S0ixSelftestTool - does that show anything interesting?
1. If NOK, run https://github.com/lhl/batterylog just to get numbers.
1. Re-read and play through https://gemini.google.com/app/4a69b2e20f982619, notably:
   - Start Minimal: Reboot your laptop, close all applications, disconnect all external peripherals, disable Wi-Fi and Bluetooth. Then suspend and check the drain. If it's significantly better, start adding things back one by one.
   - Pull out the SK - is that it?!
   - `cat /proc/acpi/wakeup` and `echo <device_name> | sudo tee /proc/acpi/wakeup`
   - Adding `nvme.noacpi=1` to your kernel boot parameters might help in some cases.
   - `power-profiles-daemon` vs. `tuned`: Some users have reported issues with power-profiles-daemon causing heavy battery drain during suspend, especially on Fedora.
1. Try https://discourse.nixos.org/t/battery-life-on-lenoxo-x1-carbon-gen-11/35928/8
1. If NOK, try TLP? Re-test over night.
1. If NOK, post like and then also link on https://forums.lenovo.com/t5/Other-Linux-Discussions/Thinkpad-X1-Carbon-gen-11-and-Linux-S3-sleep-support/m-p/5270127
1. If NOK, perhaps open an issue like https://bugzilla.kernel.org/show_bug.cgi?id=215832 ?
1. If NOK, go real crazy and have fun with https://wiki.archlinux.org/title/DSDT hacking for https://wiki.osdev.org/DSDT... ;-)
   * https://saveriomiroddi.github.io/Enabling-the-S3-sleep-suspend-on-the-Lenovo-Yoga-7-AMD-Gen-7-and-possibly-others/
   * https://delta-xi.net/blog/#056 

https://wiki.archlinux.org/title/Lenovo_ThinkPad_X1_Carbon_(Gen_12)

https://wiki.archlinux.org/title/Talk:Lenovo_ThinkPad_X1_Carbon_(Gen_12)

Discharges too fast when suspended; so until that's fixed, just always shut it down completely.

Shame - given [official Lenovo Linux support](https://download.lenovo.com/pccbbs/mobiles_pdf/x1_carbon_gen12_linux_ug_en.pdf)!

BIOS (see [simulator](https://download.lenovo.com/bsco/index.html#/graphicalsimulator/ThinkPad%20X1%20Carbon%2012th%20Gen%20(21KC,21KD)); cool!)
does not have that (below) Linux Suspend setting... :=(( Kernel shows `ACPI: PM: (supports S0 S4 S5)` - missing S3.

While in the BIOS (for below), also change:

* Config : Network : Wake on LAN from Dock == OFF
* Config : Network : Lenovo Cloud Services == OFF
* Config : USB : Always On USB == OFF
* Config : USB : Charge in Battery Mode == OFF
* Config : Power : Power On with AC Attach == OFF
* Config : Intel AMT : == DISABLED
* Config : Intel(R) Standard Manageability == DISABLED

## General

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

With that change, it went down only -3% from 26% to 23% in 6.5h on Standby. That seems ~30% better.

To get more (full, 0% use) power saving when un-used, you have to use Hibernate to Swap instead of Suspend.

PS: When we try to write `s2idle` into `/sys/power/mem_sleep` in that BIOS mode, Suspend is weird:
The screen goes off, it seems like it's suspended (`/sys/power/suspend_stats/fail*` are all 0) - but
the keyboard and the red ThinkPad light stay on! That's quite confusing... ;-) This is the
_"Suspend-to-Idle"_ mode that's described on [Kernel doc power/interface.txt](https://www.kernel.org/doc/Documentation/power/interface.txt)
which you can also get with `echo 'freeze' >/sys/power/state`; where the `echo 'mem' >/sys/power/state`
is the _Suspend-to-RAM_ which one would normally want.

PPS: Hibernate instead of Suspend is no longer recommended, as it's still slower, and more importantly NOT secure:

* Beware of some Secure Boot interaction with non-encrypted swap... https://fedoramagazine.org/hibernation-in-fedora-36-workstation/
* `/sys/power/image_size` says 6566203392 bytes... that's 6 GB... but Swap probably needs to be 16 GB?

## Other Notes

The `GRUB_CMDLINE_LINUX_DEFAULT="quiet mem_sleep_default=deep"` seems to be way to persist the default sleep - but I didn't need to do that.

## Further Resources

* https://github.com/lhl/batterylog
* https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate
* https://www.kernel.org/doc/html/latest/admin-guide/pm/system-wide.html
* TODO Why `acpi.ec_no_wakeup=1` ?
