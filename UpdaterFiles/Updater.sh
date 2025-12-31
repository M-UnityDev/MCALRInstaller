#!/bin/bash
WorkDir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
HomeDir=$HOME
DataDir=$XDG_DATA_HOME
PatchDir=$WorkDir/Patches
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
rm -rf $HomeDir/.config/fastfetch
cp -rf $WorkDir/MCALR/fastfetch $HomeDir/.config/

echo "Updating nano config"
rm -rf $HomeDir/.config/nano
cp -rf $WorkDir/MCALR/nano $HomeDir/.config/

echo "Updating hyprland configs"
rm -rf $HomeDir/.config/hypr
cp -rf $WorkDir/MCALR/hypr $HomeDir/.config/

echo "Updating kitty config"
rm -rf $HomeDir/.config/kitty
cp -rf $WorkDir/MCALR/kitty $HomeDir/.config/

echo "Updating waybar config"
rm -rf $HomeDir/.config/waybar
cp -rf $WorkDir/MCALR/waybar $HomeDir/.config/

echo "Updating fish config"
rm -rf $HomeDir/.config/fish
cp -rf $WorkDir/MCALR/fish $HomeDir/.config/

echo "Updating rofi config"
rm -rf $HomeDir/.config/rofi
cp -rf $WorkDir/MCALR/rofi $HomeDir/.config/

echo "Updating mako config"
rm -rf $HomeDir/.config/mako  
cp -rf $WorkDir/MCALR/mako $HomeDir/.config/

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
rm -rf $HomeDir/.themes/*
cp -rf $WorkDir/MCALR/themes/* $HomeDir/.themes/

[ -d "$PatchDir" ] && echo "Applying Patches"
[ -d "$PatchDir/ast" ] && cp -rf $PatchDir/ast/* $DataDir/MCALR/
[ -d "$PatchDir/fastfetch" ] &&  cp -rf $PatchDir/fastfetch $HomeDir/.config/
[ -d "$PatchDir/hypr" ] && cp -rf $PatchDir/hypr $HomeDir/.config/
[ -d "$PatchDir/kitty" ] && cp -rf $PatchDir/kitty $HomeDir/.config/
[ -d "$PatchDir/waybar" ] && cp -rf $PatchDir/waybar $HomeDir/.config/
[ -d "$PatchDir/fish" ] && cp -rf $PatchDir/fish $HomeDir/.config/
[ -d "$PatchDir/rofi" ] && cp -rf $PatchDir/rofi $HomeDir/.config/
[ -d "$PatchDir/mako" ] && cp -rf $PatchDir/mako $HomeDir/.config/

hyprctl reload > /dev/null
bash ~/.config/hypr/change-theme.sh -c w
clear
echo " "
echo "────────────────────────────────────────────────────"
cat $WorkDir/MCALR/version
echo "────────────────────────────────────────────────────"
echo " "
rm -rf $WorkDir/MCALR
