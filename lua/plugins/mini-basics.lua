later(function()
    require('mini.basics').setup({
        options = {
            basic = true,
            extra_ui = true,
            win_borders = 'bold',
        },
        mappings = {
            basic = true,
            windows = true,
        },
        autocommands = {
            basic = true,
            relnum_in_visual_mode = true,
        }
    })
end)

