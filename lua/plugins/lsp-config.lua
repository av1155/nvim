return {
    {
        "neovim/nvim-lspconfig",
        dependencies = { "aznhe21/actions-preview.nvim" },
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
                -- virtual_text = { prefix = "" },
                underline = true,
                severity_sort = true,
            })

            local keys = require("lazyvim.plugins.lsp.keymaps").get()

            -- UNMAP LSP KEYBINDS
            keys[#keys + 1] = { "<leader>ca", false }

            -- MAP LSP KEYBINDS
            keys[#keys + 1] = {
                "<leader>ca",
                function()
                    require("tiny-code-action").code_action({})
                end,
                desc = "Code Action (preview)",
                mode = { "n", "v" },
            }

            opts.keys = keys
        end,
    },
}
