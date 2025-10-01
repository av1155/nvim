# Neovim Improvements Plan

This document summarizes the targeted, non-redundant tweaks discussed previously and provides ready-to-apply snippets. No behavior changes are applied yet; this is a reference for the minimal edits to make.

## Overview

- Project keymap: Replace non-existent `:AddProject` with `Telescope projects` (from `lazyvim.plugins.extras.util.project`).
- Mason post-sync: Keep `:MasonUpdate` on `User LazySync`; avoid `:MasonUpdateAll` on every sync to prevent heavy upgrades.
- Highlight persistence:
  - Blink completion docs use custom `winhighlight` groups; define them (preferably by linking to standard UI groups) and apply on color scheme changes.
  - Alpha custom `My*` highlight groups should be reapplied on color scheme changes.
- Lualine: Remove duplicate `"alpha"` entry in `disabled_filetypes.statusline`.

---

## 3) Highlight Persistence

File: `lua/config/autocmds.lua`

You already have a global highlight override system that re-applies on `ColorScheme`. Extend it for Blink and Alpha.

Recommended approach for Blink: link to standard UI groups so styling stays theme-aware.

```lua
-- Inside your GlobalHighlightsOverrides block in autocmds.lua
local function apply_overrides()
    for group, spec in pairs(overrides) do
        vim.api.nvim_set_hl(0, group, spec)
    end
    -- Theme-aware links for Blink docs popup
    vim.api.nvim_set_hl(0, "BlinkCmpDoc", { link = "Pmenu" })
    vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "BlinkCmpDocCursorLine", { link = "PmenuSel" })
end
```

Also add the Alpha custom groups to your `overrides` table so they persist:

```lua
local overrides = {
    -- ... existing groups ...

    -- Alpha
    MyHeaderHighlight   = fix({ fg = "#88C0D0", bg = "" }),
    MyGreetingHighlight = fix({ fg = "#81A1C1", bg = "" }),
    MyButtonsHighlight  = fix({ fg = "#D8DEE9", bg = "" }),
    MyAlphaShortcut     = { fg = "#A3BE8C", bold = true },
    MyFooterHighlight   = fix({ fg = "#EBCB8B", bg = "" }),
    MyQuoteText         = { fg = "#8FBCBB", italic = true },
}
```

Alternative (static colors for Blink if you prefer):

```lua
BlinkCmpDoc            = fix({ bg = "" }),
BlinkCmpDocBorder      = fix({ fg = "", bg = "" }),
BlinkCmpDocCursorLine  = fix({ bg = "#3a3c47" }),
```

---

## 4) Lualine Duplicate Disabled Filetypes

File: `lua/plugins/lualine.lua`

Remove the duplicate `"alpha"` entry.

```lua
options = {
  -- ...
  disabled_filetypes = {
    statusline = {
      "neo-tree",
      "alpha",  -- keep only once
      "Avante",
    },
    winbar = {},
  },
}
```

---

## Validation

- Format: `stylua .`
- Sync plugins (headless): `nvim --headless -c "Lazy! sync" -c "qa"`
- Manual checks in Neovim:
  - `<leader>bA` opens the Projects picker.
  - After `:Lazy sync`, open `:Mason` → registries updated; packages not auto-upgraded.
  - Trigger completion: Blink docs popup shows proper background/border/cursorline consistent with theme.
  - Change colorscheme (`:colorscheme <name>`) and open `:Alpha` → custom `My*` groups persist.

---

## Appendix: Mason Commands

- `:MasonUpdate` (mason.nvim): updates registries/index of available packages; safe and quick.
- `:MasonUpdateAll` (mason-extra-cmds): upgrades all installed packages; heavier, better run manually on-demand.
