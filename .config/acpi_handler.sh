#!/bin/bash
# /etc/acpi/handler.sh
# Default acpi script that takes an entry for all actions

__lock() {
    if pidof -q Hyprland
    then
        if pidof -q waylock
        then
            logger "Waylock is already running"
        else
            logger "Locking screen with waylock"
            XDG_RUNTIME_DIR=/run/user/1000
            WAYLAND_DISPLAY_SOCKET="$(ls /run/user/1000 | grep -e '^wayland-[0-9]$')"
            sudo -u '#1000'  WAYLAND_DISPLAY=$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY_SOCKET waylock -init-color 0xf1fa8c -input-color 0xbd93f9 -fail-color 0xff79c6 &
        fi
    else
        # id=$(pgrep -t tty$(fgconsole) xinit)
        # pid=$(pgrep -P $pid -n)

        # import_environment() {
        #         (( pid )) && for var; do
        #                 IFS='=' read key val < <(egrep -z "$var" /proc/$pid/environ)

        #                 printf -v "$key" %s "$val"
        #                 [[ ${!key} ]] && export "$key"
        #         done
        # }

        # import_environment XAUTHORITY USER DISPLAY
        /usr/bin/xset dpms force suspend
        # brightness="/tmp/lid-brightness"
        # touch "$brightness"
        # logger "Temporally save current brightness in $brightness"
        # printf "%s" "$(xbacklight -get)" > "$brightness"
        # xbacklight -set 0
        # logger "Set brightness 0"
    fi
}

case "$1" in
    button/power)
        case "$2" in
            PBTN|PWRF)
                logger '[button/power] PowerButton pressed'
                ;;
            LNXPWRBN:00)
                logger '[button/power] PowerButton (LNXPWRBN:00) pressed'
                if [ "$3" = "00000080" ]
                then
                    __lock
                fi
                ;;
            *)
                logger "[button/power] ACPI action undefined: $2"
                ;;
        esac
        ;;
    button/sleep)
        case "$2" in
            SLPB|SBTN)
                logger '[button/sleep] SleepButton pressed'
                ;;
            *)
                logger "[button/sleep] ACPI action undefined: $2"
                ;;
        esac
        ;;
    ac_adapter)
        case "$2" in
            AC|ACAD|ADP0)
                case "$4" in
                    00000000)
                        logger '[ac_adapter] AC unpluged'
                        ;;
                    00000001)
                        logger '[ac_adapter] AC pluged'
                        ;;
                esac
                ;;
            *)
                logger "[ac_adapter] ACPI action undefined: $2"
                ;;
        esac
        ;;
    battery)
        case "$2" in
            BAT0)
                case "$4" in
                    00000000)
                        logger '[battery] Battery online'
                        ;;
                    00000001)
                        logger '[battery] Battery offline'
                        ;;
                esac
                ;;
            CPU0)
                ;;
            *)  logger "[battery] ACPI action undefined: $2" ;;
        esac
        ;;
    button/lid)
        case "$3" in
            close)
                logger "[button/lid] LID closed"
                # brightness="$(mktemp /tmp/lid-brightness.XXXXXXXXXX)"
                __lock
                ;;
            open)
                logger "[button/lid] LID opened"
                # brightness="/tmp/lid-brightness"
                # if [ -f "$brightness" ]; then
                #     logger "Found $brightness"
                #     read -r val < "$brightness"
                #     xbacklight -set "$val"
                #     rm "$brightness"
                #     logger "Restore brightness to $val, and remove $brightness"
                # else
                #     default=10
                #     logger "Could not find /tmp/lid-brightness.*. Set brightness $default."
                #     xbacklight -set "$default"
                # fi
                if pidof Hyprland
                then
                    logger "Hyprland is running. Ignoring ACPI rule"
                else
                    logger 'Activate screen lock'
                    DISPLAY=:0 su -c - "$(id -nu 1000)" /usr/local/bin/slock
                fi
                ;;
            *)
                logger "[button/lid] ACPI action undefined: $3"
                if pidof Hyprland
                then
                    logger "Hyprland is running. Ignoring ACPI rule"
                else
                    logger "Set backlight brightness 10, to avoid the case of display off"
                    xbacklight -set 10
                fi
                ;;
        esac
        ;;
    jack/headphone)
        case "$3" in
            plug)
                logger '[jack/headphone] Headphone is plugged in'
                notify-users -u low "[acpid]jack/headphone" "🎧 Plugged in"
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
                logger '[jack/headphone] Headphone is plugged out'
                notify-users -u low "[acpid]jack/headphone" "🎧 Plugged out"
                ;;
            *)
                logger "[jack/headphone] ACPI action undefined: $3"
                ;;
        esac
        ;;
    *)
        logger "ACPI group/action undefined: $1 / $2 / $3"
        ;;
esac

# vim:set ts=4 sw=4 ft=sh et:
