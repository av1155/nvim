return {
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require("telescope").setup({
                defaults = {
                    layout_strategy = "horizontal",
                    layout_config = { prompt_position = "top" },
                    sorting_strategy = "ascending",
                    winblend = 0,
                },
            })

            -- stylua: ignore start
            vim.keymap.set("n", "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find words", remap = true, silent = true })
            vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects<cr>", { desc = "Projects", remap = true, silent = true })
            vim.keymap.set("n", "<leader>fP", function()
                require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
            end, { desc = "Find Plugin File", remap = true, silent = true })
            -- stylua: ignore end
        end,
    },
}
