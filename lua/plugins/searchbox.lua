return {
    {
        "VonHeikemen/searchbox.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {},
        -- stylua: ignore
        keys = {
            {"<leader>s.", ":SearchBoxReplace<CR>", desc = "Search and Replace on Current Buffer", mode = "n", silent = true, noremap = true},

        },
    },
}
