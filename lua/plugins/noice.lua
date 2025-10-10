return {
    {
        "folke/noice.nvim",
        opts = {
            cmdline = {
                enabled = true,
                view = "cmdline_popup",
                opts = {
                    position = {
                        row = "30%",
                        col = "50%",
                    },
                },
            },
            presets = {
                lsp_doc_border = true,
            },
            hover = {
                enabled = true,
                silent = false, -- set to true to not show a message if hover is not available
            },
            signature = {
                enabled = true,
                auto_open = {
                    enabled = true,
                },
            },
            routes = {
                -- skip img-clip warning when using cmd+v
                { filter = { event = "notify", find = "Content is not an image" }, opts = { skip = true } },

                { -- Mason / registry / update chatter (info only)
                    filter = {
                        event = "notify",
                        kind = "info",
                        any = {
                            { find = "^Updating registries" },
                            { find = "^Successfully updated %d+ registr%w+%.?" },
                            { find = "^Checking for package updates" },
                            { find = "^No updates available" },
                        },
                    },
                    opts = { skip = true },
                },
            },
        },
    },
}
