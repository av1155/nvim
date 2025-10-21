return {
    {
        "CRAG666/code_runner.nvim",
        dependencies = { "akinsho/toggleterm.nvim" },
        opts = function()
            return {
                mode = "toggleterm",
                focus = true,
                startinsert = true,
                -- stylua: ignore
                filetype = {
                    c = 'cd "$dir" && gcc -Wall "$fileName" -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt',
                    cpp = 'cd "$dir" && g++ -Wall "$fileName" -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt',
                    rust = 'cd "$dir" && rustc "$fileName" -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt',
                    java = 'cd "$dir" && javac "$fileName" && java $fileNameWithoutExt',
                    zig = 'cd "$dir" && zig build-exe "$fileName" -femit-bin=/tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt',
                    python = 'cd "$dir" && python3 -u "$fileName"',
                    javascript = 'cd "$dir" && node "$fileName"',
                    typescript = 'cd "$dir" && ts-node --transpileOnly "$fileName"',
                    ruby = 'cd "$dir" && ruby "$fileName"',
                    lua = 'cd "$dir" && lua "$fileName"',
                    sh = 'cd "$dir" && bash "$fileName"',
                    bash = 'cd "$dir" && bash "$fileName"',
                    zsh = 'cd "$dir" && zsh "$fileName"',
                    go = 'cd "$dir" && go run .',
                    kotlin = 'cd "$dir" && kotlinc -script "$fileName" --',
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
                    { "<leader>ra", function()
                        local ft = vim.bo.filetype

                        local configs = {
                            c = {
                                compile_cmd = 'cd "$dir" && gcc $compiler_args "$fileName" -o /tmp/$fileNameWithoutExt',
                                run_cmd = "/tmp/$fileNameWithoutExt $runtime_args",
                                needs_compile = true,
                                default_compiler_args = "-Wall"
                            },
                            cpp = {
                                compile_cmd = 'cd "$dir" && g++ $compiler_args "$fileName" -o /tmp/$fileNameWithoutExt',
                                run_cmd = "/tmp/$fileNameWithoutExt $runtime_args",
                                needs_compile = true,
                                default_compiler_args = "-Wall -std=c++17"
                            },
                            rust = {
                                compile_cmd = 'cd "$dir" && rustc $compiler_args "$fileName" -o /tmp/$fileNameWithoutExt',
                                run_cmd = "/tmp/$fileNameWithoutExt $runtime_args",
                                needs_compile = true,
                                default_compiler_args = ""
                            },
                            java = {
                                compile_cmd = 'cd "$dir" && javac $compiler_args "$fileName"',
                                run_cmd = 'cd "$dir" && java $fileNameWithoutExt $runtime_args',
                                needs_compile = true,
                                default_compiler_args = ""
                            },
                            zig = {
                                compile_cmd = 'cd "$dir" && zig build-exe $compiler_args "$fileName" -femit-bin=/tmp/$fileNameWithoutExt',
                                run_cmd = "/tmp/$fileNameWithoutExt $runtime_args",
                                needs_compile = true,
                                default_compiler_args = ""
                            },
                            python = {
                                run_cmd = 'cd "$dir" && python3 -u "$fileName" $runtime_args',
                                needs_compile = false
                            },
                            javascript = {
                                run_cmd = 'cd "$dir" && node "$fileName" $runtime_args',
                                needs_compile = false
                            },
                            typescript = {
                                run_cmd = 'cd "$dir" && ts-node --transpileOnly "$fileName" $runtime_args',
                                needs_compile = false
                            },
                            ruby = {
                                run_cmd = 'cd "$dir" && ruby "$fileName" $runtime_args',
                                needs_compile = false
                            },
                            lua = {
                                run_cmd = 'cd "$dir" && lua "$fileName" $runtime_args',
                                needs_compile = false
                            },
                            sh = {
                                run_cmd = 'cd "$dir" && bash "$fileName" $runtime_args',
                                needs_compile = false
                            },
                            bash = {
                                run_cmd = 'cd "$dir" && bash "$fileName" $runtime_args',
                                needs_compile = false
                            },
                            zsh = {
                                run_cmd = 'cd "$dir" && zsh "$fileName" $runtime_args',
                                needs_compile = false
                            },
                            go = {
                                run_cmd = 'cd "$dir" && go run . $runtime_args',
                                needs_compile = false
                            },
                            kotlin = {
                                run_cmd = 'cd "$dir" && kotlinc -script "$fileName" -- $runtime_args',
                                needs_compile = false
                            }
                        }

                        local config = configs[ft]
                        if not config then
                            vim.notify("No args config for filetype: " .. ft, vim.log.levels.WARN)
                            return
                        end

                        if config.needs_compile then
                            vim.ui.input({
                                prompt = "Compiler flags (empty for defaults): ",
                                default = config.default_compiler_args
                            }, function(compiler_input)
                                if not compiler_input then return end

                                vim.ui.input({ prompt = "Runtime arguments: " }, function(runtime_input)
                                    if not runtime_input then return end

                                    local compiler_args = compiler_input ~= "" and compiler_input or config.default_compiler_args
                                    local runtime_args = runtime_input ~= "" and runtime_input or ""

                                    local cmd = config.compile_cmd:gsub("$compiler_args", compiler_args)
                                    cmd = cmd .. " && " .. config.run_cmd:gsub("$runtime_args", runtime_args)

                                    require("code_runner.commands").run_from_fn(cmd)
                                end)
                            end)
                        else
                            vim.ui.input({ prompt = "Runtime arguments: " }, function(input)
                                if not input then return end
                                local runtime_args = input ~= "" and input or ""
                                local cmd = config.run_cmd:gsub("$runtime_args", runtime_args)
                                require("code_runner.commands").run_from_fn(cmd)
                            end)
                        end
                    end, desc = "Run with args", icon = { icon = "󰙵", color = "yellow" } },
                    { "<leader>rp", "<cmd>RunProject<cr>",         desc = "Run project",          icon = { icon = "",  color = "cyan" } },
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
