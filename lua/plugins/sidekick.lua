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
                    wo = {},
                },
            },
        },
        -- stylua: ignore
        keys = {
            { "<leader>an", false },  -- disable LazyVim's deprecated binding
            {
                "<A-a>",
                function() require("sidekick.cli").toggle({ name = "opencode", focus = true }) end,
                mode = { "n", "t" },
                desc = "Toggle Sidekick OpenCode",
                silent = true,
                noremap = true,
            },
            {
                "<leader>aa",
                function() require("sidekick.cli").toggle({ name = "opencode", focus = true }) end,
                mode = { "n", "v" },
                desc = "Sidekick Toggle OpenCode",
            },
            {
                "<leader>as",
                function() require("sidekick.cli").select() end,
                desc = "Sidekick Select CLI",
            },
            {
                "<leader>as",
                function() require("sidekick.cli").send({ selection = true }) end,
                mode = { "v" },
                desc = "Sidekick Send Visual Selection",
            },
            {
                "<leader>ap",
                function() require("sidekick.cli").prompt() end,
                mode = { "n", "v" },
                desc = "Sidekick Select Prompt",
            },
            {
                "<c-.>",
                function() require("sidekick.cli").focus() end,
                mode = { "n", "x", "i", "t" },
                desc = "Sidekick Switch Focus",
            },
        },
    },
}
