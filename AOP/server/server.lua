local lastAOPChange = 0

-- Helper function to get Discord ID TO PING THE PLAYER WHO DID THE ACTION
local function GetDiscordId(source)
    local identifiers = GetPlayerIdentifiers(source)
    for _, id in ipairs(identifiers) do
        if string.find(id, "discord:") then
            return string.gsub(id, "discord:", "")
        end
    end
    return nil
end

-- Helper function to send Discord webhook
local function SendToDiscord(newAOP, player, src)
    if not Config.Discord.Enabled or Config.Discord.Webhook == "" then return end
    
    -- Get Discord ID and create ping
    local discordId = GetDiscordId(src)
    local userPing = discordId and string.format("<@%s>", discordId) or player
    
    local embed = {
        {
            title = "AOP Change Log",
            description = string.format("%s has changed the AOP to %s\nPlayer ID: %s", 
                userPing, newAOP, src),
            color = 3447003,
            footer = {
                text = os.date("%Y-%m-%d %H:%M:%S")
            }
        }
    }
    
    PerformHttpRequest(Config.Discord.Webhook, function(err, text, headers) end, 'POST', 
        json.encode({
            username = "AOP Logger",
            embeds = embed
        }), { ['Content-Type'] = 'application/json' })
end

-- Helper function to check permissions
local function hasPermission(source)
    if not Config.Permissions.Enabled then return true end
    return IsPlayerAceAllowed(source, Config.Permissions.AcePermission)
end

RegisterNetEvent('setAOP')
AddEventHandler('setAOP', function(newAOP)
    local src = source
    
    -- Check permissions first
    if not hasPermission(src) then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Permission Denied',
            description = 'You do not have permission to change the AOP',
            type = 'error',
            position = Config.Notifications.Position,
            duration = Config.Notifications.Duration
        })
        return
    end
    
    -- Cooldown check
    local currentTime = GetGameTimer()
    if (currentTime - lastAOPChange) < (Config.Cooldown * 1000) then
        local remainingCooldown = math.ceil((Config.Cooldown * 1000 - (currentTime - lastAOPChange)) / 1000)
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'AOP Cooldown',
            description = string.format('Please wait %s seconds before changing AOP again', remainingCooldown),
            type = 'error',
            position = Config.Notifications.Position,
            duration = Config.Notifications.Duration
        })
        return
    end
    
    lastAOPChange = currentTime
    local player = GetPlayerName(src)
    
    -- Update AOP for all clients
    TriggerClientEvent('updateAOP', -1, newAOP)
    
    -- Notify all players
    TriggerClientEvent('ox_lib:notify', -1, {
        title = 'AOP Changed',
        description = string.format('AOP has been changed to %s by %s [ID: %s]', newAOP, player, src),
        type = 'info',
        position = Config.Notifications.Position,
        duration = Config.Notifications.Duration,
        icon = 'map-location-dot',
        iconAnimation = 'bounce',
        style = {
            backgroundColor = '#1E1E2E',
            color = 'white'
        }
    })
    
    -- Send to Discord webhook
    SendToDiscord(newAOP, player, src)
end) 
