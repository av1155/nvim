return {
    {
        "mason-org/mason.nvim",
        dependencies = { "Zeioth/mason-extra-cmds", opts = {} },

        opts = {
            ui = {
                border = "rounded",
            },
            cmd = {
                "MasonUpdateAll", -- this cmd is provided by mason-extra-cmds
            },
        },
    },
}
