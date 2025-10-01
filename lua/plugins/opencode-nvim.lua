-- if true then
--     return {}
-- end

return {
    {
        "sudo-tee/opencode.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "folke/snacks.nvim",
            "saghen/blink.cmp",
            {
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    anti_conceal = { enabled = false },
                    file_types = { "markdown", "opencode_output" },
                },
                ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
            },
        },
        config = function()
            require("opencode").setup({
                preferred_picker = "snacks",
                preferred_completion = "blink",
                default_global_keymaps = false,
                keymap = {
                    window = {
                        close = "q", -- Close UI windows
                        stop = "<esc>", -- Stop opencode while it is running
                        select_child_session = "<leader>osS",
                    },
                },
                ui = {
                    icons = {
                        preset = "emoji",
                    },
                    output = {
                        tools = {
                            show_output = true,
                        },
                    },
                },
            })

            local ok, wk = pcall(require, "which-key")
            if ok then
                -- stylua: ignore
                wk.add({
                    { "<leader>o", group = "opencode", mode = {"n", "v"}, icon = { icon = " ", color = "orange" } },

                    { "<leader>oo", "<cmd>Opencode<cr>", desc = "Toggle", icon = { icon = " ", color = "orange" }, mode = { "n", "v" } },
                    { "<leader>oi", function() require("opencode.api").open_input() end, desc = "Open input", icon = { icon = " ", color = "cyan" }, mode = { "n", "v" } },
                    { "<leader>oI", function() require("opencode.api").open_input_new_session() end, desc = "Open input (new session)", icon = { icon = "󰐕 ", color = "cyan" }, mode = { "n", "v" } },
                    { "<leader>og", function() require("opencode.api").open_output() end, desc = "Open output", icon = { icon = "󰈔", color = "cyan" } },
                    { "<leader>ot", function() require("opencode.api").toggle_focus() end, desc = "Toggle focus", icon = { icon = " ", color = "blue" } },
                    { "<leader>oq", function() require("opencode.api").close() end, desc = "Close", icon = { icon = "󰈆 ", color = "red" } },
                    { "<leader>ox", function() require("opencode.api").swap_position() end, desc = "Swap position", icon = { icon = " ", color = "blue" } },

                    { "<leader>os", group = "Session", icon = { icon = " ", color = "azure" } },
                    { "<leader>oss", function() require("opencode.api").select_session() end, desc = "Select session", icon = { icon = " ", color = "azure" } },
                    { "<leader>osS", function() require("opencode.api").select_child_session() end, desc = "Select child session", icon = { icon = " ", color = "azure" } },

                    { "<leader>om", group = "Mode", icon = { icon = " ", color = "purple" } },
                    { "<leader>omb", function() require("opencode.api").agent_build() end, desc = "Build mode", icon = { icon = " ", color = "orange" } },
                    { "<leader>omp", function() require("opencode.api").agent_plan() end, desc = "Plan mode", icon = { icon = "󱅻 ", color = "cyan" } },
                    { "<leader>oms", function() require("opencode.api").select_agent() end, desc = "Select agent", icon = { icon = " ", color = "purple" } },

                    { "<leader>op", function() require("opencode.api").configure_provider() end, desc = "Configure provider", icon = { icon = " ", color = "green" } },

                    { "<leader>od", group = "Diff", icon = { icon = " ", color = "blue" } },
                    { "<leader>odo", function() require("opencode.api").diff_open() end, desc = "Open diff", icon = { icon = " ", color = "blue" } },
                    { "<leader>odn", function() require("opencode.api").diff_next() end, desc = "Next file", icon = { icon = " ", color = "blue" } },
                    { "<leader>odp", function() require("opencode.api").diff_prev() end, desc = "Prev file", icon = { icon = " ", color = "blue" } },
                    { "<leader>odc", function() require("opencode.api").diff_close() end, desc = "Close diff", icon = { icon = "󰈆 ", color = "red" } },

                    { "<leader>or", group = "Revert", icon = { icon = " ", color = "red" } },
                    { "<leader>ora", function() require("opencode.api").diff_revert_all_last_prompt() end, desc = "All (last prompt)", icon = { icon = " ", color = "red" } },
                    { "<leader>ort", function() require("opencode.api").diff_revert_this_last_prompt() end, desc = "This file (last prompt)", icon = { icon = " ", color = "red" } },
                    { "<leader>orA", function() require("opencode.api").diff_revert_all_session() end, desc = "All (session)", icon = { icon = " ", color = "red" } },
                    { "<leader>orT", function() require("opencode.api").diff_revert_this_session() end, desc = "This file (session)", icon = { icon = " ", color = "red" } },

                    { "<leader>ou", group = "Utility", icon = { icon = " ", color = "cyan" } },
                    { "<leader>oui", "<cmd>OpencodeInit<cr>", desc = "Initialize AGENTS.md", icon = { icon = " ", color = "cyan" } },
                    { "<leader>oum", function() require("opencode.api").mcp() end, desc = "List MCP servers", icon = { icon = " ", color = "green" } },
                    { "<leader>ouc", function() require("opencode.api").run_user_command() end, desc = "Run user command", icon = { icon = " ", color = "orange" } },
                    { "<leader>ous", function() require("opencode.api").stop() end, desc = "Stop execution", icon = { icon = "󰈆 ", color = "red" } },

                })
            end
        end,
    },
}
