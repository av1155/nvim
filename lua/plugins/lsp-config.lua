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

            -- UNMAP LSP KEYBINDS
            keys[#keys + 1] = { "<leader>ca", false, mode = "n" }
            keys[#keys + 1] = { "<leader>ca", false, mode = "v" }
            keys[#keys + 1] = { "<leader>cA", false, mode = "n" }

            -- MAP LSP KEYBINDS
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
