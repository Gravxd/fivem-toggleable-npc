Config = {
    EnabledOnStartup = false, -- whether NPCs are enabled on server start
    HasPermission = function(src)
        return IsPlayerAceAllowed(src, "toggle-npc")
    end,
    Notification = Config.Notification, -- Change this to the desired notification method
}

local Enabled = Config.EnabledOnStartup

local function Notify(src, msg, type)
    if Config.Notification == 'okokNotify' then
        TriggerClientEvent('okokNotify:Alert', src, 'SYSTEM', msg, 5000, type or 'success', true) -- Assuming playSound is set to true
    elseif Config.Notification == 'mythic_notify' then
        local style = {}
        if type == 'error' then
            style = { ['background-color'] = '#FF0000', ['color'] = '#FFFFFF' } -- Red background for error
        else
            style = { ['background-color'] = '#00FF00', ['color'] = '#000000' } -- Green background for success
        end
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = type or 'success', text = msg , style = style })
    else
        -- Default to chat message if notification method is not recognized
        TriggerClientEvent("chatMessage", src, "SYSTEM", {255, 0, 0}, msg)
    end
end

RegisterCommand("togglenpc", function(source, args, rawCommand)
    if source == 0 then
        Enabled = not Enabled
        SetRoutingBucketPopulationEnabled(0, Enabled)
        return print(string.format("^6[chroma-toggleableNPC] ^7NPCs have been: %s", Enabled and "^2enabled.^7" or "^1disabled.^7"))
    end

    if Config.HasPermission(source) then
        Enabled = not Enabled
        SetRoutingBucketPopulationEnabled(0, Enabled)
        Notify(source, string.format("NPCs have been %s", Enabled and "enabled!" or "disabled!"), 'success')
    else
        Notify(source, "You do not have permission to use this command.", 'error')
    end
end, false)

CreateThread(function()
    SetRoutingBucketPopulationEnabled(0, Enabled)
    print(string.format("^6[chroma-toggleableNPC] ^7NPCs have been: %s", Enabled and "^2enabled.^7" or "^1disabled.^7"))
end)
