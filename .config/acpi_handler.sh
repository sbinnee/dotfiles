#!/bin/bash
# Default acpi script that takes an entry for all actions

case "$1" in
    button/power)
        case "$2" in
            PBTN|PWRF)
                logger 'PowerButton pressed'
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    button/sleep)
        case "$2" in
            SLPB|SBTN)
                logger 'SleepButton pressed'
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    ac_adapter)
        case "$2" in
            AC|ACAD|ADP0)
                case "$4" in
                    00000000)
                        logger 'AC unpluged'
                        ;;
                    00000001)
                        logger 'AC pluged'
                        ;;
                esac
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    battery)
        case "$2" in
            BAT0)
                case "$4" in
                    00000000)
                        logger 'Battery online'
                        ;;
                    00000001)
                        logger 'Battery offline'
                        ;;
                esac
                ;;
            CPU0)
                ;;
            *)  logger "ACPI action undefined: $2" ;;
        esac
        ;;
    button/lid)
        case "$3" in
            close)
		logger 'LID closed'
		# brightness=$(mktemp /tmp/lid-brightness.XXXXXXXXXX)
		brightness='/tmp/lid-brightness'
		touch $brightness
		logger "Temporally save current brightness in $brightness"
		echo $(xbacklight -get) > $brightness
		xbacklight -set 0
		logger 'Set brightness 0'
                ;;
            open)
		brightness='/tmp/lid-brightness'
		logger 'LID opened'
		if [ -f $brightness ]; then
			logger "Found $brightness"
			val=$(cat $brightness)
			xbacklight -set $val
			rm $brightness
			logger "Restore brightness to $val, and remove $brightness"
		else
			logger 'Could not find /tmp/lid-brightness.*. Set brightness 30.'
			xbacklight -set 30
		fi
		;;
	    *)
		logger "ACPI action undefined: $3"
		logger "Set backlight brightness 10, to avoid the case of display off"
		xbacklight -set 10
		;;
	esac
	;;
    *)
        logger "ACPI group/action undefined: $1 / $2"
        ;;
esac

# vim:set ts=4 sw=4 ft=sh et:
