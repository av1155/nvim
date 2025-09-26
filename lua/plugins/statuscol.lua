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

    -- nvim-ufo for pretty fold text + peek
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

            -- Nice gutter icons
            vim.opt.fillchars:append({ foldopen = "", foldclose = "", foldsep = " " })

            require("ufo").setup(opts)

            -- Handy mappings that keep foldlevel stable
            vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds (UFO)" })
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds (UFO)" })

            -- Peek folded lines (fallback to LSP hover)
            vim.keymap.set("n", "K", function()
                local winid = require("ufo").peekFoldedLinesUnderCursor()
                if not winid then
                    pcall(vim.lsp.buf.hover)
                end
            end, { desc = "Peek fold / LSP hover" })
        end,
    },

    -- statuscol.nvim: pretty fold gutter + gitsigns-only click
    {
        "luukvbaal/statuscol.nvim",
        opts = function()
            local builtin = require("statuscol.builtin")
            return {
                setopt = true,

                -- order: folds | (optional) diagnostics on the far-left | LINE NUMBER | GITSIGNS (right of lnum)
                segments = {
                    { text = { builtin.foldfunc }, click = "v:lua.ScFa" }, -- fold column

                    -- OPTIONAL: keep diagnostics on the far left (no clicks)
                    -- remove this block if you don't want diagnostics signs shown
                    {
                        sign = { namespace = { "diagnostic/signs" }, maxwidth = 1, colwidth = 1, auto = true },
                        click = "v:lua.ScSa",
                    },

                    { text = { builtin.lnumfunc, " " } }, -- line numbers + a space

                    {
                        sign = {
                            namespace = { "gitsigns" },
                            name = { "GitSigns.*" },
                            -- maxwidth = 1,
                            -- colwidth = 1,
                            auto = true,
                        },
                        click = "v:lua.ScSa",
                    },
                },

                clickhandlers = {
                    -- fold clicks
                    FoldClose = builtin.foldclose_click,
                    FoldOpen = builtin.foldopen_click,
                    FoldOther = builtin.foldother_click,

                    -- disable other clicks
                    Lnum = false,
                    DapBreakpointRejected = false,
                    DapBreakpoint = false,
                    DapBreakpointCondition = false,
                    ["diagnostic/signs"] = false,

                    -- left-click a git sign → preview hunk
                    gitsigns = function(args)
                        if args.button == "l" then
                            require("gitsigns").preview_hunk()
                        end
                    end,
                },

                -- optional polish
                -- relculright = true,  -- right-align current line when 'relativenumber' is on
            }
        end,
    },
}
