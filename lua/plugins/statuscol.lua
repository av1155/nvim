return {
    {
        "folke/snacks.nvim",
        opts = {
            statuscolumn = { enabled = false },
        },
    },

    {
        "lewis6991/gitsigns.nvim",
        opts = {
            preview_config = {
                style = "minimal",
                border = "rounded",
                relative = "cursor",
                row = 0,
                col = 1,
            },
        },
    },

    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        opts = {
            provider_selector = function()
                return { "treesitter", "indent" }
            end,

            -- Pretty virtual text for closed folds
            ---@param virtText { [1]: string, [2]: string }[]
            ---@param lnum integer
            ---@param endLnum integer
            ---@param width integer
            ---@param truncate fun(str:string, w:integer):string
            fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText, curWidth = {}, 0
                local lines = endLnum - lnum
                local suffix = ("   %d "):format(lines)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                for _, chunk in ipairs(virtText) do
                    local text, hl = chunk[1], chunk[2]
                    local chunkWidth = vim.fn.strdisplaywidth(text)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, { text, hl })
                    else
                        text = truncate(text, targetWidth - curWidth)
                        table.insert(newVirtText, { text, hl })
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, "MoreMsg" })
                return newVirtText
            end,
        },
        config = function(_, opts)
            vim.opt.foldenable = true
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
            vim.opt.foldcolumn = "1"

            vim.opt.fillchars:append({ foldopen = "", foldclose = "", foldsep = " " })

            require("ufo").setup(opts)

            vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds (UFO)" })
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds (UFO)" })
        end,
    },

    {
        "luukvbaal/statuscol.nvim",
        opts = function()
            local builtin = require("statuscol.builtin")

            -- run a function as if the cursor were on `line`
            local function at_line(line, fn)
                local win = vim.api.nvim_get_current_win()
                local cur = vim.api.nvim_win_get_cursor(win)
                pcall(vim.api.nvim_win_set_cursor, win, { line, 0 })
                local ok, err = pcall(fn)
                pcall(vim.api.nvim_win_set_cursor, win, cur)
                return ok, err
            end

            -- Handle clicks on gitsigns and line number segments
            local function git_click(args)
                local gs = require("gitsigns")
                local line = args.mousepos.line
                local mods = args.mods or ""

                if args.button == "l" then
                    if mods:find("c") then
                        return at_line(line, gs.reset_hunk) -- Ctrl+Left: reset
                    else
                        return at_line(line, gs.preview_hunk) -- Left: preview
                    end
                elseif args.button == "r" then
                    return at_line(line, gs.stage_hunk) -- Right: stage
                elseif args.button == "m" then
                    return at_line(line, gs.reset_hunk) -- Middle: reset
                end
            end

            return {
                setopt = true,
                ft_ignore = { "alpha" },
                segments = {
                    {
                        sign = {
                            namespace = { "dap" },
                            name = { "Dap.*" },
                            maxwidth = 1,
                            colwidth = 1,
                            auto = false,
                            fillchar = " ",
                        },
                        click = "v:lua.ScSa",
                    },
                    { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                    {
                        sign = {
                            namespace = { "gitsigns" },
                            name = { "GitSigns.*" },
                            maxwidth = 1,
                            colwidth = 1,
                            auto = false,
                            fillchar = " ",
                        },
                        click = "v:lua.ScSa",
                    },
                },
                clickhandlers = {
                    FoldClose = builtin.foldclose_click,
                    FoldOpen = builtin.foldopen_click,
                    FoldOther = builtin.foldother_click,

                    -- Handle clicks on both Lnum and gitsigns segments
                    Lnum = git_click,
                    gitsigns = git_click,

                    -- DAP breakpoint clicks (toggle breakpoint on click)
                    DapBreakpointRejected = function()
                        require("dap").toggle_breakpoint()
                    end,
                    DapBreakpoint = function()
                        require("dap").toggle_breakpoint()
                    end,
                    DapBreakpointCondition = function()
                        require("dap").toggle_breakpoint()
                    end,
                },
            }
        end,
    },
}
