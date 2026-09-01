-- Window rules wiki https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Generic floating position
hl.window_rule({ match = { float = true }, center = true, persistent_size = true })

-- Picture-in-Picture
hl.window_rule({
    match             = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" },
    float             = true,
    keep_aspect_ratio = true,
    size              = { "max(monitor_w, monitor_h)*0.25", "min(monitor_w, monitor_h)*0.25" },
    pin               = true,
})


-- Gaming
local gamingApps = "^(steam_app.*|steam_proton|gamescope)$"
local gamingWorkspace = "name:gaming"

-- Wszystko już oznaczone jako gra -> gaming workspace
hl.window_rule({
    match = { content = "game" },
    workspace = gamingWorkspace,
})

-- Gry oznaczone przez xdg_tag
hl.window_rule({
    match = {
        xdg_tag = "^(.*game.*)$",
    },
    workspace = gamingWorkspace,
    fullscreen_state = 2,
    content = "game",
    sync_fullscreen = true,
})

-- Standardowe gry Steam / Gamescope
hl.window_rule({
    match = {
        class = gamingApps,
    },
    workspace = gamingWorkspace,
})

-- Steam Friends List
hl.window_rule({
    match = {
        class = "^(steam)$",
        title = "^(Friends List)$",
    },
    float = true,
})

-- Steam launching popup
hl.window_rule({
    match = {
        class = "^(steam)$",
        title = "^(Launching\\.{3})$",
    },
    float = true,
    center = true,
    workspace = gamingWorkspace,
})

-- Właściwe okna gier Steam / Gamescope
hl.window_rule({
    match = {
        class = gamingApps,
        title = "^(.+)$",
        initial_title = "negative:^(.*\\\\home\\\\.*)$",

    },

    content = "game",
    decorate = false,
    fullscreen_state = 2,
    size = { "monitor_w", "monitor_h" },
    sync_fullscreen = true,
    idle_inhibit = "always",
})

-- Puste okna startowe Steam
hl.window_rule({
    match = {
        class = "^(steam_app.*)$",
        initial_title = "^$",
    },

    center = true,
    float = true,
    fullscreen = false,
    fullscreen_state = 0,
    workspace = gamingWorkspace,
})


hl.window_rule({
    name = "jingliu-splash",
    match = {
        class = "^org\\.qt-project\\.qml$",
    },
    float = true,
    pin = true,
    size = { "monitor_w", "monitor_h" },
    move = { "0", "0" },
    border_size = 0,
    rounding = 0,
})

-- Apps
hl.window_rule({ match = { class = "^(.*\\.exe)$", float = true }, monitor = PRIMARY_MONITOR, center = true, fullscreen_state = 0 })
hl.window_rule({ match = { class = "^(.*[Ll]auncher.*)$" }, float = true, monitor = PRIMARY_MONITOR })
hl.window_rule({ match = { class = "^(vesktop|discord)$" }, monitor = PRIMARY_MONITOR })
hl.window_rule({ match = { class = "^(.*[Cc]alc.*)$" }, float = true, size = { "max(monitor_w, monitor_h)*0.17", "min(monitor_w, monitor_h)*0.43" } })
hl.window_rule({ match = { class = "^(org\\.kde\\.keditfiletype)$" }, float = true })
hl.window_rule({ match = { class = "^(org\\.kde\\.ark)$" }, size = { "max(monitor_w, monitor_h)*0.40", "min(monitor_w, monitor_h)*0.40" } })
hl.window_rule({ match = { class = "^(.*satty.*)$", title = "^(Satty)$" }, min_size = { "max(monitor_w, monitor_h)*0.35", "min(monitor_w, monitor_h)*0.35" }, float = true })
hl.window_rule({ match = { class = "^(dev\\.)?(noctalia\\.Noctalia(\\.Settings)?)$" }, float = true, size = { "monitor_w*0.70", "monitor_h*0.70" } })
hl.window_rule({
    match = {
        class = "^(org\\.kde\\.dolphin)$",
        title = "negative:^(Moving.*|Create New.*|Extract.*|Compress.*|Copying.*|Progress.*|Configure.*|Properties.*|Choose\\sApplication.*)$",
    },
    float = true,
    size = { "max(monitor_w, monitor_h)*0.50", "min(monitor_w, monitor_h)*0.55" },
    move = {
        "max(20, min(cursor_x - (window_w*0.50), monitor_w - window_w + 20))", -- X axis clamping
        "max(20, min(cursor_y - 50, monitor_h - window_h + 20))" -- Y axis clamping
    },
})

