local Config = {
    EnabledOnStartup = false, -- whether NPCs are enabled on server start
    HasPermission = function(src)
        return IsPlayerAceAllowed(src, "toggle-npc")
    end,
    Notify = function(src, msg, type)
        if Config.Notification == 'auto_detect' then
            if GetResourceState('okokNotify') == 'started' then
                exports['okokNotify']:Alert('SYSTEM', msg, 5000, 'success')
            elseif GetResourceState('ps-ui') == 'started' then
                exports['ps-ui']:Notify(msg, 'success', 5000)
            elseif GetResourceState('ox_lib') == 'started' then
                lib.notify({
                    title = 'SYSTEM',
                    description = msg,
                    type = 'success'
                })
            else
                TriggerClientEvent("chatMessage", src, "SYSTEM", {255, 0, 0}, msg)
            end
        elseif Config.Notification == 'okokNotify' then
            exports['okokNotify']:Alert('SYSTEM', msg, 5000, 'success')
        elseif Config.Notification == 'ps-ui' then
            exports['ps-ui']:Notify(msg, 'success', 5000)
        elseif Config.Notification == 'ox_lib' then
            lib.notify({
                title = 'SYSTEM',
                description = msg,
                type = 'success'
            })
        else
            TriggerClientEvent("chatMessage", src, "SYSTEM", {255, 0, 0}, msg)
        end
    end,
}

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
