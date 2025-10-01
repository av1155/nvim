return {
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()

            -- stylua: ignore start
            vim.keymap.set("n", "<leader>/", "gcc", { desc = "Comments: toggle line", remap = true, silent = true })
            vim.keymap.set("x", "<leader>/", "gc", { desc = "Comments: toggle line (visual)", remap = true, silent = true })
            vim.keymap.set("n", "<leader>'", "gbc", { desc = "Comments: toggle block", remap = true, silent = true })
            vim.keymap.set("x", "<leader>'", "gb", { desc = "Comments: toggle block (visual)", remap = true, silent = true })
            -- stylua: ignore end

            local ok, wk = pcall(require, "which-key")
            if ok then
                wk.add({
                    {
                        "<leader>/",
                        desc = "Comments: toggle line",
                        icon = { icon = "", color = "orange" },
                        mode = "n",
                    },
                    {
                        "<leader>'",
                        desc = "Comments: toggle block",
                        icon = { icon = "", color = "orange" },
                        mode = "n",
                    },
                })
            end
        end,
    },
}
