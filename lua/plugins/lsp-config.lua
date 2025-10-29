return {
    {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            opts.diagnostics = vim.tbl_deep_extend("force", opts.diagnostics or {}, {
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.INFO] = "",
                        [vim.diagnostic.severity.HINT] = "",
                    },
                },
                virtual_text = false,
                underline = true,
                severity_sort = true,
            })

            -- Configure LSP keymaps using the new servers['*'] approach
            opts.servers = opts.servers or {}
            opts.servers["*"] = opts.servers["*"] or {}
            opts.servers["*"].keys = {
                -- UNMAP DEFAULT LSP KEYBINDS
                { "gd", false },
                { "gr", false },
                { "gI", false },
                { "gy", false },
                { "gD", false },
                { "<leader>ca", false, mode = "n" },
                { "<leader>ca", false, mode = "v" },
                { "<leader>cA", false, mode = "n" },

                -- MAP LSP KEYBINDS
                {
                    "gh",
                    function()
                        vim.lsp.buf.hover()
                    end,
                    desc = "Hover",
                },
                {
                    "gm",
                    function()
                        require("util.man_hover").show()
                    end,
                    desc = "Man Page",
                },
                {
                    "gd",
                    function()
                        require("goto-preview").goto_preview_definition({})
                    end,
                    desc = "Goto Definition (preview)",
                },
                {
                    "gr",
                    function()
                        require("goto-preview").goto_preview_references({})
                    end,
                    desc = "References (preview)",
                    nowait = true,
                },
                {
                    "gI",
                    function()
                        require("goto-preview").goto_preview_implementation({})
                    end,
                    desc = "Goto Implementation (preview)",
                },
                {
                    "gy",
                    function()
                        require("goto-preview").goto_preview_type_definition({})
                    end,
                    desc = "Goto Type Definition (preview)",
                },
                {
                    "gD",
                    function()
                        require("goto-preview").goto_preview_declaration({})
                    end,
                    desc = "Goto Declaration (preview)",
                },
                {
                    "gP",
                    function()
                        require("goto-preview").close_all_win()
                    end,
                    desc = "Close all preview windows",
                },

                -- MAP TINY-CODE-ACTION KEYBINDS
                {
                    "<leader>ca",
                    function()
                        require("tiny-code-action").code_action({})
                    end,
                    desc = "Code Action (preview)",
                    mode = { "n", "v" },
                },
                {
                    "<leader>cA",
                    function()
                        require("tiny-code-action").code_action({
                            context = { only = { "source" } },
                        })
                    end,
                    desc = "Source Action (preview)",
                    mode = { "n" },
                },
            }
        end,
    },
}
