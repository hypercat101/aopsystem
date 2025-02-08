lib.callback.register('aop:selectLocation', function()
    local input = lib.inputDialog('Set AOP Location', {
        {
            type = 'select',
            label = 'Select New AOP Location',
            description = 'Choose the new Area of Play',
            required = true,
            options = {
                { label = 'Los Santos', value = 'Los Santos' },
                { label = 'Sandy Shores', value = 'Sandy Shores' },
                { label = 'Paleto Bay', value = 'Paleto Bay' },
                { label = 'Grapeseed', value = 'Grapeseed' },
                { label = 'Blaine County', value = 'Blaine County' }
            }
        }
    })

    if not input then return nil end
    return input[1]  -- Return the selected location
end) 