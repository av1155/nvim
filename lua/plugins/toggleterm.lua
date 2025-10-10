return {
    {
        "akinsho/toggleterm.nvim",
        opts = {
            direction = "float",
        },
        keys = {
            {
                "<A-z>",
                function()
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
                    vim.cmd("ToggleTermToggleAll")
                end,
                desc = "Exit terminal mode and close floating terminal",
                mode = "t",
                silent = true,
                noremap = true,
            },

            {
                "<A-z>",
                "<cmd>ToggleTerm direction=float<CR>",
                desc = "Toggle Terminal",
                mode = "n",
                silent = true,
                noremap = true,
            },
        },
    },
}
