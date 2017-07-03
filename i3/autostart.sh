#!/bin/sh

########################################################################################
#
# Config
#
########################################################################################


#
# Where to log autostarted programs?
#
_MY_LOGPATH="${HOME}/.log"

#
# Background Image path
#
_MY_WALLPAPER="${HOME}/Pictures/Firefox_wallpaper.png"



# Force openoffice.org to use GTK theme
# enable this if you install openoffice
export OOO_FORCE_DESKTOP=gnome
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK


########################################################################################
#
# Wrapper
#
########################################################################################

_log() {
	_lvl="${1}"
	_msg="${2}"
	_log="${_MY_LOGPATH}/log.log"
	_pre="$( date +'%Y-%m-%d  %H:%M:%S' )"

	if [ ! -d "${_MY_LOGPATH}" ]; then
		mkdir -p "${_MY_LOGPATH}"
	fi

	case "${_lvl}" in
		err)
			printf "[%s] [ERROR]:   %s\n" "${_pre}" "${_msg}" >> "${_log}"
			;;
		warn)
			printf "[%s] [WARN]:    %s\n" "${_pre}" "${_msg}" >> "${_log}"
			;;
		info)
			printf "[%s] [INFO]:    %s\n" "${_pre}" "${_msg}" >> "${_log}"
			;;
		*)
			printf "[%s] [UNKNOWN]: %s\n" "${_pre}" "${_msg}" >> "${_log}"
			;;
	esac
}

#
# Wrapper to start stuff with logging
# and pre-killing functionality
#
# @param string	$1	Full command (including arguments)
# @param string	$2	If not empty: logfile name for logging
#					If empty: Nothing will be logged
# @param string	$3	If not empty: Name of process to kill prior starting
#					if empty: Nothing will be killed
_execute() {
	_cmd="${1}"
	_name="${2}"
	_kill="${3}"

	_log="${_MY_LOGPATH}/log.log"


	if [ ! -d "${_MY_LOGPATH}" ]; then
		mkdir -p "${_MY_LOGPATH}"
	fi

	# Do we need to kill something
	# before starting?
	if [ "${_kill}" != "" ]; then
		_log "info" "Trying to kill ${_kill}"

		if ! _pid="$( pidof "${_kill}" )"; then
			_log "err" "No pid found for ${_kill}"
		else
			if ! kill "${_pid}"; then
				_log "err" "Could not kill pid: ${_pid} for ${_kill}"
			else
				_log "info" "Killed ${_kill} with pid: ${_pid}"
			fi
		fi
	fi

	_log "info" "starting: ${_cmd}"

	# Do we do logging?
	if [ "${_name}" != "" ]; then
		eval "${_cmd} > ${_MY_LOGPATH}/${_name}.log 2> ${_MY_LOGPATH}/${_name}.err &"
	else
		eval "${_cmd} > /dev/null 2>&1 &"
	fi
}



########################################################################################
#
# Exports
#
########################################################################################






########################################################################################
#
# Devices
#
########################################################################################


## Turn on/off annoying system beep
_execute "xset b off" "xset-b"

## Set keyboard settings - 250 ms delay and 25 cps (characters per second) repeat rate.
## Adjust the values according to your preferances.
# KEYBOARD_RATE=60
# KEYBOARD_DELAY=250
_execute "xset r rate 250 40" "xset-r"





########################################################################################
#
# User Daemons
#
########################################################################################


## Keyring
#_execute "gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh" "gnome-keyring-daemon" "gnome-keyring-daemon"


## Power Management (TASKBAR-ICON)
#_execute "xfce4-power-manager" "xfce4-power-manager" "xfce4-power-manager"


## Clipboard (TASKBAR-ICON)
#xfce4-clipman &


## Keyboard Input (TASKBAR-ICON)
#_execute "ibus-daemon --replace --restart --desktop=openbox --xim --daemonize" "ibus-daemon" "ibus-daemon"


## Start auto-lock
#_execute "xautolock -detectsleep -time 5 -locker '~/.config/i3/bin/i3exit lock' -notify 15 -notifier \"notify-send -u critical -t 10000 -- 'Locking screen in 15 sec'\"" "xautolock" "xautolock"


#gnome-settings-daemon &

#eval "$( dbus-launch --sh-syntax --exit-with-session )"



########################################################################################
#
# Panel / Applets
#
########################################################################################


## Volume Icon Applet (TASKBAR-ICON)
#_execute "volumeicon" "volumeicon" "volumeicon"


## Notes / Tasks / Timetracking (TASKBAR-ICON)
#_execute "xpad --show" "xpad" "xpad"


## Network Manager Applet (TASKBAR-ICON)
_execute "nm-applet" "nm-applet" "nm-applet"


## Bluetooth Manager Applet (TASKBAR-ICON)
#_execute "blueman-applet" "blueman-applet" "blueman-applet"

## Redshift screen
#_execute "redshift-gtk" "redshift-gtk" "redshift"






########################################################################################
#
# Applications
#
########################################################################################


## Filemanager Daemon (for auto-mounts
_execute "thunar --daemon" "thunar"


## urxvt Daemon
#urxvtd &

## Quake Terminal
#_execute "guake --hide" "guake" "guake"




########################################################################################
#
# Eye Candy
#
########################################################################################


## Wallpaper
_execute "feh --no-fehbg --bg-scale ${_MY_WALLPAPER}" "feh"


## Conky
#(conky -c ~/.conky/conkyrc) &


## Compositor
_execute "compton -b --config ~/.config/compton/compton.conf" "compton" "compton"
#_execute "compton -b " "compton" "compton"




## Notification daemon hack
# TODO: fix to make it autostart properly via dbus
#_execute "/usr/lib/notify-osd/notify-osd" "notify-osd" "notify-osd"

_execute "dunst" "dunst" "dunst"
