return {
    "nvim-neo-tree/neo-tree.nvim",

    opts = {
        sources = { "filesystem", "buffers", "git_status" },
        open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline", "edgy" },
        close_if_last_window = true,

        commands = {
            copy_selector = function(state)
                local node = state.tree:get_node()
                if not node then
                    return
                end

                local filepath = node:get_id()
                local filename = node.name
                local modify = vim.fn.fnamemodify

                local vals = {
                    ["BASENAME"] = modify(filename, ":r"),
                    ["EXTENSION"] = modify(filename, ":e"),
                    ["FILENAME"] = filename,
                    ["PATH (CWD)"] = modify(filepath, ":."),
                    ["PATH (HOME)"] = modify(filepath, ":~"),
                    ["PATH"] = filepath,
                    ["URI"] = vim.uri_from_fname(filepath),
                }

                local options = vim.tbl_filter(function(k)
                    return vals[k] ~= ""
                end, vim.tbl_keys(vals))
                if vim.tbl_isempty(options) then
                    vim.notify("Neo-tree: nothing to copy", vim.log.levels.WARN)
                    return
                end
                table.sort(options)

                vim.ui.select(options, {
                    prompt = "Choose to copy to clipboard:",
                    format_item = function(item)
                        return ("%s: %s"):format(item, vals[item])
                    end,
                }, function(choice)
                    local result = choice and vals[choice]
                    if result then
                        vim.fn.setreg("+", result) -- system clipboard if `unnamedplus` available
                        vim.notify(("Copied: %s"):format(result))
                    end
                end)
            end,
        },

        window = {
            mappings = {
                Y = "copy_selector",
            },
            fuzzy_finder_mappings = {
                ["<C-j>"] = "move_cursor_down",
                ["<C-k>"] = "move_cursor_up",
            },
        },

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
                    -- added = "✚",
                    -- modified = "",
                    -- deleted = "✖",
                    -- renamed = "󰁕",
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
