# Overview
1. How to setup gtk4-rs


# Gotchas
1. There's an enormous impedance mismatch in the model
1. gtk relies a lot on inheritance (patched over with trait and macro hacks)
1. gtk keeps multiple refs to signals forever (patched with RefCell hacks)
1. window objects are neither `Send` nor `Sync`
1. Setup is gtk version specific
1. It will be very obvious from the start you're using the wrong pair of tools


# Setup gtk4
```bash
sudo echo "deb http://deb.debian.org/debian experimental main" > /etc/apt/sources.list.d/gtk4-rs.list
sudo chmod 644 /etc/apt/sources.list.d/gtk4-rs.list

apt update
sudo apt install -t experimental libgtk-4-1 libgtk-4-dev
```


# Other Resources
1. https://gtk-rs.org/
