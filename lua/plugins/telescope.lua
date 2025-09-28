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
        keys = {
            { -- Browse plugin files
                "<leader>fP",
                function()
                    require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
                end,
                desc = "Find Plugin File",
            },
        },
    },
}
