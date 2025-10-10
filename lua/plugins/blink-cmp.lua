return {
    {
        "saghen/blink.cmp",
        opts = {
            signature = { enabled = false },
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
                    draw = {
                        columns = {
                            { "label", "label_description", gap = 1 },
                            { "kind_icon", "kind" },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 100,
                    window = { border = "rounded" },
                },
            },
            sources = {
                providers = {
                    copilot = {
                        enabled = function()
                            return vim.b.copilot_enabled == true
                        end,
                    },
                },
            },
            keymap = {
                preset = "none",
                ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<Up>"] = false,
                ["<Down>"] = false,
                ["<CR>"] = { "accept", "fallback" },
            },
        },
    },
}
