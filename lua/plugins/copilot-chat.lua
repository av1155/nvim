return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        keys = {
            {
                "<leader>aca",
                function()
                    return require("CopilotChat").toggle()
                end,
                desc = "Toggle (CopilotChat)",
                mode = { "n", "v" },
            },
            {
                "<leader>acx",
                function()
                    return require("CopilotChat").reset()
                end,
                desc = "Clear (CopilotChat)",
                mode = { "n", "v" },
            },
            {
                "<leader>acq",
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
            {
                "<leader>acp",
                function()
                    require("CopilotChat").select_prompt()
                end,
                desc = "Prompt Actions (CopilotChat)",
                mode = { "n", "v" },
            },
        },
    },
}
