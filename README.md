# .config from Arch distro
## .@~
* .profile
* .inputrc
* .xinitrc
* .Xresources
* .bashrc
* .bash\_aliases
* .condarc
* .ssh/config

## .config
* nvim
* i3
* i3blocks
* dunst
* ranger
* lf
* vpn
* mpv
* polybar
* hosts

## .local/bin
* chbg
* dante
* rclone-zotero
* unix
* vim
* dmenu\_run2
* playsound
* timer
* poweroff
* reboot

## Additional settings
**crontab**
```
	# MIN HOUR DAY MONTH DAYOFWEEK  COMMAND
	# Change background every 15 minutes
	*/15 * * * * DISPLAY=:0 XAUTHORITY=$HOME/.Xauthority $HOME/.local/bin/chbg
```

**TLP**
```
	USB_AUTOSUSPEND=1 # default
	USB_BLACKLIST="0bda:8153"
	USB_AUTOSUSPEND_DISABLE_ON_SHUTDOWN=1
	DEVICES_TO_DISABLE_ON_STARTUP="bluetooth"
```

**logind.conf.d/override.conf**
```
[Login]
	#NAutoVTs=6
	#ReserveVT=6
	#KillUserProcesses=no
	#KillOnlyUsers=
	#KillExcludeUsers=root
	#InhibitDelayMaxSec=5
	HandlePowerKey=suspend
	#HandleSuspendKey=suspend
	#HandleHibernateKey=hibernate
	HandleLidSwitch=ignore
	HandleLidSwitchExternalPower=ignore
	#HandleLidSwitchDocked=ignore
	#PowerKeyIgnoreInhibited=no
	#SuspendKeyIgnoreInhibited=no
	#HibernateKeyIgnoreInhibited=no
	LidSwitchIgnoreInhibited=no
	#HoldoffTimeoutSec=30s
	#IdleAction=ignore
	#IdleActionSec=30min
	#RuntimeDirectorySize=10%
	#RemoveIPC=yes
	#InhibitorsMax=8192
	#SessionsMax=8192
```

**acpilight**
`/etc/acpi/events/handler.sh`
