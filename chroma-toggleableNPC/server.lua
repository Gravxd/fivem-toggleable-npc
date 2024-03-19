Config = {
    EnabledOnStartup = false, -- whether NPCs are enabled on server start
    HasPermission = function(src)
        return IsPlayerAceAllowed(src, "toggle-npc")
    end,
    Notification = Config.Notification, -- Change this to the desired notification method
}

-- Auto Detect for Notification
if Config.Notification == 'auto_detect' then
    if GetResourceState('okokNotify') == 'started' then
        Config.Notification = 'okokNotify'
    elseif GetResourceState('mythic_notify') == 'started' then
        Config.Notification = 'mythic_notify'
    else
        Config.Notification = 'chat'
    end
end



local function Notify(src, msg, type)
    if Config.Notification == 'okokNotify' then
        TriggerClientEvent('okokNotify:Alert', src, 'SYSTEM', msg, 5000, 'success', true) -- Assuming playSound is set to true
    elseif Config.Notification == 'mythic_notify' then
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'success', text = msg , style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } }) -- Change #color to what ever you want https://imagecolorpicker.com/color-code
    else
        -- Default to chat message if notification method is not recognized
        TriggerClientEvent("chatMessage", src, "SYSTEM", {255, 0, 0}, msg)
    end
end


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
        Notify(source, string.format("NPCs have been %s", Enabled and "enabled!" or "disabled!"), 'success')
    else
        Notify(source, "You do not have permission to use this command.", 'error')
    end
end, false)

CreateThread(function()
    SetRoutingBucketPopulationEnabled(0, Enabled)
    print(string.format("^6[chroma-toggleableNPC] ^7NPCs have been: %s", Enabled and "^2enabled.^7" or "^1disabled.^7"))
end)

