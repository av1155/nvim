return {
    {
        "nmac427/guess-indent.nvim",
        event = "BufReadPre",
        opts = {
            auto_cmd = true,
            override_editorconfig = false,
            filetype_exclude = {
                "help",
                "dashboard",
                "neo-tree",
                "Trouble",
                "trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
                "lazyterm",
            },
        },
    },
}
