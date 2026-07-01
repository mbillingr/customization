-- Programs
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "wofi --show drun"
local mainMod = "SUPER"

-- Monitors

-- Builtin Display
hl.monitor({
  output = "desc:California Institute of Technology 0x160D",
  mode = "preferred",
  position = "0x0",
  scale = 1,
})

hl.monitor({
  output = "desc:LG Display 0x056F",
  mode = "preferred",
  position = "0x0",
  scale = 1.5,
})

-- Mareike Dock
hl.monitor({
  output = "desc:Dell Inc. DELL P2319H B6QV623",
  mode = "preferred",
  position = "3840x0",
  scale = 1,
})

hl.monitor({
  output = "desc:Dell Inc. DELL P2319H 16QV623",
  mode = "preferred",
  position = "1920x0",
  scale = 1,
})

-- Fallback Default
hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = 1,
})

-- Environment
hl.env("XCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- Startup
hl.on("hyprland.start", function()
  hl.exec_cmd("waybar")
  hl.exec_cmd("hyprpaper")
  --hl.exec_cmd("wvkbd-mobintl")
end)

hl.config({
  -- Input
  input = {
    kb_layout = "us",
    kb_variant = "dpe",
    kb_model = "",
    kb_options = "lv3:ralt_switch",
    kb_rules = "",

    follow_mouse = 1,

    touchpad = {
      natural_scroll = true,
    },

    sensitivity = 0,
  },

  -- General
  general = {
    gaps_in = 0,
    gaps_out = 5,
    border_size = 2,
    col = {
      active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45},
      inactive_border = "rgba(595959aa)",
    },

    layout = "dwindle",

    allow_tearing = false,
  },

  -- Decoration
  decoration = {
    rounding = 10,

    blur = {
      enabled = true,
      size = 3,
      passes = 1,
      vibrancy = 0.1696,
    },

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgba(1a1a1aee)",
    },
  },

  -- Animations
  animations = {
    enabled = true,

    bezier = {
      "myBezier, 0.05, 0.9, 0.1, 1.05",
    },

    animation = {
      "windows, 1, 7, myBezier",
      "windowsOut, 1, 7, default, popin 80%",
      "border, 1, 10, default",
      "borderangle, 1, 8, default",
      "fade, 1, 7, default",
      "workspaces, 1, 6, default",
    },
  },

  -- Dwindle layout
  dwindle = {
    preserve_split = true,
  },

  -- Master layout
  master = {
    new_status = "master",
  },

  -- Misc
  misc = {
    force_default_wallpaper = -1,
    disable_splash_rendering = true,
    disable_hyprland_logo = false,
  },

})

-- Window rules

-- Ignore maximize requests from apps.
hl.window_rule({
  match = {
    class = ".*",
  },
  suppress_event = "maximize",
})

-- Attempt to fix tooltip flicker in MS Edge browser.
hl.window_rule({
  match = {
    class = "^()$",
    title = "^()$",
    initial_class = "^()$",
    initial_title = "^()$",
  },
  no_initial_focus = true,
  float = true,
  move = "cursor_x cursor_y",
})

-- App binds
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Switch workspaces with mainMod + F1-F10
hl.bind(mainMod .. " + F1", hl.dsp.focus({ workspace = "1" }))
hl.bind(mainMod .. " + F2", hl.dsp.focus({ workspace = "2" }))
hl.bind(mainMod .. " + F3", hl.dsp.focus({ workspace = "3" }))
hl.bind(mainMod .. " + F4", hl.dsp.focus({ workspace = "4" }))
hl.bind(mainMod .. " + F5", hl.dsp.focus({ workspace = "5" }))
hl.bind(mainMod .. " + F6", hl.dsp.focus({ workspace = "6" }))
hl.bind(mainMod .. " + F7", hl.dsp.focus({ workspace = "7" }))
hl.bind(mainMod .. " + F8", hl.dsp.focus({ workspace = "8" }))
hl.bind(mainMod .. " + F9", hl.dsp.focus({ workspace = "9" }))
hl.bind(mainMod .. " + F10", hl.dsp.focus({ workspace = "10" }))

-- Move active window to a workspace with mainMod + SHIFT + F1-F10/F11
hl.bind(mainMod .. " + SHIFT + F1", hl.dsp.window.move({ window = "active", workspace = "1" }))
hl.bind(mainMod .. " + SHIFT + F2", hl.dsp.window.move({ window = "active", workspace = "2" }))
hl.bind(mainMod .. " + SHIFT + F3", hl.dsp.window.move({ window = "active", workspace = "3" }))
hl.bind(mainMod .. " + SHIFT + F4", hl.dsp.window.move({ window = "active", workspace = "4" }))
hl.bind(mainMod .. " + SHIFT + F5", hl.dsp.window.move({ window = "active", workspace = "5" }))
hl.bind(mainMod .. " + SHIFT + F6", hl.dsp.window.move({ window = "active", workspace = "6" }))
hl.bind(mainMod .. " + SHIFT + F7", hl.dsp.window.move({ window = "active", workspace = "7" }))
hl.bind(mainMod .. " + SHIFT + F8", hl.dsp.window.move({ window = "active", workspace = "8" }))
hl.bind(mainMod .. " + SHIFT + F9", hl.dsp.window.move({ window = "active", workspace = "9" }))
hl.bind(mainMod .. " + SHIFT + F11", hl.dsp.window.move({ window = "active", workspace = "10" }))

-- Special workspace / scratchpad
--hl.bind(mainMod .. " + S", hl.dsp.raw("togglespecialworkspace magic"))
--hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ window = "active", workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screen brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s +5%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"))

-- Keyboard backlight
hl.bind("xf86KbdBrightnessUp", hl.dsp.exec_cmd("brightnessctl -d *::kbd_backlight set +33%"))
hl.bind("xf86KbdBrightnessDown", hl.dsp.exec_cmd("brightnessctl -d *::kbd_backlight set 33%-"))

-- Volume and Media Control
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pamixer --default-source -m"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- Screenshot
hl.bind("Print", hl.dsp.exec_cmd("slurp | grim -g - - | wl-copy"))

