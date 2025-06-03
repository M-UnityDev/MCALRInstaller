#!/bin/bash
WorkDir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
sudo pacman -S hyprland waybar fastfetch fish wofi uwsm kitty hyprpaper hyprlock pcmanfm-gtk3 nwg-look qalculate-gtk gvfs superfile ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono pipewire wireplumber xarchiver wl-clipboard cliphist grim hyprpolkitagent slurp
[ ! -d "~/MCALRUpdater/" ] && mkdir ~/MCALRUpdater/
cp -f $WorkDir/UpdaterFiles/* ~/MCALRUpdater/
/bin/bash ~/MCALRUpdater/Updater.sh
if ! command -v yay >/dev/null; then
	git clone -q https://aur.archlinux.org/yay.git $WorkDir/yay/
	cd $WorkDir/yay/
	makepkg -si --noconfirm > /dev/null
	cd $WorkDir
	rm -rf $WorkDir/yay/
fi
yay -S adwaita-colors-icon-theme zen-browser-bin github-desktop-bin
