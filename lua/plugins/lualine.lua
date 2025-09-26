-- Bubbles config for lualine:

-- stylua: ignore
local colors = {
    blue       = '#80a0ff',
    cyan       = '#79dac8',
    -- black  = '#080808', -- transparent
    black      = '',
    white      = '#c6c6c6',
    red        = '#ff5189',
    pink     = '#F4B8E4',
    grey       = '#303030',
    muted_blue = '#5f87af', -- A muted blue color
    dark_grey  = '#262626', -- A new dark grey color for better contrast

}

local bubbles_theme = {
    normal = {
        a = { fg = colors.dark_grey, bg = colors.pink, gui = "bold" },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.black, bg = colors.black },
        z = { fg = colors.white, bg = colors.muted_blue },
    },

    insert = {
        a = { fg = colors.dark_grey, bg = colors.blue, gui = "bold" },
        z = { fg = colors.white, bg = colors.muted_blue },
    },
    visual = {
        a = { fg = colors.dark_grey, bg = colors.cyan, gui = "bold" },
        z = { fg = colors.white, bg = colors.muted_blue },
    },
    replace = {
        a = { fg = colors.dark_grey, bg = colors.red, gui = "bold" },
        z = { fg = colors.white, bg = colors.muted_blue },
    },

    inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.black, bg = colors.black },
        z = { fg = colors.white, bg = colors.muted_blue },
    },
}

local function python_interpreter()
    if vim.bo.filetype == "python" then
        local python_path = os.getenv("NVIM_PYTHON_PATH")
        if python_path then
            -- Check if the path belongs to an environment inside `envs/`
            local env_name = python_path:match(".*/envs/(.-)/bin/python")
            if env_name then
                return " " .. env_name
            else
                if python_path:match(".base/bin/python") then
                    return " Base"
                else
                    return " Python Env"
                end
            end
        else
            return " No Python Interpreter"
        end
    else
        return ""
    end
end

