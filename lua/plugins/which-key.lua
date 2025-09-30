return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            local ok, wk = pcall(require, "which-key")
            if ok then
                wk.add({
                    { "<leader>a", group = "AI", mode = { "n", "v" } },
                })
            end
        end,
        opts = {
            ---@type false | "classic" | "modern" | "helix"
            preset = "helix",
        },
    },
}
