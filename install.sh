#!/bin/sh -eu

MY_PATH="$( cd "$(dirname "${0}")" ; pwd -P )"

ln -sf "${MY_PATH}/git/gitconfig" "${HOME}/.gitconfig"

if [ ! -d "${HOME}/.config/sublime-text-3/Packages/User" ]; then
	mkdir -p "${HOME}/.config/sublime-text-3/Packages/User"
fi
ln -sf "${MY_PATH}/sublime/Default (Linux).sublime-keymap" "${HOME}/.config/sublime-text-3/Packages/User/Default (Linux).sublime-keymap"

ln -sf "${MY_PATH}/sublime/Preferences.sublime-settings" "${HOME}/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"

ln -sf "${MY_PATH}/sublime/Package Control.sublime-settings" "${HOME}/.config/sublime-text-3/Packages/User/Package Control.sublime-settings"

