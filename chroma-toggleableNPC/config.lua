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

Config.Notification = 'auto_detect' --[ 'auto_detect' / 'other' ]   If you select 'auto_detect', only okokNotify, ps-ui and ox_lib notifications will be detected. Use 'other' for custom notification resources.
-- Auto Detect

if Config.Notification == 'auto_detect' then
    if GetResourceState('okokNotify') == 'started' then
        Config.Notification = 'okokNotify'
    elseif GetResourceState('ps-ui') == 'started' then
        Config.Notification = 'ps-ui'
    elseif GetResourceState('ox_lib') == 'started' then
        Config.Notification = 'ox_lib'
    else
        if Config.Framework == 'esx' or Config.Framework == 'qbcore' then
            Config.Notification = Config.Framework
        else
            Config.Notification = 'chat'
        end
    end
end
