# Alt-Tab switches windows, not applications
# NB using "gsettings set" instead of "dconf write" to fix "error: 0-2:unable to infer type"
# https://superuser.com/a/1029822/66965

gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab', '<Alt>Above_Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "[]"

# Seconds ticking at the top of the screen are very annoying - it's a desktop environment, not a time bomb! ;-)
gsettings set org.gnome.desktop.interface clock-show-seconds false
