#!/bin/bash
# /etc/acpi/handler.sh
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
                    logger "LID closed"
                    # brightness="$(mktemp /tmp/lid-brightness.XXXXXXXXXX)"
                    brightness="/tmp/lid-brightness"
                    touch "$brightness"
                    logger "Temporally save current brightness in $brightness"
                    printf "%s" "$(xbacklight -get)" > "$brightness"
                    xbacklight -set 0
                    logger "Set brightness 0"
                    ;;
            open)
                    brightness="/tmp/lid-brightness"
                    logger "LID opened"
                    if [ -f "$brightness" ]; then
                            logger "Found $brightness"
                            read -r val < "$brightness"
                            xbacklight -set "$val"
                            rm "$brightness"
                            logger "Restore brightness to $val, and remove $brightness"
                    else
                            default=10
                            logger "Could not find /tmp/lid-brightness.*. Set brightness $default."
                            xbacklight -set "$default"
                    fi
                    ;;
            *)
                    logger "ACPI action undefined: $3"
                    logger "Set backlight brightness 10, to avoid the case of display off"
                    xbacklight -set 10
                    ;;
        esac
        ;;
    jack/headphone)
        case "$3" in
            plug)
                    notify-users "[acpid]jack/headphone" "🎧 Plugged in" -u low
                    info="$(sudo -u '#1000' XDG_RUNTIME_DIR=/run/user/1000 pactl list sinks)"
                    sink="$(printf "%s" "$info" | grep -P 'Sink #')"
                    sink="${sink#*#}"
                    logger "Sink is $sink"
                    vol="$(printf "%s" "$info" | grep -oP '\d+%' | awk 'NR==1 {print $1}')"
                    logger "Current volumn: $vol"
                    sudo -u '#1000' XDG_RUNTIME_DIR=/run/user/1000 pactl set-sink-port "$sink" analog-output-headphones
                    logger "Set sink $sink to 'analog-output-headphones'"
                    sudo -u '#1000' XDG_RUNTIME_DIR=/run/user/1000 pactl set-sink-volume "$sink" "$vol"
                    logger "Restore volumn level to $vol"
                    ;;
            unplug)
                    notify-users "[acpid]jack/headphone" "🎧 Plugged out" -u low
                    ;;
            *)
                    logger "ACPI action undefined: $3"
                    ;;
        esac
        ;;
    *)
        logger "ACPI group/action undefined: $1 / $2 / $3"
        ;;
esac

# vim:set ts=4 sw=4 ft=sh et:
