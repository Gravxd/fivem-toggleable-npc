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