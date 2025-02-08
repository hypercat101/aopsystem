local currentAOP = Config.DefaultAOP
local displayText = true

-- UI Display
CreateThread(function()
    while true do
        Wait(0)
        if displayText then
            SetTextFont(Config.UI.Font)
            SetTextProportional(1)
            SetTextScale(Config.UI.TextScale, Config.UI.TextScale)
            SetTextColour(Config.UI.TextColor.r, Config.UI.TextColor.g, Config.UI.TextColor.b, Config.UI.TextColor.a)
            SetTextEntry("STRING")
            AddTextComponentString("AOP: " .. currentAOP)
            DrawText(Config.UI.DisplayPosition.x, Config.UI.DisplayPosition.y)
        end
    end
end)

-- Register command for AOP menu
RegisterCommand('aop', function()
    local input = lib.inputDialog('Set AOP Location', {
        {
            type = 'select',
            label = 'Select New AOP Location',
            description = 'Choose the new Area of Play',
            required = true,
            options = Config.Locations
        }
    })
    
    if input?[1] then
        TriggerServerEvent('setAOP', input[1])
    end
end, false)

-- Network event handler
RegisterNetEvent('updateAOP')
AddEventHandler('updateAOP', function(newAOP)
    currentAOP = newAOP
end)
