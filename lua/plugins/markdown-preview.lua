return {
    {
        "iamcco/markdown-preview.nvim",
        keys = {
            { "<leader>cp", ft = "markdown", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview" },
        },
        init = function()
            vim.g.mkdp_theme = "light"
        end,
    },
}
