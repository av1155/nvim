return {
    { "akinsho/bufferline.nvim", enabled = false, dependencies = "nvim-tree/nvim-web-devicons" },

    {
        "romgrk/barbar.nvim",
        event = { "BufReadPost", "BufNewFile" },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "lewis6991/gitsigns.nvim",
        },
        opts = {
            -- configurations go here
            animation = true,
            insert_at_start = false,
            auto_hide = false,
            sidebar_filetypes = {
                ["neo-tree"] = { event = "BufWipeout" },
            },
            icons = {
                buffer_index = false,
                buffer_number = false,
                button = "", -- Disable the close button on current buffer only
                diagnostics = {
                    [vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
                    [vim.diagnostic.severity.WARN] = { enabled = true, icon = " " },
                    [vim.diagnostic.severity.INFO] = { enabled = true, icon = " " },
                    [vim.diagnostic.severity.HINT] = { enabled = true },
                },
                gitsigns = {
                    added = { enabled = true, icon = "+" },
                    changed = { enabled = true, icon = "~" },
                    deleted = { enabled = true, icon = "-" },
                },
                filetype = {
                    -- Sets the icon's highlight group.
                    -- If false, will use nvim-web-devicons colors
                    custom_colors = false,

                    -- Requires `nvim-web-devicons` if `true`
                    enabled = true,
                },
                -- Configure the icons on the bufferline when modified or pinned.
                -- Supports all the base icon options.
                modified = { button = "◉" },
                pinned = { button = "", filename = true },

                -- Configure the icons on the bufferline based on the visibility of a buffer.
                -- Supports all the base icon options, plus `modified` and `pinned`.
                alternate = { filetype = { enabled = false } },
                current = { buffer_index = true },
                inactive = { button = "×" },
                visible = { modified = { buffer_number = false } },
            },
        },
    },
}
