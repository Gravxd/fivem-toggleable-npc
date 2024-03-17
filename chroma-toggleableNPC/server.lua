local Enabled = Config.EnabledOnStartup
RegisterCommand("togglenpc", function(source, args, rawCommand)

    if source == 0 then
        Enabled = not Enabled
        SetRoutingBucketPopulationEnabled(0, Enabled)
        return print(string.format("^6[chroma-toggleableNPC] ^7NPCs have been: %s", Enabled and "^2enabled.^7" or "^1disabled.^7"))
    end

    if Config.HasPermission(source) then
        Enabled = not Enabled
        SetRoutingBucketPopulationEnabled(0, Enabled)
        Config.Notify(source, string.format("NPCs have been %s", Enabled and "enabled!" or "disabled!"), 'success')
    else
        Config.Notify(source, "You do not have permission to use this command.", 'error')
    end
end, false)

CreateThread(function()
    SetRoutingBucketPopulationEnabled(0, Enabled)
    print(string.format("^6[chroma-toggleableNPC] ^7NPCs have been: %s", Enabled and "^2enabled.^7" or "^1disabled.^7"))
end)