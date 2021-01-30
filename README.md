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
* rich\_markdown
* grub-update

## Additional settings
**crontab (dcron)**
```
	# MIN HOUR DAY MONTH DAYOFWEEK  COMMAND
	# Change background every 15 minutes
	*/3 * * * * DISPLAY=:0 XAUTHORITY=$HOME/.Xauthority $HOME/.local/bin/chbg
	0 12,17-24 * * * /usr/bin/newsboat -x reload && /usr/bin/polybar-msg hook newsboat 1
	0 * * * * DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send -t 3000 '👀 Peek outside'
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
	HandlePowerKey=suspend
	HandleLidSwitch=ignore
	HandleLidSwitchExternalPower=ignore
	LidSwitchIgnoreInhibited=no
```

**acpilight**  
`/etc/acpi/events/handler.sh`

**visudo**
```
%wheel ALL=(ALL) NOPASSWD: /usr/bin/bluetooth,/usr/bin/wifi,/usr/bin/tlp-stat
seongbin ALL=(ALL) NOPASSWD: /home/seongbin/.local/bin/dante,/usr/bin/umount /home/seongbin/mnt/byblis,/usr/bin/intel_gpu_top,/usr/bin/surfshark-vpn
```

**brave**  
* Hardware acceleration setting
	- [Archwiki](https://wiki.archlinux.org/index.php/Hardware_video_acceleration)
	- [--use-gl=desktop](https://www.linuxuprising.com/2021/01/how-to-enable-hardware-accelerated.html)

`Extensions`  
* Dark Reader
* Google Translate
* NflxMultiSubs
* Notion Web Clipper
* Session Buddy
* SmoothScroll
	* Step size: 25
	* Animation time: 250
	* Acceleration scale: 2
	* Acceleration delta: 50
	* Pulse Scale: 8
	* Arrow key step size: 50
	* [x] Enable touchpad support
	* [x] Enable pulse algorithm
* Zotero Connector
