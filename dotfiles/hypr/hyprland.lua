hl.config({
    cursor = {
        invisible = true,
    },
})

hl.config({
    debug = {
        disable_logs = true,
    },
})

hl.config({
    misc = {
        disable_splash_rendering = true,
    },
})

require("config.autostart")
require("config.animations")
require("config.colors")
require("config.decorations")
require("config.variables")
require("config.inputs")
require("config.binds")
require("config.misc")
require("config.monitors")
require("config.windowrules")
require("config.workspaces")
require("config.environment")
