vim.api.nvim_set_hl(0, "MyHeaderHighlight", { fg = "#88C0D0", bg = "" })
vim.api.nvim_set_hl(0, "MyGreetingHighlight", { fg = "#81A1C1", bg = "" })
vim.api.nvim_set_hl(0, "MyButtonsHighlight", { fg = "#D8DEE9", bg = "" })
vim.api.nvim_set_hl(0, "MyAlphaShortcut", { fg = "#A3BE8C", bold = true })
vim.api.nvim_set_hl(0, "MyFooterHighlight", { fg = "#EBCB8B", bg = "" })
vim.api.nvim_set_hl(0, "MyQuoteText", { fg = "#8FBCBB", italic = true })

return {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        dependencies = { "rubiin/fortune.nvim" },

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

            -- stylua: ignore
            dashboard.section.buttons.val = {
                dashboard.button("f", " " .. " Find file", "<cmd> lua LazyVim.pick('files', { hidden = true })() <cr>"),
                dashboard.button("n", " " .. " New file", [[<cmd> ene <BAR> startinsert <cr>]]),
                dashboard.button("r", " " .. " Recent files", [[<cmd> lua LazyVim.pick("oldfiles")() <cr>]]),
                dashboard.button("g", " " .. " Find text", [[<cmd> lua LazyVim.pick("live_grep")() <cr>]]),
                dashboard.button("c", " " .. " Config", "<cmd> lua LazyVim.pick.config_files()() <cr>"),
                dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
                dashboard.button("x", " " .. " Lazy Extras", "<cmd> LazyExtras <cr>"),
                dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
                dashboard.button("u", "󰑓 " .. " Lazy Sync", "<cmd> Lazy sync<cr>"),
                dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
            }
            for _, b in ipairs(dashboard.section.buttons.val) do
                b.opts.hl = "MyButtonsHighlight"
                b.opts.hl_shortcut = "MyAlphaShortcut"
            end

            dashboard.section.header.opts.hl = "MyHeaderHighlight"
            dashboard.section.buttons.opts.hl = "MyButtonsHighlight"
            dashboard.section.footer.opts.hl = "MyFooterHighlight"

            -- configure fortune width/format
            pcall(function()
                require("fortune").setup({
                    max_width = 60,
                    display_format = "mixed", -- "short" | "long" | "mixed"
                    content_type = "quotes", -- "quotes" | "tips" | "mixed"
                })
            end)

            -- quotes section
            local fortune = require("fortune")
            local fortune_lines = fortune.get_fortune()
            local filtered_lines = vim.tbl_filter(function(line)
                return not line:match("^%s*%-") and line ~= ""
            end, fortune_lines)
            dashboard.section.fortune = {
                type = "text",
                val = filtered_lines,
                opts = { position = "center", hl = "MyQuoteText" },
            }

            -- layout
            local function pad(p)
                return math.floor(vim.o.lines * p)
            end
            dashboard.opts.layout = {
                { type = "padding", val = pad(0.052) },
                dashboard.section.header,
                { type = "padding", val = pad(0.02) },
                dashboard.section.greeting,
                { type = "padding", val = pad(0.04) },
                dashboard.section.buttons,
                { type = "padding", val = pad(0.02) },
                dashboard.section.footer,
                { type = "padding", val = pad(0.02) },
                dashboard.section.fortune,
                { type = "padding", val = pad(0.01) },
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

            vim.api.nvim_create_autocmd("WinResized", {
                callback = function()
                    local buf = vim.api.nvim_get_current_buf()
                    if vim.bo[buf].filetype == "alpha" then
                        local win = vim.api.nvim_get_current_win()
                        if vim.api.nvim_win_is_valid(win) then
                            pcall(vim.cmd.AlphaRedraw)
                        end
                    end
                end,
            })

            local function apply_lock(buf)
                -- giant margins keep cursor centered; neutralize scroll actions
                vim.wo[0].scrolloff = 999
                vim.wo[0].sidescrolloff = 999
                local opts = { buffer = buf, silent = true, nowait = true }
                for _, lhs in ipairs({
                    "<ScrollWheelUp>",
                    "<ScrollWheelDown>",
                    "<S-ScrollWheelUp>",
                    "<S-ScrollWheelDown>",
                    "<ScrollWheelLeft>",
                    "<ScrollWheelRight>",
                    "<C-y>",
                    "<C-e>",
                    "<C-u>",
                    "<C-d>",
                    "<C-b>",
                    "<C-f>",
                    "zh",
                    "zl",
                    "zH",
                    "zL",
                    "zt",
                    "zb",
                    "gg",
                    "G",
                }) do
                    vim.keymap.set("n", lhs, "<nop>", opts)
                end
            end

            -- Run when Alpha has actually drawn its buffer
            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                callback = function()
                    local buf = vim.api.nvim_get_current_buf()
                    if vim.bo[buf].filetype ~= "alpha" then
                        return
                    end

                    vim.api.nvim_set_option_value("buflisted", false, { buf = buf })

                    apply_lock(buf)
                end,
            })

            -- Safety net: if Alpha is already open before AlphaReady fired (rare), catch on BufEnter
            vim.api.nvim_create_autocmd("BufEnter", {
                callback = function(args)
                    if vim.bo[args.buf].filetype ~= "alpha" then
                        return
                    end

                    vim.api.nvim_set_option_value("buflisted", false, { buf = args.buf })

                    -- avoid double-setup by setting a buffer var
                    if vim.b[args.buf].__alpha_center_applied then
                        return
                    end
                    vim.b[args.buf].__alpha_center_applied = true
                    apply_lock(args.buf)
                end,
            })

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

                    local ok, fortune = pcall(require, "fortune")
                    if ok then
                        local fortune_lines = fortune.get_fortune()
                        local filtered_lines = vim.tbl_filter(function(line)
                            return not line:match("^%s*%-") and line ~= ""
                        end, fortune_lines)
                        dashboard.section.fortune.val = filtered_lines
                    end

                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
    },
}
