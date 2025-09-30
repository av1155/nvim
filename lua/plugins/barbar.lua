return {
    { "akinsho/bufferline.nvim", enabled = false },

    {
        "romgrk/barbar.nvim",
        event = { "BufReadPost", "BufNewFile" },
        init = function()
            vim.g.barbar_auto_setup = false
            local ok, wk = pcall(require, "which-key")
            if ok then
                wk.add({
                    { "<leader>bs", group = "sort buffers", mode = "n" },
                })
            end
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

        -- stylua: ignore
        keys = {
            { "<S-Tab>", "<Cmd>BufferPrevious<CR>",                             desc = "Move to previous buffer",                mode = "n", silent = true, noremap = true },
            { "<Tab>",   "<Cmd>BufferNext<CR>",                                 desc = "Move to next buffer",                    mode = "n", silent = true, noremap = true },
            { "<A-<>",   "<Cmd>BufferMovePrevious<CR>",                         desc = "Re-order to previous buffer",            mode = "n", silent = true, noremap = true },
            { "<A->>",   "<Cmd>BufferMoveNext<CR>",                             desc = "Re-order to next buffer",                mode = "n", silent = true, noremap = true },
            { "<A-1>",   "<Cmd>BufferGoto 1<CR>",                               desc = "Goto buffer 1",                          mode = "n", silent = true, noremap = true },
            { "<A-2>",   "<Cmd>BufferGoto 2<CR>",                               desc = "Goto buffer 2",                          mode = "n", silent = true, noremap = true },
            { "<A-3>",   "<Cmd>BufferGoto 3<CR>",                               desc = "Goto buffer 3",                          mode = "n", silent = true, noremap = true },
            { "<A-4>",   "<Cmd>BufferGoto 4<CR>",                               desc = "Goto buffer 4",                          mode = "n", silent = true, noremap = true },
            { "<A-5>",   "<Cmd>BufferGoto 5<CR>",                               desc = "Goto buffer 5",                          mode = "n", silent = true, noremap = true },
            { "<A-6>",   "<Cmd>BufferGoto 6<CR>",                               desc = "Goto buffer 6",                          mode = "n", silent = true, noremap = true },
            { "<A-7>",   "<Cmd>BufferGoto 7<CR>",                               desc = "Goto buffer 7",                          mode = "n", silent = true, noremap = true },
            { "<A-8>",   "<Cmd>BufferGoto 8<CR>",                               desc = "Goto buffer 8",                          mode = "n", silent = true, noremap = true },
            { "<A-9>",   "<Cmd>BufferGoto 9<CR>",                               desc = "Goto buffer 9",                          mode = "n", silent = true, noremap = true },
            { "<A-0>",   "<Cmd>BufferGoto 0<CR>",                               desc = "Goto buffer 0",                          mode = "n", silent = true, noremap = true },
            { "<A-p>",   "<Cmd>BufferPin<CR>",                                  desc = "Pin/unpin buffer",                       mode = "n", silent = true, noremap = true },
            { "<leader>ba", "<Cmd>BufferCloseAllButCurrent<CR>",                 desc = "Close others (keep current)",            mode = "n", silent = true, noremap = true },
            { "<leader>bp", "<Cmd>BufferCloseAllButPinned<CR>",                  desc = "Close unpinned buffers",                  mode = "n", silent = true, noremap = true },
            { "<leader>bP", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>",         desc = "Close others (keep current & pinned)",   mode = "n", silent = true, noremap = true },
            { "<leader>bsb", "<Cmd>BufferOrderByBufferNumber<CR>",               desc = "Sort buffers by buffer number",           mode = "n", silent = true, noremap = true },
            { "<leader>bsd", "<Cmd>BufferOrderByDirectory<CR>",                  desc = "Sort buffers by directory",               mode = "n", silent = true, noremap = true },
            { "<leader>bsl", "<Cmd>BufferOrderByLanguage<CR>",                   desc = "Sort buffers by language",                mode = "n", silent = true, noremap = true },
            { "<leader>bsw", "<Cmd>BufferOrderByWindowNumber<CR>",               desc = "Sort buffers by window number",           mode = "n", silent = true, noremap = true },
        },
    },
}
