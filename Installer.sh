#!/bin/bash
WorkDir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
sudo pacman -S waybar fastfetch fish wofi uwsm kitty hyprpaper hyprlock pcmanfm-gtk3
yay -S wlogout
[ ! -d "~/MCALRUpdater/" ] && mkdir ~/MCALRUpdater/
cp -f $WorkDir/UpdaterFiles/* ~/MCALRUpdater/
/bin/bash ~/MCALRUpdater/Updater.sh
