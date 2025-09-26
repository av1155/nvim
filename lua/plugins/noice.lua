return {
    {
        "folke/noice.nvim",
        opts = {
            cmdline = {
                enabled = true,
                view = "cmdline_popup",
                opts = {
                    position = "50%",
                },
            },
            routes = {
                { -- skip img-clip warning when using cmd+v
                    filter = { event = "notify", find = "Content is not an image" },
                    opts = { skip = true },
                },
            },
        },
    },
}
