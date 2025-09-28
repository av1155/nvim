return {
    {
        "patrickpichler/hovercraft.nvim",
        event = "LspAttach",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            window = { border = "rounded" },
        },
        keys = {
            -- gh: show hover
            {
                "gh",
                function()
                    local hover = require("hovercraft")
                    if hover.is_visible() then
                        hover.enter_popup()
                    else
                        hover.hover()
                    end
                end,
                desc = "Hover",
            },
        },
    },
}
