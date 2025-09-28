return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
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
                ["Y"] = "copy_selector",
                ["e"] = "noop",
                ["P"] = {
                    "toggle_preview",
                    config = {
                        use_float = true,
                        use_snacks_image = true,
                        title = "Neo-tree Preview",
                    },
                },
            },
        },

        filesystem = {
            bind_to_cwd = false,
            use_libuv_file_watcher = true,
            filtered_items = {
                visible = true, -- when true, they will just be displayed differently than normal items
                never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                    ".DS_Store",
                    "thumbs.db",
                },
            },
        },
    },
}
