#!/usr/bin/env bash
WorkDir=/tmp
DataDir=$XDG_DATA_HOME
clear
echo " "
echo "Fetching new version of MCALR"
echo " "
git clone --depth 1 -q https://github.com/M-UnityDev/MCALR.git $WorkDir/MCALR

echo "Updating shared assets folder"
rm -rf $DataDir/MCALR
mkdir $DataDir/MCALR
cp -rf $WorkDir/MCALR/ast/* $DataDir/MCALR/

echo "Updating fastfetch config"
rm -rf $HOME/.config/fastfetch
cp -rf $WorkDir/MCALR/fastfetch $HOME/.config/

echo "Updating nano config"
rm -rf $HOME/.config/nano
cp -rf $WorkDir/MCALR/nano $HOME/.config/

echo "Updating hyprland configs"
rm -rf $HOME/.config/hypr
cp -rf $WorkDir/MCALR/hypr $HOME/.config/

echo "Updating kitty config"
rm -rf $HOME/.config/kitty
cp -rf $WorkDir/MCALR/kitty $HOME/.config/

echo "Updating waybar config"
rm -rf $HOME/.config/waybar
cp -rf $WorkDir/MCALR/waybar $HOME/.config/

echo "Updating fish config"
rm -rf $HOME/.config/fish
cp -rf $WorkDir/MCALR/fish $HOME/.config/

echo "Updating rofi config"
rm -rf $HOME/.config/rofi
cp -rf $WorkDir/MCALR/rofi $HOME/.config/

echo "Updating mako config"
rm -rf $HOME/.config/mako
cp -rf $WorkDir/MCALR/mako $HOME/.config/

echo "Updating cursor themes"
rm -rf $DataDir/icons/cursors/
cp -rf $WorkDir/MCALR/cursors/ $DataDir/icons/
for theme in "$DataDir/icons/cursors"/*; do
  if [ -d "$theme" ]; then
    themename=$(basename "$theme")
    ln -sf "$theme" "$DataDir/icons/$themename"
  fi
done

echo "Updating themes"
rm -rf $HOME/.themes/*
cp -rf $WorkDir/MCALR/themes/* $HOME/.themes/

/usr/bin/env bash ~/.config/hypr/change-theme.sh -c w &> /dev/null
hyprctl reload > /dev/null
clear
echo " "
echo "────────────────────────────────────────────────────"
cat $WorkDir/MCALR/version
echo "────────────────────────────────────────────────────"
echo " "
rm -rf $WorkDir/MCALR
