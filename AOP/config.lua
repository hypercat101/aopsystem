Config = {}

-- UI Settings
Config.UI = {
    DisplayPosition = {x = 0.815, y = 0.01},
    TextScale = 0.40,
    TextColor = {r = 0, g = 136, b = 255, a = 255},
    Font = 4
}

-- AOP Settings
Config.DefaultAOP = "Sandy Shores"
Config.Cooldown = 25 -- seconds
Config.Locations = {
    { label = 'Los Santos', value = 'Los Santos' },
    { label = 'Sandy Shores', value = 'Sandy Shores' },
    { label = 'Paleto Bay', value = 'Paleto Bay' },
    { label = 'Grapeseed', value = 'Grapeseed' },
    { label = 'Blaine County', value = 'Blaine County' }
}

-- Notification Settings
Config.Notifications = {
    Duration = 8000,
    Position = 'top-center'
}

-- Discord Integration
Config.Discord = {
    Enabled = true,
    Webhook = "", -- Your Discord webhook URL
}

-- Permissions
Config.Permissions = {
    Enabled = true,  -- Set to false to allow everyone to use AOP
    AcePermission = "command.aop"  -- The ace permission needed to change AOP
}