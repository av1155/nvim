-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- ──────────────────Global Color Highlight ───────────────────────

-- === Global highlight overrides (work for ANY theme) ===
do
    local aug = vim.api.nvim_create_augroup("GlobalHighlightsOverrides", { clear = true })

    local function fix(spec)
        spec = vim.tbl_extend("force", {}, spec or {})
        if spec.bg == "" then
            spec.bg = "NONE"
        end
        if spec.fg == "" then
            spec.fg = "NONE"
        end
        return spec
    end

    local overrides = {
        -- =================== BLINK-CMP =======================
        BlinkCmpMenu = fix({ bg = "" }),
        BlinkCmpDoc = fix({ bg = "" }),
        BlinkCmpMenuBorder = { link = "FloatBorder" },
        BlinkCmpDocBorder = { link = "FloatBorder" },

        -- =============== NVIM-DAP-VIRTUAL-TEXT ====================
        NvimDapVirtualText = fix({ fg = "#b58900", italic = true }),
        NvimDapVirtualTextError = fix({ fg = "#dc322f", bold = true, underline = true }),
        NvimDapVirtualTextChanged = fix({ fg = "#6c71c4", underline = true }),

        -- =================== BAR-BAR =======================
        -- CURRENT BUFFER
        BufferCurrent = fix({ fg = "#ef9e76", bg = "" }),
        BufferCurrentIndex = fix({ fg = "#ff5189", bg = "" }),
        -- GIT STATUS - ACTIVE
        BufferCurrentAdded = fix({ fg = "#a6e3a2", bg = "" }),
        BufferCurrentDeleted = fix({ fg = "#f38ba9", bg = "" }),
        BufferCurrentChanged = fix({ fg = "#f9e2b0", bg = "" }),
        -- FILE STATUS - ACTIVE
        BufferCurrentMod = fix({ fg = "#ef9e76", bg = "" }),
        BufferCurrentWARN = fix({ fg = "#f9e2b0", bg = "" }),
        BufferCurrentERROR = fix({ fg = "#f38ba9", bg = "" }),
        BufferCurrentHINT = fix({ fg = "#93e2d6", bg = "" }),
        BufferCurrentINFO = fix({ fg = "#89dcec", bg = "" }),
        BufferCurrentSign = fix({ fg = "#89b4fb", bg = "" }),
        BufferCurrentSignRight = fix({ fg = "#89b4fb", bg = "" }),
        -- INACTIVE BUFFERS
        BufferInactive = fix({ fg = "#6c7087", bg = "" }),
        BufferInactiveIndex = fix({ fg = "#89b4fb", bg = "" }),
        -- GIT STATUS - INACTIVE
        BufferInactiveAdded = fix({ fg = "#a6e3a2", bg = "" }),
        BufferInactiveDeleted = fix({ fg = "#f38ba9", bg = "" }),
        BufferInactiveChanged = fix({ fg = "#f9e2b0", bg = "" }),
        -- FILE STATUS - INACTIVE
        BufferInactiveMod = fix({ fg = "#f9e2b0", bg = "" }),
        BufferInactiveWARN = fix({ fg = "#f9e2b0", bg = "" }),
        BufferInactiveERROR = fix({ fg = "#f38ba9", bg = "" }),
        BufferInactiveHINT = fix({ fg = "#93e2d6", bg = "" }),
        BufferInactiveINFO = fix({ fg = "#89dcec", bg = "" }),
        BufferInactiveSign = fix({ fg = "#89b4fb", bg = "" }),
        BufferInactiveSignRight = fix({ fg = "#89b4fb", bg = "" }),
        -- ALTERNATE BUFFERS
        BufferAlternate = fix({ fg = "#ef9e76", bg = "" }),
        -- GIT STATUS - ALTERNATE
        BufferAlternateAdded = fix({ fg = "#a6e3a2", bg = "" }),
        BufferAlternateDeleted = fix({ fg = "#f38ba9", bg = "" }),
        BufferAlternateChanged = fix({ fg = "#f9e2b0", bg = "" }),
        -- FILE STATUS - ALTERNATE
        BufferAlternateMod = fix({ fg = "#f9e2b0", bg = "" }),
        BufferAlternateWARN = fix({ fg = "#f9e2b0", bg = "" }),
        BufferAlternateERROR = fix({ fg = "#f38ba9", bg = "" }),
        BufferAlternateHINT = fix({ fg = "#93e2d6", bg = "" }),
        BufferAlternateINFO = fix({ fg = "#89dcec", bg = "" }),
        BufferAlternateSign = fix({ fg = "#89b4fb", bg = "" }),
        BufferAlternateSignRight = fix({ fg = "#89b4fb", bg = "" }),
        -- VISIBLE BUFFERS
        BufferVisible = fix({ fg = "#8caaee", bg = "" }),
        -- GIT STATUS - VISIBLE
        BufferVisibleAdded = fix({ fg = "#a6e3a2", bg = "" }),
        BufferVisibleDeleted = fix({ fg = "#f38ba9", bg = "" }),
        BufferVisibleChanged = fix({ fg = "#f9e2b0", bg = "" }),
        -- FILE STATUS - VISIBLE
        BufferVisibleMod = fix({ fg = "#f9e2b0", bg = "" }),
        BufferVisibleWARN = fix({ fg = "#f9e2b0", bg = "" }),
        BufferVisibleERROR = fix({ fg = "#f38ba9", bg = "" }),
        BufferVisibleHINT = fix({ fg = "#93e2d6", bg = "" }),
        BufferVisibleINFO = fix({ fg = "#89dcec", bg = "" }),
        BufferVisibleSign = fix({ fg = "#89b4fb", bg = "" }),
        BufferVisibleSignRight = fix({ fg = "#89b4fb", bg = "" }),

        -- ========================= CURSOR ======================
        CursorLine = { bg = "#3a3c47" },
        Visual = { bg = "#775d46" },

        -- ========================= WIN-SEPARATOR ======================
        WinSeparator = fix({ fg = "", bg = "" }),
        EdgyWinSep = fix({ fg = "#45475a", bg = "" }),

        -- ================ NEO-TREE ============================
        NeoTreeWinSeparator = fix({ fg = "#45475a", bg = "" }),
        NeoTreeTabSeparatorInactive = { fg = "#313244", bg = "#1e1e2e" },
        NeoTreeTabSeparatorActive = { fg = "#45475a", bg = "#1e1e2e" },
        NeoTreeDotfile = fix({ fg = "#A8A8A8", bg = "" }),
        NeoTreeHiddenByName = fix({ fg = "#A8A8A8", bg = "" }),

        -- =================== VS CODE CMP ===================
        CmpItemKindConstructor = { fg = "#f28b25" },
        CmpItemKindUnit = { fg = "#D4D4D4" },
        CmpItemKindProperty = { fg = "#D4D4D4" },
        CmpItemKindKeyword = { fg = "#D4D4D4" },
        CmpItemKindMethod = { fg = "#C586C0" },
        CmpItemKindFunction = { fg = "#C586C0" },
        CmpItemKindColor = { fg = "#C586C0" },
        CmpItemKindText = { fg = "#9CDCFE" },
        CmpItemKindInterface = { fg = "#9CDCFE" },
        CmpItemKindVariable = { fg = "#9CDCFE" },
        CmpItemKindField = { fg = "#9CDCFE" },
        CmpItemKindValue = { fg = "#9CDCFE" },
        CmpItemKindEnum = { fg = "#9CDCFE" },
        CmpItemKindEnumMember = { fg = "#9CDCFE" },
        CmpItemKindStruct = { fg = "#9CDCFE" },
        CmpItemKindReference = { fg = "#9CDCFE" },
        CmpItemKindTypeParameter = { fg = "#9CDCFE" },
        CmpItemKindSnippet = { fg = "#D4D4D4" },
        CmpItemKindClass = { fg = "#f28b25" },
        CmpItemKindModule = { fg = "#D4D4D4" },
        CmpItemKindOperator = { fg = "#D4D4D4" },
        CmpItemKindConstant = { fg = "#D4D4D4" },
        CmpItemKindFile = { fg = "#D4D4D4" },
        CmpItemKindFolder = { fg = "#D4D4D4" },
        CmpItemKindEvent = { fg = "#D4D4D4" },
        CmpItemAbbrMatch = { fg = "#18a2fe", bold = true },
        CmpItemAbbrMatchFuzzy = { fg = "#18a2fe", bold = true },
        CmpItemMenu = { fg = "#777d86" },

        -- VS code tree (Aerial)
        AerialArrayIcon = fix({ fg = "" }),
        AerialClassIcon = { fg = "#f28b25" },
        AerialConstantIcon = { fg = "#D4D4D4" },
        AerialConstructorIcon = { fg = "#f28b25" },
        AerialEnumIcon = { fg = "#9CDCFE" },
        AerialEnumMember = { fg = "#9CDCFE" },
        AerialEventIcon = { fg = "#D4D4D4" },
        AerialFieldIcon = { fg = "#9CDCFE" },
        AerialFileIcon = { fg = "#D4D4D4" },
        AerialFunctionIcon = { fg = "#C586C0" },
        AerialInterfaceIcon = { fg = "#9CDCFE" },
        AerialKeyIcon = { fg = "#D4D4D4" },
        AerialMethodIcon = { fg = "#C586C0" },
        AerialModuleIcon = { fg = "#D4D4D4" },
        AerialNamespaceIcon = { fg = "#D4D4D4" },
        AerialNullIcon = { fg = "#D4D4D4" },
        AerialNumberIcon = { fg = "#D4D4D4" },
        AerialObjectIcon = { fg = "#f28b25" },
        AerialOperatorIcon = { fg = "#D4D4D4" },
        AerialPackageIcon = { fg = "#D4D4D4" },
        AerialPropertyIcon = { fg = "#D4D4D4" },
        AerialStringIcon = { fg = "#9CDCFE" },
        AerialStructIcon = { fg = "#f28b25" },
        AerialTypeParameter = { fg = "#9CDCFE" },
        AerialVariableIcon = { fg = "#9CDCFE" },
        AerialGuide = { fg = "#777d86" },

        -- ============ SPELLING =================
        SpellBad = { sp = "#ffbba6", undercurl = true },
        SpellCap = { sp = "#ffbba6", undercurl = true },
        SpellLocal = { sp = "#ffbba6", undercurl = true },
        SpellRare = { sp = "#ffbba6", undercurl = true },

        -- ============ LSP INLAY HINTS ============
        LspInlayHint = { fg = "#8f939b" },
    }

    local function apply_overrides()
        for group, spec in pairs(overrides) do
            vim.api.nvim_set_hl(0, group, spec)
        end
    end

    -- Apply once now
    vim.schedule(apply_overrides)

    -- Re-apply after ANY future :colorscheme
    vim.api.nvim_create_autocmd("ColorScheme", {
        group = aug,
        callback = function()
            -- defer so we run after the theme’s own callbacks
            vim.schedule(apply_overrides)
        end,
        desc = "Apply global highlight overrides after colorscheme",
    })
end

--- ============================================================= ---

-- Disable spell check in markdown files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    callback = function()
        vim.opt_local.spell = false
    end,
})

--- ============================================================= ---

-- Run Mason updates after Lazy finishes syncing
vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("AlphaLazyThenMason", { clear = true }),
    pattern = "LazySync",
    callback = function()
        vim.schedule(function()
            vim.cmd("MasonUpdate")
            vim.cmd("MasonUpdateAll")
        end)
    end,
})
