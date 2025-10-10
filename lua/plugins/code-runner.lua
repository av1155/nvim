return {
    {
        "CRAG666/code_runner.nvim",
        dependencies = { "akinsho/toggleterm.nvim" },
        opts = {
            mode = "toggleterm",
            focus = true,
            startinsert = true,
            project_path = vim.fn.expand("~/.config/nvim/projects.json"),
        },
        config = function(_, opts)
            require("code_runner").setup(opts)

            local ok, wk = pcall(require, "which-key")
            if ok then
                -- stylua: ignore
                wk.add({
                    { "<leader>r",  group = "code runner",         icon = { icon = "", color = "green" } },
                    { "<leader>rr", "<cmd>RunCode<cr>",            desc = "Run code",             icon = { icon = "",  color = "green" } },
                    { "<leader>rf", "<cmd>RunFile<cr>",            desc = "Run file",             icon = { icon = "󰈔",  color = "orange" } },
                    { "<leader>rp", "<cmd>RunProject<cr>",         desc = "Run project",          icon = { icon = "",  color = "cyan" } },
                    { "<leader>rc", "<cmd>CRFiletype<cr>",         desc = "Configure filetypes",  icon = { icon = "󰈔",  color = "blue" } },
                    { "<leader>rP", "<cmd>CRProjects<cr>",         desc = "Configure projects",   icon = { icon = "󰙵",  color = "blue" } },

                    { "<leader>rm", group = "run mode",            icon = { icon = "", color = "purple" } },
                    { "<leader>rmt","<cmd>RunFile term<cr>",       desc = "Run (term)",           icon = { icon = "", color = "purple" } },
                    { "<leader>rmf","<cmd>RunFile float<cr>",      desc = "Run (float)",          icon = { icon = "", color = "purple" } },
                    { "<leader>rmT","<cmd>RunFile tab<cr>",        desc = "Run (tab)",            icon = { icon = "󰓩", color = "purple" } },
                    { "<leader>rmo","<cmd>RunFile toggleterm<cr>", desc = "Run (toggleterm)",     icon = { icon = "", color = "purple" } },
                    { "<leader>rmb","<cmd>RunFile buf<cr>",        desc = "Run (buffer)",         icon = { icon = "󰈔", color = "purple" } },
                })
            end
        end,
    },
}
