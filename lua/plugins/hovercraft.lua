return {
    {
        "patrickpichler/hovercraft.nvim",
        event = "LspAttach",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
        opts = function()
            return {
                providers = {
                    providers = {
                        {
                            "Man",
                            require("hovercraft.provider.man").new(),
                        },
                    },
                },
                window = {
                    border = "rounded",
                    render_markdown_compat_mode = true,
                },
            }
        end,
    },
}