-- Opacity Overrides
local terminals = "^(kitty|ghostty|[Kk]onsole|Alacritty|gnome-terminal|xfce[0-9]?-terminal)$"

hl.window_rule({ match = { class = "^(firefox|zen)$" }, opacity = "1.0 override" })
hl.window_rule({ match = { class = terminals }, opacity = "1.0 override" }) -- Override opacity in favor of terminal settings for opacity. If your terminal doesn't support transparency, you can remove this rule.
hl.window_rule({ match = { class = "^(mpv|org.kde.haruna|.*plex.*|org\\.kde\\.gwenview|.*vlc.*)$" }, opacity = "1.0 override" })

-- Float Utility Windows
local floatApps = {
    { class = "^(kvantummanager|qt[56]ct|nwg-look)$" },
    { class = "^(org.pulseaudio.pavucontrol|blueman-manager|nm-applet|nm-connection-editor)$" },
    { title = "^(Winetricks.*|Protontricks.*)$" },
}
for _, m in ipairs(floatApps) do hl.window_rule({ match = m, float = true }) end

-- Float Common Modals
local modalMatches = {
    { title = "^(Open|Authentication Required|Add Folder to Workspace|Choose Files|Save As|Confirm to replace files|File Operation Progress)$" },
    { initial_title = "^(Open File)$" },
    { class = "^([Xx]dg-desktop-portal-gtk)$" },
    { title = "^(File Upload|Choose wallpaper|Library)(.*)$" },
    { class = "^(.*dialog.*)$" },
    { title = "^(.*dialog.*)$" },
    { class = "^(hyprland-share-picker)$"},
}
for _, m in ipairs(modalMatches) do hl.window_rule({ match = m, float = true }) end

-- Ignore maximize requests from all apps. You'll probably like this.
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})
-- BEGIN HSR WORKSPACE ROUTING
-- Terminal pulpitu: tylko ten specjalny Kitty jest pływający.
-- Zwykłe nowe terminale Kitty zachowują normalne zachowanie.
hl.window_rule({
    name = "hsr-dashboard-terminal",
    match = { class = "^(hsr-dashboard)$" },
    workspace = "1 silent",
    float = true,
    size = { "monitor_w*0.50+25", "monitor_h*0.56" },
    move = { "monitor_w*0.045", "monitor_h*0.39" },
})

-- Zachowaj przezroczystość ustawioną wewnątrz Kitty.
hl.window_rule({
    name = "hsr-dashboard-opacity",
    match = { class = "^(hsr-dashboard)$" },
    opacity = "1.0 override",
})

hl.window_rule({
    name = "workspace-firefox",
    match = { class = "^(firefox)$" },
    workspace = "2 silent",
    no_initial_focus = true,
})

hl.window_rule({
    name = "workspace-discord",
    match = { class = "^(vesktop)$" },
    workspace = "3 silent",
    no_initial_focus = true,
})

hl.window_rule({
    name = "workspace-pear-desktop",
    match = { class = "^(com\\.github\\.th_ch\\.youtube_music)$" },
    workspace = "3 silent",
    no_initial_focus = true,
})

hl.window_rule({
    name = "workspace-heroic",
    match = { class = "^(heroic)$" },
    workspace = "4 silent",
    no_initial_focus = true,
})

hl.window_rule({
    name = "workspace-steam",
    match = { class = "^(steam)$" },
    workspace = "4 silent",
    no_initial_focus = true,
})

hl.window_rule({
    name = "workspace-dolphin",
    match = { class = "^(org\\.kde\\.dolphin)$" },
    workspace = "5 silent",
    no_initial_focus = true,
})
-- END HSR WORKSPACE ROUTING
