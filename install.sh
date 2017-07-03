#!/bin/sh -eu

MY_PATH="$( cd "$(dirname "${0}")" ; pwd -P )"

ln -sf "${MY_PATH}/git/gitconfig" "${HOME}/.gitconfig"

if [ ! -d "${HOME}/.config/sublime-text-3/Packages/User" ]; then
	mkdir -p "${HOME}/.config/sublime-text-3/Packages/User"
fi
ln -sf "${MY_PATH}/sublime/Default (Linux).sublime-keymap" "${HOME}/.config/sublime-text-3/Packages/User/Default (Linux).sublime-keymap"

ln -sf "${MY_PATH}/sublime/Preferences.sublime-settings" "${HOME}/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"

ln -sf "${MY_PATH}/sublime/Package Control.sublime-settings" "${HOME}/.config/sublime-text-3/Packages/User/Package Control.sublime-settings"

if [ ! -d "${HOME}/.config/i3" ]; then
        mkdir -p "${HOME}/.config/i3"
fi
ln -sf "${MY_PATH}/i3/config" "${HOME}/.config/i3/config"

ln -sf "${MY_PATH}/i3/i3blocks.conf" "${HOME}/.config/i3/i3blocks.conf"

ln -sf "${MY_PATH}/i3/autostart.sh" "${HOME}/.config/i3/autostart.sh"

if [ ! -d "${HOME}/.config/Xresources.d" ]; then
	mkdir -p "${HOME}/.config/Xresources.d"
fi

ln -sf "${MY_PATH}/X/resources/colors.xresources" "${HOME}/.config/Xresources.d/colors.xresources"

ln -sf "${MY_PATH}/X/resources/fonts.xresources" "${HOME}/.config/Xresources.d/fonts.xresources"

ln -sf "${MY_PATH}/X/resources/rofi.xresources" "${HOME}/.config/Xresources.d/rofi.xresources"

ln -sf "${MY_PATH}/X/resources/urxvt.xresources" "${HOME}/.config/Xresources.d/urxvt.xresources"

ln -sf "${MY_PATH}/X/resources/xft.xresources" "${HOME}/.config/Xresources.d/xft.xresources"
