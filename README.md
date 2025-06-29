# Dotfiles
My dotfiles for
* Linux X11
* Linux Wayland
* macos (branch: `macos`)
* server (branch: `server`)

Main configs are all based on my Linux machine, currently using Wayland protocol and
[Hyprland] compositor as a daily driver. Both `macos` and `server` branches are always
rebased onto `master` branch.


## Installation
For Linux setup, I lost track of tools I have installed on my system, but the program
list below should be complete enough. FYI, I have been using the same [Arch Linux]
installation probably since 2019.

For server setup, I simply use the ricing script.

For macos setup, I am working on the ricing script.

> [!IMPORTANT]
> Some programs may need manual compilation and installation, and manual update
> afterwards.

### Common
- [nvim]: "hyperextensible Vim-based text editor"

- [fzf]: "general-purpose command-line fuzzy finder"

- [rg]: "ripgrep is a line-oriented search tool that recursively searches the current directory for a regex pattern"

- [fd]: "A simple, fast and user-friendly alternative to 'find'"

- [par]: "par is a paragraph reformatter, vaguely similar to fmt, but better."

- [delta]: "A syntax-highlighting pager for git, diff, grep, and blame output"

- [lf]: "a terminal file manager written in Go with a heavy inspiration from ranger file manager"

- [bat]: "A cat(1) clone with wings"

- [mpv]: "a free, open source, and cross-platform media player"

- [uv]: "An extremely fast Python package and project manager, written in Rust."

    The `uv tool` command turns out to be an excellent alternative to pipx, meaning it
    can install and manage Python program on system level with good isolation. Also,
    Python is my main programming language.

    * [yt-dlp]: "A feature-rich command-line audio/video downloader"

        a.k.a. YouTube downloader, written in Python. I use it to achieve videos or to watch
        a video live with [mpv]. I used to use the Arch's package manager to install it, but
        I didn't like it because it touches system Python pkgs. Then, I tried [pipx]. Then, at
        the moment, [uv].

    * [tqdm]: progress bar

- [ts]: "task spooler is a Unix batch system where the tasks spooled run one after the other"

    This one has a few forks. The original ts is feature-complete, totally functioning.
    But for server machines, I use a fork ([this one](https://github.com/justanhduc/task-spooler))
    that has GPU-selection capability.

- (optional) [viddy]: "A modern watch command. Time machine and pager etc."

- (optional) [btm]: "Yet another cross-platform graphical process/system monitor"

### Linux setup
- [dmenu](https://tools.suckless.org/dmenu/)

    For Linux setup. I applied some patches. Find my dmenu [in this repo](https://github.com/sbinnee/dmenu).

- [picom](https://github.com/ibhagwan/picom)

    X11 compositor. Choosing a X11 compositor took me a lot of time. This compositor
    has solid support for enabling transparency and blur.

- [hosts](https://github.com/StevenBlack/hosts)
- [acpilight](https://gitlab.com/wavexx/acpilight)


#### Linux X11 setup

#### Linux Wayland setup
- [Hyprland]

- [wdisplays]


### MacOS setup
- [wezterm]



## Additional settings
**crontab (dcron)**
```
# MIN HOUR DAY MONTH DAYOFWEEK  COMMAND
# Change background every 15 minutes
#*/10 * * * * DISPLAY=:0 XAUTHORITY=$HOME/.Xauthority XDG_RUNTIME_DIR=/run/user/1000 $HOME/.local/bin/chbg
0 17-24 * * * /usr/bin/newsboat -x reload
#0 17-24 * * * /usr/bin/newsboat -x reload && /usr/bin/polybar-msg hook newsboat 1
#0 * * * * $HOME/.local/bin/notify-users -u critical "👀 Peek outside" && paplay --server=unix:/run/user/1000/pulse/native /usr/share/sounds/freedesktop/stereo/bell.oga
```

**logind.conf.d/override.conf**

Power switch behaviors `/etc/systemd/logind.conf.d/override.conf`
```
[Login]
HandlePowerKey=suspend
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
LidSwitchIgnoreInhibited=no
```

**libinput**

Enable touchpad while typing `/usr/share/X11/xorg.conf.d/41-libinput.conf`
```
Section "InputClass"
  Identifier "libinput touchpad catchall"
  MatchDriver "libinput"
  MatchIsTouchpad "on"
  Option "Disable While Typing" "off"
EndSection
```


<!-- Links -->
[Arch Linux]: https://archlinux.org/
[Hyprland]: https://hyprland.org/
[nvim]: https://neovim.io/
[fzf]: https://github.com/junegunn/fzf
[rg]: https://github.com/BurntSushi/ripgrep
[fd]: https://github.com/sharkdp/fd
[par]: http://www.nicemice.net/par/
[delta]: https://github.com/dandavison/delta
[lf]: https://github.com/gokcehan/lf
[bat]: https://github.com/sharkdp/bat
[mpv]: https://mpv.io/
[uv]: https://github.com/astral-sh/uv
[pipx]: https://github.com/pypa/pipx
[yt-dlp]: https://github.com/yt-dlp/yt-dlp
[ts]: https://viric.name/soft/ts/
[viddy]: https://github.com/sachaos/viddy
[bottom]: https://github.com/ClementTsang/bottom


[wdisplays]: https://github.com/artizirk/wdisplays
