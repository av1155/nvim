return {
    {
        "numToStr/Comment.nvim",
        opts = {},
        init = function()
            local ok, wk = pcall(require, "which-key")
            if ok then
                wk.add({
                    {
                        "<leader>/",
                        desc = "Comments: toggle line",
                        icon = { icon = "", color = "orange" },
                        mode = "n",
                    },
                    {
                        "<leader>'",
                        desc = "Comments: toggle block",
                        icon = { icon = "", color = "orange" },
                        mode = "n",
                    },
                })
            end
        end,
      -- stylua: ignore
      keys = {
        {"<leader>/",  "gcc", mode = "n", desc = "Comments: toggle line",                  remap = true, silent = true},
        {"<leader>/",  "gc",  mode = "x", desc = "Comments: toggle line (visual)",        remap = true, silent = true},
        {"<leader>'",  "gbc", mode = "n", desc = "Comments: toggle block",                 remap = true, silent = true},
        {"<leader>'",  "gb",  mode = "x", desc = "Comments: toggle block (visual)",       remap = true, silent = true},
      }
,
    },
}
