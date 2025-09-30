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
