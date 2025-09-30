return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        init = function()
            local ok, wk = pcall(require, "which-key")
            if ok then
                wk.add({
                    {
                        "<leader>a",
                        group = "CopilotChat",
                        icon = { icon = "", color = "orange" },
                        mode = { "n", "v" },
                    },
                })
            end
        end,
        -- Disable default CopilotChat mappings we override
        -- stylua: ignore
        keys = {
            { "<leader>aa", false, mode = { "n", "v" } },
            { "<leader>ax", false, mode = { "n", "v" } },
            { "<leader>aq", false, mode = { "n", "v" } },
            { "<leader>ap", false, mode = { "n", "v" } },

            { "<leader>aa", function() return require("CopilotChat").toggle() end, desc = "Toggle (CopilotChat)", mode = { "n", "v" } },
            { "<leader>ax", function() return require("CopilotChat").reset() end, desc = "Clear (CopilotChat)", mode = { "n", "v" } },
            { "<leader>ap", function() require("CopilotChat").select_prompt() end, desc = "Prompt Actions (CopilotChat)", mode = { "n", "v" } },
            {
                "<leader>aq",
                function()
                    vim.ui.input({
                        prompt = "Quick Chat: ",
                    }, function(input)
                        if input ~= "" then
                            require("CopilotChat").ask(input)
                        end
                    end)
                end,
                desc = "Quick Chat (CopilotChat)",
                mode = { "n", "v" },
            },
        },
    },
}
