-- Workspace 1 jest domyślny i wszystkie 1-6 pozostają widoczne,
-- nawet gdy aktualnie nic na nich nie ma.

hl.workspace_rule({
    workspace = "1",
    monitor = MONITOR1,
    default = true,
    persistent = true,
})

for i = 2, NUM_WPM do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor = MONITOR1,
        persistent = true,
    })
end

-- Osobny workspace dla gier.
hl.workspace_rule({
    workspace = "name:gaming",
    monitor = PRIMARY_MONITOR,
})
