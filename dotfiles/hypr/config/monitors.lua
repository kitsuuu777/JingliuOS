-- Monitor wiki https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Example: output can be found with hyprctl monitors. Edit variables.lua for the monitor outputs instead of here directly
-- hl.monitor({
--     output    = "MONITOR1",
--     mode      = "1920x1080@60",
--     position  = "0x0",
--     scale     = "1",
-- })
hl.monitor({
    output    = "desc:AU Optronics 0x7DB2",
    mode      = "2560x1600@240",
    position  = "0x0",
    scale     = "auto",
})
