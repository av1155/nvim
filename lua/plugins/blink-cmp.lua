return {
    {
        "saghen/blink.cmp",
        opts = {
            -- Keymaps
            keymap = {
                preset = "none", -- avoid preset collisions

                -- Tab cycles, then snippet jump, then fallback
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

                -- Optional: extra cycling keys, arrows disabled
                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<Up>"] = false,
                ["<Down>"] = false,

                -- Accept with Enter
                ["<CR>"] = { "accept", "fallback" },
            },

            -- Make cycling not insert text until you confirm
            completion = {
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
            },
        },
    },
}
