return {
    {
        "rmagatti/goto-preview",
        dependencies = { "rmagatti/logger.nvim" },
        event = "BufEnter",
        opts = {
            width = 120,
            height = 15,
            border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
            default_mappings = false,
            opacity = nil,
            resizing_mappings = false,
            post_open_hook = function(buf, _)
                vim.keymap.set("n", "q", function()
                    require("goto-preview").close_all_win()
                end, { buffer = buf, noremap = true, silent = true })
            end,
            post_close_hook = nil,
            references = {
                provider = "telescope",
                telescope = require("telescope.themes").get_dropdown({ hide_preview = false }),
            },
            focus_on_open = true,
            dismiss_on_move = false,
            force_close = true,
            bufhidden = "wipe",
            stack_floating_preview_windows = true,
            same_file_float_preview = true,
            preview_window_title = { enable = true, position = "left" },
            zindex = 1,
            vim_ui_input = true,
        },
    },
}
