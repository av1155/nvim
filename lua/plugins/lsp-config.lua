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

            local keys = require("lazyvim.plugins.lsp.keymaps").get()

            -- UNMAP DEFAULT LSP KEYBINDS
            keys[#keys + 1] = { "gd", false }
            keys[#keys + 1] = { "gr", false }
            keys[#keys + 1] = { "gI", false }
            keys[#keys + 1] = { "gy", false }
            keys[#keys + 1] = { "gD", false }
            keys[#keys + 1] = { "<leader>ca", false, mode = "n" }
            keys[#keys + 1] = { "<leader>ca", false, mode = "v" }
            keys[#keys + 1] = { "<leader>cA", false, mode = "n" }
            keys[#keys + 1] = { "gK", false }

            -- MAP GOTO-PREVIEW LSP KEYBINDS
            keys[#keys + 1] = {
                "gd",
                function()
                    require("goto-preview").goto_preview_definition({})
                end,
                desc = "Goto Definition (preview)",
            }

            keys[#keys + 1] = {
                "gr",
                function()
                    require("goto-preview").goto_preview_references({})
                end,
                desc = "References (preview)",
                nowait = true,
            }

            keys[#keys + 1] = {
                "gI",
                function()
                    require("goto-preview").goto_preview_implementation({})
                end,
                desc = "Goto Implementation (preview)",
            }

            keys[#keys + 1] = {
                "gy",
                function()
                    require("goto-preview").goto_preview_type_definition({})
                end,
                desc = "Goto Type Definition (preview)",
            }

            keys[#keys + 1] = {
                "gD",
                function()
                    require("goto-preview").goto_preview_declaration({})
                end,
                desc = "Goto Declaration (preview)",
            }

            keys[#keys + 1] = {
                "gP",
                function()
                    require("goto-preview").close_all_win()
                end,
                desc = "Close all preview windows",
            }

            -- MAP TINY-CODE-ACTION KEYBINDS
            keys[#keys + 1] = {
                "<leader>ca",
                function()
                    require("tiny-code-action").code_action({})
                end,
                desc = "Code Action (preview)",
                mode = { "n", "v" },
            }

            keys[#keys + 1] = {
                "<leader>cA",
                function()
                    require("tiny-code-action").code_action({
                        context = { only = { "source" } },
                    })
                end,
                desc = "Source Action (preview)",
                mode = { "n" },
            }

            opts.keys = keys
        end,
    },
}
