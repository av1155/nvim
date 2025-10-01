if true then
    return {}
end

return {
    "NickvanDyke/opencode.nvim",
    dependencies = {
        { "folke/snacks.nvim", opts = { input = { enabled = true } } },
    },
    init = function()
        vim.opt.autoread = true
        vim.g.opencode_opts = vim.g.opencode_opts or {}

        local wk = require("which-key")
        wk.add({
            { "<leader>o", group = "opencode", icon = { icon = "", color = "orange" }, mode = { "n", "v" } },

            { "<leader>ot", desc = "Toggle embedded", icon = { icon = "", color = "yellow" }, mode = "n" },
            { "<leader>oA", desc = "Ask", icon = { icon = "", color = "green" }, mode = "n" },
            { "<leader>oa", desc = "Ask about this", icon = { icon = "", color = "green" }, mode = "n" },
            { "<leader>oa", desc = "Ask about selection", icon = { icon = "", color = "green" }, mode = "v" },
            { "<leader>oe", desc = "Explain this code", icon = { icon = "", color = "orange" }, mode = "n" },
            { "<leader>o+", desc = "Add buffer to prompt", icon = { icon = "󰈔", color = "cyan" }, mode = "n" },
            { "<leader>o+", desc = "Add selection to prompt", icon = { icon = "󰈔", color = "cyan" }, mode = "v" },
            { "<leader>on", desc = "New session", icon = { icon = "", color = "azure" }, mode = "n" },
            { "<leader>os", desc = "Select prompt", icon = { icon = "", color = "green" }, mode = { "n", "v" } },
        })
    end,

    -- stylua: ignore
    keys = {
        { "<leader>ot", function() require("opencode").toggle() end, desc = "Toggle embedded", mode = "n" },
        { "<leader>oA", function() require("opencode").ask() end, desc = "Ask", mode = "n" },
        { "<leader>oa", function() require("opencode").ask("@cursor: ") end, desc = "Ask about this", mode = "n" },
        { "<leader>oa", function() require("opencode").ask("@selection: ") end, desc = "Ask about selection", mode = "v" },
        { "<leader>oe", function() require("opencode").prompt("Explain @cursor and its context") end, desc = "Explain this code", mode = "n" },
        { "<leader>o+", function() require("opencode").prompt("@buffer", { append = true }) end, desc = "Add buffer to prompt", mode = "n" },
        { "<leader>o+", function() require("opencode").prompt("@selection", { append = true }) end, desc = "Add selection to prompt", mode = "v" },
        { "<leader>on", function() require("opencode").command("session_new") end, desc = "New session", mode = "n" },
        { "<S-C-u>",    function() require("opencode").command("messages_half_page_up") end, desc = "Messages half page up", mode = "n" },
        { "<S-C-d>",    function() require("opencode").command("messages_half_page_down") end, desc = "Messages half page down", mode = "n" },
        { "<leader>os", function() require("opencode").select() end, desc = "Select prompt", mode = { "n", "v" } },
    },
}