local function lsp_status()
    if vim.o.columns < 100 then
        return ""
    end
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if not clients or #clients == 0 then
        return ""
    end
    local names = {}
    for _, c in ipairs(clients) do
        names[#names + 1] = c.name
    end
    return table.concat(names, ", ")
end

-- Open Trouble workspace diagnostics on click
local function open_trouble_diag()
    -- Prefer Trouble v3 Lua API if available
    local ok, trouble = pcall(require, "trouble")
    if ok and type(trouble.open) == "function" then
        trouble.open({ mode = "diagnostics", focus = true })
        return
    end

    -- Command fallback (works for v3/v2)
    if vim.fn.exists(":Trouble") == 2 then
        vim.cmd("Trouble diagnostics")
        return
    elseif vim.fn.exists(":TroubleToggle") == 2 then
        vim.cmd("TroubleToggle workspace_diagnostics")
        return
    end

    -- Final fallback if Trouble isn't installed
    local ok_tb, tb = pcall(require, "telescope.builtin")
    if ok_tb then
        tb.diagnostics({})
    else
        vim.diagnostic.setqflist()
        vim.cmd("copen")
    end
end

return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "AndreM222/copilot-lualine",
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("lualine").setup({
                options = {
                    theme = bubbles_theme,
                    component_separators = "|",
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {
                        statusline = {
                            "neo-tree",
                            "alpha",
                            "Avante",
                            "alpha",
                        },
                        winbar = {},
                    },
                },
                sections = {
                    lualine_a = {
                        {
                            "mode",
                            on_click = function()
                                if vim.bo.buftype == "" then
                                    vim.cmd("Telescope man_pages")
                                end
                            end,
                            separator = { left = "" },
                            right_padding = 2,
                        },
                    },

                    lualine_b = {
                        {
                            "filename",
                            on_click = function()
                                if vim.bo.buftype == "" then
                                    vim.cmd("Telescope buffers")
                                end
                            end,
                        },

                        {
                            "branch",
                            icon = "",
                            color = { fg = "#c6c6c6" },
                            on_click = function()
                                if vim.bo.buftype == "" then
                                    vim.cmd("Telescope git_branches")
                                end
                            end,
                        },
                    },

                    lualine_c = (function()
                        local has_lazyvim = (LazyVim and LazyVim.lualine)
                        local icons = (LazyVim and LazyVim.config and LazyVim.config.icons)
                            or {
                                diagnostics = { Error = " ", Warn = " ", Info = " ", Hint = " " },
                                git = { added = "+", modified = "~", removed = "-" },
                            }

                        return {
                            { python_interpreter, color = { fg = "#c6c6c6" } },

                            -- show project root (if LazyVim is available)
                            has_lazyvim and LazyVim.lualine.root_dir() or nil,

                            -- diagnostics with icons
                            {
                                "diagnostics",
                                symbols = {
                                    error = icons.diagnostics.Error,
                                    warn = icons.diagnostics.Warn,
                                    info = icons.diagnostics.Info,
                                    hint = icons.diagnostics.Hint,
                                },
                                on_click = function()
                                    if vim.bo.buftype ~= "" then
                                        return
                                    end
                                    open_trouble_diag()
                                end,
                            },

                            -- filetype icon + pretty path
                            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                            has_lazyvim and LazyVim.lualine.pretty_path() or "filename",
                        }
                    end)(),

                    lualine_x = {
                        {
                            lsp_status,
                            icon = " LSP:",
                            color = { fg = "#c6c6c6" },
                            cond = function()
                                return vim.o.columns >= 100 and #vim.lsp.get_clients({ bufnr = 0 }) > 0
                            end,
                            on_click = function()
                                if vim.bo.buftype == "" then
                                    vim.cmd("LspInfo")
                                end
                            end,
                        },

                        -- Lazy updates
                        {
                            function()
                                local ok, status = pcall(require, "lazy.status")
                                return ok and status.updates() or ""
                            end,
                            cond = function()
                                local ok, status = pcall(require, "lazy.status")
                                return ok and status.has_updates()
                            end,
                        },

                        -- DAP status
                        {
                            function()
                                local ok, dap = pcall(require, "dap")
                                return ok and ("  " .. (dap.status() or "")) or ""
                            end,
                            cond = function()
                                local ok, dap = pcall(require, "dap")
                                return ok and dap.status() ~= ""
                            end,
                        },

                        -- Snacks profiler
                        (function()
                            local ok, snacks = pcall(require, "snacks")
                            if ok and snacks.profiler and snacks.profiler.status then
                                return snacks.profiler.status()
                            end
                        end)(),
                    },

                    lualine_y = {
                        -- {
                        --     "copilot",
                        --     show_colors = true,
                        --     show_loading = true,
                        --     symbols = {
                        --         status = {
                        --             icons = {
                        --                 enabled = "",
                        --                 sleep = "",
                        --                 disabled = "",
                        --                 warning = "",
                        --                 unknown = "",
                        --             },
                        --             hl = {
                        --                 enabled = "#50FA7B",
                        --                 sleep = "#50FA7B",
                        --                 disabled = "#6272A4",
                        --                 warning = "#FFB86C",
                        --                 unknown = "#FF5555",
                        --             },
                        --         },
                        --         spinners = "dots",
                        --         spinner_color = "#6272A4",
                        --     },
                        --     on_click = function()
                        --         if vim.bo.buftype ~= "" then
                        --             return
                        --         end
                        --         pcall(function()
                        --             vim.cmd("Copilot panel")
                        --         end)
                        --     end,
                        -- },
                        { "fileformat" },
                        {
                            "progress",
                            color = { fg = "#e06c75", gui = "bold" },
                            separator = { right = "" },
                        },
                    },

                    lualine_z = {
                        {
                            "diff",
                            separator = { right = "" },
                            left_padding = 2,
                            symbols = (
                                (LazyVim and LazyVim.config and LazyVim.config.icons and LazyVim.config.icons.git)
                                or { added = "+", modified = "~", removed = "-" }
                            ),
                            source = function()
                                local g = vim.b.gitsigns_status_dict
                                if g then
                                    return { added = g.added, modified = g.changed, removed = g.removed }
                                end
                            end,
                            on_click = function()
                                if vim.bo.buftype ~= "" then
                                    return
                                end
                                -- Snacks git_status picker
                                local ok, Snacks = pcall(require, "snacks")
                                if ok and Snacks.picker and Snacks.picker.git_status then
                                    Snacks.picker.git_status()
                                    return
                                end
                                -- Telescope fallback
                                pcall(function()
                                    vim.cmd("Telescope git_status")
                                end)
                            end,
                        },
                    },
                },

                inactive_sections = {
                    lualine_a = { "filename" },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = { "location" },
                },
                tabline = {},
                extensions = { "neo-tree", "lazy", "fzf" },
            })
        end,
    },
}
