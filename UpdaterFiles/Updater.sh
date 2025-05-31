#!/bin/bash
WorkDir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
echo "Fetching new version of MCALR"
git clone -q https://github.com/M-UnityDev/MCALR.git $WorkDir/MCALR
HomeDir=$HOME
PatchDir=$WorkDir/Patches
echo "Updating shared assets folder" 
rm -rf $XDG_DATA_HOME/MCALR
cp -rf $WorkDir/MCALR/ast/* $XDG_DATA_HOME/MCALR/
echo "Updating fastfetch config"
rm -rf $HomeDir/.config/fastfetch
cp -rf $WorkDir/MCALR/fastfetch $HomeDir/.config/
echo "Updating hyprland configs"
rm -rf $HomeDir/.config/hypr
cp -rf $WorkDir/MCALR/hypr $HomeDir/.config/
echo "Updating wlogout config"
rm -rf $HomeDir/.config/wlogout
cp -rf $WorkDir/MCALR/wlogout $HomeDir/.config/
echo "Updating kitty config"
rm -rf $HomeDir/.config/kitty
cp -rf $WorkDir/MCALR/kitty $HomeDir/.config/
echo "Updating waybar config"
rm -rf $HomeDir/.config/waybar
cp -rf $WorkDir/MCALR/waybar $HomeDir/.config/
echo "Updating fish config"
rm -rf $HomeDir/.config/fish
cp -rf $WorkDir/MCALR/fish $HomeDir/.config/
echo "Updating wofi config"
rm -rf $HomeDir/.config/wofi
cp -rf $WorkDir/MCALR/wofi $HomeDir/.config/
echo "Updating Cursor Themes"
rm -rf $HomeDir/.local/share/icons/cursors/
cp -rf $WorkDir/MCALR/cursors/ $XDG_DATA_HOME/icons/
for theme in "$XDG_DATA_HOME/icons/cursors"/*; do
  if [ -d "$theme" ]; then
    themename=$(basename "$theme")
    ln -sf "$theme" "$XDG_DATA_HOME/icons/$themename"
  fi
done
echo "Updating pcmanfm actions"
rm -rf $HomeDir/.local/share/file-manager
cp -rf $WorkDir/MCALR/file-manager $XDG_DATA_HOME
echo "Updating themes"
rm -rf $HomeDir/.themes/*
cp -rf $WorkDir/MCALR/themes/* $HomeDir/.themes/
[ -d "$PatchDir" ] && echo "Applying Patches"
[ -d "$PatchDir/ast" ] && cp -rf $PatchDir/ast/* $XDG_DATA_HOME/MCALR/
[ -d "$PatchDir/fastfetch" ] &&  cp -rf $PatchDir/fastfetch $HomeDir/.config/
[ -d "$PatchDir/hypr" ] && cp -rf $PatchDir/hypr $HomeDir/.config/
[ -d "$PatchDir/fastfetch" ] && cp -rf $PatchDir/fastfetch $HomeDir/.config/
[ -d "$PatchDir/wlogout" ] && cp -rf $PatchDir/wlogout $HomeDir/.config/
[ -d "$PatchDir/kitty" ] && cp -rf $PatchDir/kitty $HomeDir/.config/
[ -d "$PatchDir/waybar" ] && cp -rf $PatchDir/waybar $HomeDir/.config/
[ -d "$PatchDir/fish" ] && cp -rf $PatchDir/fish $HomeDir/.config/
[ -d "$PatchDir/wofi" ] && cp -rf $PatchDir/wofi $HomeDir/.config/
hyprctl reload > /dev/null
echo " "
echo "﹍﹍﹍﹍﹍"
cat $WorkDir/MCALR/version
echo "﹉﹉﹉﹉﹉"
echo " "
rm -rf $WorkDir/MCALR
