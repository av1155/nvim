return {
    {
        "folke/sidekick.nvim",
        opts = {
            cli = {
                mux = {
                    backend = "tmux",
                    enabled = false,
                },
                win = {
                    layout = "float",
                    float = {
                        border = "rounded",
                        width = 0.9,
                        height = 0.85,
                        row = 0.3,
                    },
                    keys = {
                        stopinsert = false,
                    },
                },
            },
        },
        -- stylua: ignore
        keys = {
            { "<tab>", false },
            {
                "<A-a>",
                function()
                    local cli = require("sidekick.cli")
                    local State = require("sidekick.cli.state")
                    local sessions = State.get({ attached = true })
                    if #sessions > 0 then
                        cli.toggle()
                    else
                        cli.toggle({ name = "opencode", focus = true })
                    end
                end,
                mode = { "n", "i", "t" },
                desc = "Toggle Sidekick CLI",
                silent = true,
                noremap = true,
            },
            {
                "<A-Tab>",
                function()
                    return require("sidekick").nes_jump_or_apply()
                end,
                mode = { "i", "n" },
                expr = true,
                desc = "Goto/Apply Next Edit Suggestion",
                silent = true,
            },
        },
    },
}
