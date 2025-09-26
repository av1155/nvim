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

    { "kevinhwang91/promise-async" },
    {
        "kevinhwang91/nvim-ufo",
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
            -- Fold basics
            vim.opt.foldenable = true
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
            vim.opt.foldcolumn = "1"

            vim.opt.fillchars:append({ foldopen = "", foldclose = "", foldsep = " " })

            require("ufo").setup(opts)

            -- Handy mappings that keep foldlevel stable
            vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds (UFO)" })
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds (UFO)" })
        end,
    },

    {
        "luukvbaal/statuscol.nvim",
        opts = function()
            local builtin = require("statuscol.builtin")

            -- helper: run a function with the cursor temporarily at a specific line
            local function at_line(line, fn)
                local win = vim.api.nvim_get_current_win()
                local cur = vim.api.nvim_win_get_cursor(win)
                pcall(vim.api.nvim_win_set_cursor, win, { line, 0 })
                local ok, err = pcall(fn)
                pcall(vim.api.nvim_win_set_cursor, win, cur)
                return ok, err
            end

            return {
                setopt = true,
                ft_ignore = { "alpha" },
                segments = {
                    { text = { builtin.foldfunc }, click = "v:lua.ScFa" }, -- fold column
                    { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" }, -- line numbers
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
                    -- FOLD CLICKS
                    FoldClose = builtin.foldclose_click,
                    FoldOpen = builtin.foldopen_click,
                    FoldOther = builtin.foldother_click,

                    -- LINE NUMBER CLICKS
                    Lnum = function(args)
                        local gs = require("gitsigns")
                        local line = args.mousepos.line
                        if args.button == "l" then
                            -- preview hunk (floating)
                            return at_line(line, gs.preview_hunk)
                        elseif args.button == "r" then
                            -- stage the hunk under the clicked line
                            return at_line(line, gs.stage_hunk)
                        elseif args.button == "m" then
                            -- RESET the hunk under the clicked line (destructive)
                            return at_line(line, gs.reset_hunk)
                        end
                    end,

                    -- GITSIGNS CLICKS
                    gitsigns = function(args)
                        local gs = require("gitsigns")
                        if args.button == "l" then
                            return gs.preview_hunk()
                        elseif args.button == "r" then
                            return gs.stage_hunk()
                        elseif args.button == "m" then
                            return gs.reset_hunk()
                        end
                    end,

                    -- DISABLED DAP CLICKS
                    DapBreakpointRejected = false,
                    DapBreakpoint = false,
                    DapBreakpointCondition = false,
                },
            }
        end,
    },
}
