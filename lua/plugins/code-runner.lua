return {
    {
        "av1155/code_runner.nvim",
        branch = "fix/toggleterm-quote-handling",
        dependencies = { "akinsho/toggleterm.nvim" },
        opts = function()
            local function prompt_args_runner(base_cmd)
                return function()
                    vim.ui.input({ prompt = "Arguments (leave empty for none): " }, function(input)
                        if not input then
                            return
                        end

                        local cmd = base_cmd
                        if input ~= "" then
                            cmd = cmd .. " " .. input
                        end

                        require("code_runner.commands").run_from_fn(cmd)
                    end)
                end
            end

            return {
                mode = "toggleterm",
                focus = true,
                startinsert = true,
                -- stylua: ignore
                filetype = {
                    -- Arguments Not Prompted
                    go = "cd $dir && go run .",

                    -- Arguments Prompted
                    c = prompt_args_runner(
                        "cd $dir && gcc -Wall $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt"
                    ),
                    java = prompt_args_runner(
                        "cd $dir && javac $fileName && java $fileNameWithoutExt"
                    ),
                },
            }
        end,
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
