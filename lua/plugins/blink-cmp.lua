return {
    {
        "saghen/blink.cmp",
        opts = function(_, opts)
            opts.keymap = {
                preset = "none",

                ["<Tab>"] = {
                    function(cmp)
                        return cmp.select_next({ auto_insert = false, on_ghost_text = true })
                    end,
                    "snippet_forward",
                    "fallback",
                },
                ["<S-Tab>"] = {
                    function(cmp)
                        return cmp.select_prev({ auto_insert = false, on_ghost_text = true })
                    end,
                    "snippet_backward",
                    "fallback",
                },

                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<Up>"] = false,
                ["<Down>"] = false,

                ["<CR>"] = { "accept", "fallback" },
            }

            opts.completion = {
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = false,
                    },
                    cycle = { from_top = true, from_bottom = true },
                },
                menu = {
                    border = "rounded",
                    winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
                },
                documentation = {
                    window = { border = "rounded" },
                },
            }

            opts.sources = opts.sources or {}
            opts.sources.providers = opts.sources.providers or {}
            opts.sources.providers.copilot = vim.tbl_deep_extend("force", opts.sources.providers.copilot or {}, {
                enabled = function()
                    return vim.b.copilot_enabled == true
                end,
            })

            return opts
        end,
    },
}
