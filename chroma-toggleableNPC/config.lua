Config = {
    EnabledOnStartup = false, -- whether NPCs are enabled on server start
    HasPermission = function(src)
        return IsPlayerAceAllowed(src, "toggle-npc")
    end,
    Notify = function(src, msg, type)
        -- configure this to your server's notify script
        TriggerClientEvent("chatMessage", src, "SYSTEM", {255, 0, 0}, msg)
    end,
}

Config.Notification = 'okokNotify' --[ 'auto_detect' / 'other' ]   If you select 'auto_detect', only okokNotify notifications will be detected. Use 'other' for custom notification resources.
-- Auto Detect

if Config.Notification == 'auto_detect' then
    if GetResourceState('okokNotify') == 'started' then
        Config.Notification = 'okokNotify'
    else
        Config.Notification = 'chat'
    end
end
