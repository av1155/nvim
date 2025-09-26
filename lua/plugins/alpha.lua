vim.api.nvim_set_hl(0, "MyHeaderHighlight", { fg = "#88C0D0", bg = "" })
vim.api.nvim_set_hl(0, "MyGreetingHighlight", { fg = "#81A1C1", bg = "" })
vim.api.nvim_set_hl(0, "MyButtonsHighlight", { fg = "#ECEFF4", bg = "" })
vim.api.nvim_set_hl(0, "MyFooterHighlight", { fg = "#EBCB8B", bg = "" })

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

            -- Choose behavior: "lock" to freeze the viewport, or "follow" to keep it centered
            local ALPHA_CENTER_MODE = "lock"

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

            local function apply_follow(buf)
                vim.wo[0].scrolloff = 999
                vim.wo[0].sidescrolloff = 999
                local recentering = false
                local function recenter()
                    if recentering then
                        return
                    end
                    recentering = true
                    vim.schedule(function()
                        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == "alpha" then
                            pcall(vim.cmd, "normal! zz")
                        end
                        recentering = false
                    end)
                end
                -- recenters on cursor move / scroll / resize, but scoped to this buffer
                vim.api.nvim_create_autocmd({ "CursorMoved", "WinScrolled", "VimResized" }, {
                    buffer = buf,
                    callback = recenter,
                })
                -- optional: neutralize pure scrolling so it doesn't fight the recenter
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
                    if ALPHA_CENTER_MODE == "lock" then
                        apply_lock(buf)
                    else
                        apply_follow(buf)
                    end
                end,
            })

            -- Safety net: if Alpha is already open before AlphaReady fired (rare), catch on BufEnter
            vim.api.nvim_create_autocmd("BufEnter", {
                callback = function(args)
                    if vim.bo[args.buf].filetype ~= "alpha" then
                        return
                    end
                    -- avoid double-setup by setting a buffer var
                    if vim.b[args.buf].__alpha_center_applied then
                        return
                    end
                    vim.b[args.buf].__alpha_center_applied = true
                    if ALPHA_CENTER_MODE == "lock" then
                        apply_lock(args.buf)
                    else
                        apply_follow(args.buf)
                    end
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
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
    },
}
