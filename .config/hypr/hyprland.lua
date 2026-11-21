-- Hyprland configuration (Lua)
-- Migrated from hyprland.conf. Requires Hyprland >= 0.55.0 for Lua configs.
-- Docs: https://wiki.hypr.land/Configuring/

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("~/.config/hypr/startup &")
end)

------------------------------
---- ENVIRONMENT VARIABLES ----
------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("DMENU", "bemenu")
hl.env("SUDO_ASKPASS", os.getenv("HOME") .. "/.local/bin/bemenupass")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    misc = {
        disable_hyprland_logo = true,
    },

    cursor = {
        inactive_timeout = 3,
    },

    general = {
        gaps_in     = 3,
        gaps_out    = 3,
        border_size = 3,

        col = {
            active_border   = { colors = { "rgba(e970faee)", "rgba(fad670ee)" }, angle = 25 },
            inactive_border = "rgba(595959aa)",
        },

        layout            = "dwindle",
        no_focus_fallback = true,
    },

    binds = {
        workspace_back_and_forth = 0,
        allow_workspace_cycles   = true,
    },

    decoration = {
        rounding = 5,

        blur = {
            enabled           = true,
            size              = 3,
            passes            = 1,
            new_optimizations = true,
        },

        shadow = {
            enabled      = false,
            range        = 4,
            render_power = 1,
            color        = "rgba(1a1a1aee)",
        },

        dim_special = 0,
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    gestures = {
        workspace_swipe_touch = false,
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "korean,korean:ralt_hangul",
        kb_rules   = "",

        follow_mouse = 1,

        touchpad = {
            natural_scroll = false,
            scroll_factor  = 0.5,
            tap_to_click   = false,
        },

        sensitivity  = 0,
        repeat_rate  = 40,
        repeat_delay = 330,
    },
})

-------------------
---- ANIMATIONS ----
-------------------

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

---------------------
---- PER-DEVICE -----
---------------------

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"
local browser = "firefox"

-- [window]
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("foot"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("~/.config/hypr/_exit"))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.float())

-- Move focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + O", function()
    hl.dispatch(hl.dsp.window.cycle_next({ floating = true }))
    hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end)

-- Swap
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "down" }))

hl.bind(mainMod .. " + left",  hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + right", hl.dsp.layout("togglesplit"))

-- Move windows
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + C", hl.dsp.window.center())

-- Resize
hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })

-- etc
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

-- [workspace]
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(mainMod .. " + GRAVE", hl.dsp.focus({ workspace = "previous" }))
hl.bind(mainMod .. " + BRACKETLEFT", hl.dsp.exec_cmd("_hypr_prev_workspace"))
hl.bind(mainMod .. " + BRACKETRIGHT", hl.dsp.exec_cmd("_hypr_next_workspace"))
hl.bind(mainMod .. " + CTRL + BRACKETLEFT", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + CTRL + BRACKETRIGHT", hl.dsp.focus({ workspace = "m+1" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true })

-- [launcher]
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("dmenu_run2"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("bemenu-run"))

-- [lock screen]
hl.bind("CTRL + ALT + Q", hl.dsp.exec_cmd("loginctl lock-session"))

-- [dunstctl]
hl.bind("CTRL + Escape", hl.dsp.exec_cmd("dunstctl close"))

hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(browser .. " --private-window"))

-- toggle waybar
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("pkill -10 waybar"))

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("grim"))

-- [lid switch]
hl.bind("switch:Lid Switch", hl.dsp.exec_cmd("_hypr_toggle_dpms"), { locked = true })

hl.bind(mainMod .. " + Backspace", hl.dsp.exec_cmd("chbg"))

-- [Pinned apps]
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("TS_SOCKET=/tmp/socket-ts.$(id -u).signal-term hypr-toggle-app signal"))

-- [Scratchpad]
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("TS_SOCKET=/tmp/socket-ts.$(id -u).ddspawn-scratch tsp hypr_ddspawn_scratch toggle"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("TS_SOCKET=/tmp/socket-ts.$(id -u).ddspawn-scratch tsp hypr_ddspawn_scratch NOTE"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("TS_SOCKET=/tmp/socket-ts.$(id -u).ddspawn-scratch tsp hypr_ddspawn_scratch LF"))
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("TS_SOCKET=/tmp/socket-ts.$(id -u).ddspawn-scratch tsp hypr_ddspawn_scratch TERM"))

-- newsboat
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("TS_SOCKET=/tmp/socket-ts.$(id -u).ddspawn-newsboat tsp hypr_ddspawn news newsboat 10"))

--------------------
---- WINDOW RULES ----
--------------------

hl.window_rule({ match = { class = ".*" }, opacity = "1.00 0.93" })
hl.window_rule({ match = { class = "foot" }, opacity = "0.97 0.83" })
hl.window_rule({ match = { class = "mpv" }, opacity = "1.00 1.00" })

-- [Pinned apps] signal
hl.window_rule({
    match  = { class = "signal" },
    float  = true,
    pin    = true,
    center = true,
    size   = { "monitor_w*0.5", "monitor_h*0.5" },
})

-- note
hl.window_rule({
    match = { initial_title = "foot-note" },
    float = true,
    pin   = true,
    move  = { "monitor_w-monitor_w*0.33-9", "monitor_h-monitor_h*0.33-9" },
    size  = { "monitor_w*0.33", "monitor_h*0.33" },
})

-- lf
hl.window_rule({
    match  = { initial_title = "foot-term" },
    float  = true,
    pin    = true,
    center = true,
    size   = { "monitor_w*0.45", "monitor_h*0.4" },
})

-- scratch
hl.window_rule({
    match  = { initial_title = "foot-scratch" },
    float  = true,
    pin    = true,
    center = true,
    size   = { "monitor_w*0.45", "monitor_h*0.4" },
})

-- newsboat
hl.window_rule({
    match  = { initial_title = "foot-news" },
    float  = true,
    pin    = true,
    center = true,
    size   = { "monitor_w*0.45", "monitor_h*0.9" },
})

-- zotero:attanger
hl.window_rule({
    match = { initial_class = "Zotero", initial_title = "Progress" },
    float = true,
})
