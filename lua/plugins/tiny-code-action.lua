return {
    {
        "rachartier/tiny-code-action.nvim",
        event = "LspAttach",
        opts = {
            --- The backend to use, currently only "vim", "delta", "difftastic", "diffsofancy" are supported
            backend = "vim",

            -- The picker to use, "telescope", "snacks", "select", "buffer", "fzf-lua" are supported
            -- And it's opts that will be passed at the picker's creation, optional
            picker = "snacks",
            -- picker = {
            --     "buffer",
            --     opts = {
            --         hotkeys = true,
            --         hotkeys_mode = "text_diff_based",
            --         auto_preview = false,
            --         auto_accept = false,
            --         position = "cursor",
            --         winborder = "single",
            --         custom_keys = {
            --             { key = "m", pattern = "Fill match arms" },
            --             { key = "r", pattern = "Rename.*" },
            --         },
            --     },
            -- },

            -- The icons to use for the code actions
            -- You can add your own icons, you just need to set the exact action's kind of the code action
            -- You can set the highlight like so: { link = "DiagnosticError" } or  like nvim_set_hl ({ fg ..., bg..., bold..., ...})
            signs = {
                quickfix = { "", { link = "DiagnosticWarning" } },
                others = { "", { link = "DiagnosticWarning" } },
                refactor = { "", { link = "DiagnosticInfo" } },
                ["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
                ["refactor.extract"] = { "", { link = "DiagnosticError" } },
                ["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
                ["source.fixAll"] = { "󰃢", { link = "DiagnosticError" } },
                ["source"] = { "", { link = "DiagnosticError" } },
                ["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
                ["codeAction"] = { "", { link = "DiagnosticWarning" } },
            },
        },
    },
}
