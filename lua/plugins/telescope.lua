return {
    {
        "nvim-telescope/telescope.nvim",
        opts = {
            defaults = {
                layout_strategy = "horizontal",
                layout_config = { prompt_position = "top" },
                sorting_strategy = "ascending",
                winblend = 0,
            },
        },
        -- stylua: ignore
        keys = {
            { -- Browse plugin files
                "<leader>fP",
                function()
                    require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
                end,
                desc = "Find Plugin File",
            },
            { "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find words in current buffer", mode = "n" },
            { "<leader>fp", "<cmd>Telescope projects<cr>",                  desc = "Projects",                     mode = "n" },
        },
    },
}
