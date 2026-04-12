return {
    -- Comment.nvim is incompatible with Neovim 0.12 (nil commentstring resolution).
    -- Native gc/gcc commenting + LazyVim's ts-comments.nvim replaces it.
    { "numToStr/Comment.nvim", enabled = false },

    {
        "folke/ts-comments.nvim",
        config = function(_, opts)
            require("ts-comments").setup(opts)

            -- stylua: ignore start
            vim.keymap.set("n", "<leader>/", "gcc", { desc = "Comments: toggle line", remap = true, silent = true })
            vim.keymap.set("x", "<leader>/", "gc", { desc = "Comments: toggle line (visual)", remap = true, silent = true })
            -- stylua: ignore end

            local ok, wk = pcall(require, "which-key")
            if ok then
                wk.add({
                    {
                        "<leader>/",
                        desc = "Comments: toggle line",
                        icon = { icon = "", color = "orange" },
                        mode = { "n", "x" },
                    },
                })
            end
        end,
    },
}
