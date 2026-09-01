-- HSR theme-aware look and feel

hl.config({
    misc = {
        disable_hyprland_logo = true,
        background_color = "rgb(070b16)",
    },

    general = {
        gaps_in = 6,
        gaps_out = 12,
        border_size = 2,
        extend_border_grab_area = 10,
        resize_on_border = true,

        col = {
            active_border = {
                colors = {
                    THEME_ACCENT_1,
                    THEME_ACCENT_2,
                    THEME_ACCENT_3,
                },
                angle = 45,
            },
            inactive_border = THEME_INACTIVE_BORDER,
        },
    },

    group = {
        col = {
            border_active = THEME_ACCENT_1,
            border_inactive = THEME_BORDER,
            border_locked_active = THEME_ACCENT_2,
            border_locked_inactive = THEME_INACTIVE_BORDER,
        },
        groupbar = {
            col = {
                active = THEME_ACCENT_1,
                inactive = THEME_BORDER,
                locked_active = THEME_ACCENT_2,
                locked_inactive = THEME_INACTIVE_BORDER,
            },
        },
    },

    decoration = {
        dim_special = 0.25,
        rounding = 16,
        rounding_power = 3.2,
        active_opacity = THEME_ACTIVE_OPACITY,
        inactive_opacity = THEME_INACTIVE_OPACITY,
        fullscreen_opacity = 1.0,

        blur = {
            enabled = true,
            size = 8,
            passes = 3,
            ignore_opacity = true,
            new_optimizations = true,
            noise = 0.008,
            contrast = 0.92,
            brightness = THEME_BLUR_BRIGHTNESS,
            vibrancy = THEME_BLUR_VIBRANCY,
            vibrancy_darkness = THEME_BLUR_VIBRANCY_DARKNESS,
            special = true,
            popups = true,
        },

        shadow = {
            enabled = true,
            range = 18,
            render_power = 3,
            color = "rgba(050812d0)",
            color_inactive = "rgba(05081270)",
        },

        glow = {
            enabled = true,
            range = 8,
            render_power = 3,
            color = THEME_GLOW,
            color_inactive = THEME_GLOW_INACTIVE,
        },
    },
})
