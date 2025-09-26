return {
    "nvim-neo-tree/neo-tree.nvim",

    opts = {
        sources = { "filesystem", "buffers", "git_status" },
        open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline", "edgy" },
        filesystem = {
            bind_to_cwd = false,
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,
            filtered_items = {
                visible = true, -- when true, they will just be displayed differently than normal items
                never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                    ".DS_Store",
                    "thumbs.db",
                },
            },
        },
        window = {
            mappings = {
                ["l"] = "open",
                ["h"] = "close_node",
                ["<space>"] = "none",
                ["Y"] = {
                    function(state)
                        local node = state.tree:get_node()
                        local path = node:get_id()
                        vim.fn.setreg("+", path, "c")
                    end,
                    desc = "Copy Path to Clipboard",
                },
                ["O"] = {
                    function(state)
                        require("lazy.util").open(state.tree:get_node().path, { system = true })
                    end,
                    desc = "Open with System Application",
                },
                ["P"] = { "toggle_preview", config = { use_float = false } },
            },
        },
        default_component_configs = {
            indent = {
                with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
            modified = {
                symbol = "[+]",
                highlight = "NeoTreeModified",
            },
            git_status = {
                symbols = {
                    -- -- Change type
                    -- added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
                    -- modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                    -- deleted = "✖", -- this can only be used in the git_status source
                    -- renamed = "󰁕", -- this can only be used in the git_status source
                    -- Status type
                    untracked = "",
                    ignored = "",
                    unstaged = "󰄱",
                    staged = "",
                    conflict = "",
                },
            },
        },
    },
}
