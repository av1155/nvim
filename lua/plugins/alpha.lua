vim.api.nvim_set_hl(0, "MyHeaderHighlight", { fg = "#88C0D0", bg = "" })
vim.api.nvim_set_hl(0, "MyGreetingHighlight", { fg = "#81A1C1", bg = "" })
vim.api.nvim_set_hl(0, "MyButtonsHighlight", { fg = "#ECEFF4", bg = "" })
vim.api.nvim_set_hl(0, "MyFooterHighlight", { fg = "#EBCB8B", bg = "" })

return {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        opts = function()
            local dashboard = require("alpha.themes.dashboard")

            -- header
            local header = {
                [[                                                    ]],
                [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
                [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
                [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
                [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
                [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
                [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
                [[                                                    ]],
            }
            dashboard.section.header.val = vim.split(table.concat(header, "\n"), "\n")

            -- greeting
            local function getGreeting(name)
                local t = os.date("*t")
                local datetime = os.date(" %Y-%m-%d   %I:%M %p")
                local idx = (t.hour == 23 or t.hour < 7) and 1
                    or (t.hour < 12) and 2
                    or (t.hour < 18) and 3
                    or (t.hour < 21) and 4
                    or 5
                local g = {
                    [1] = "  Sleep well",
                    [2] = "  Good morning",
                    [3] = "  Good afternoon",
                    [4] = "  Good evening",
                    [5] = "󰖔  Good night",
                }
                return ("%s\t%s, %s"):format(datetime, g[idx], name)
            end
            dashboard.section.greeting = {
                type = "text",
                val = getGreeting("Andrea"),
                opts = { hl = "MyGreetingHighlight", position = "center" },
            }

            dashboard.section.buttons.val = {
                dashboard.button("f", " " .. " Find file", "<cmd> lua LazyVim.pick()() <cr>"),
                dashboard.button("n", " " .. " New file", [[<cmd> ene <BAR> startinsert <cr>]]),
                dashboard.button("r", " " .. " Recent files", [[<cmd> lua LazyVim.pick("oldfiles")() <cr>]]),
                dashboard.button("g", " " .. " Find text", [[<cmd> lua LazyVim.pick("live_grep")() <cr>]]),
                dashboard.button("c", " " .. " Config", "<cmd> lua LazyVim.pick.config_files()() <cr>"),
                dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
                dashboard.button("x", " " .. " Lazy Extras", "<cmd> LazyExtras <cr>"),
                dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
                dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
            }
            for _, b in ipairs(dashboard.section.buttons.val) do
                b.opts.hl = "MyButtonsHighlight"
                b.opts.hl_shortcut = "AlphaShortcut"
            end

            dashboard.section.header.opts.hl = "MyHeaderHighlight"
            dashboard.section.buttons.opts.hl = "MyButtonsHighlight"
            dashboard.section.footer.opts.hl = "MyFooterHighlight"

            -- layout
            local function pad(p)
                return math.floor(vim.o.lines * p)
            end
            dashboard.opts.layout = {
                { type = "padding", val = pad(0.07) },
                dashboard.section.header,
                { type = "padding", val = pad(0.02) },
                dashboard.section.greeting,
                { type = "padding", val = pad(0.04) },
                dashboard.section.buttons,
                { type = "padding", val = pad(0.03) },
                dashboard.section.footer,
                { type = "padding", val = pad(0.02) },
            }

            return dashboard
        end,
        config = function(_, dashboard)
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    once = true,
                    pattern = "AlphaReady",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end
            require("alpha").setup(dashboard.opts)
            vim.api.nvim_create_autocmd("User", {
                once = true,
                pattern = "LazyVimStarted",
                callback = function()
                    local s = require("lazy").stats()
                    local ms = (math.floor(s.startuptime * 100 + 0.5) / 100)
                    dashboard.section.footer.val = ("⚡ Neovim loaded %d/%d plugins in %sms"):format(
                        s.loaded,
                        s.count,
                        ms
                    )
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
    },
}
