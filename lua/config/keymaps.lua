--------------------------------------------------------------------------------
-- Keymaps (LazyVim)
--
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Plugin Keymaps: https://www.lazyvim.org/configuration/plugins#%EF%B8%8F-adding--disabling-plugin-keymaps
--   • In the plugin .lua file use `keys = {}`
--
-- For LSP Keymaps: https://www.lazyvim.org/plugins/lsp#%EF%B8%8F-customizing-lsp-keymaps
--   • Same as for plugin keymaps, but you need to configure it using the `opts()` method.
--
-- ❖ Conventions
--   • Always use `vim.keymap.set` (not LazyVim.safe_keymap_set).
--   • Keep a `desc` on every mapping for :WhichKey and :map listing.
--   • Use the shared `opts` and extend it with `vim.tbl_extend("force", opts, { desc = "..." })`.
--   • Unmap defaults first, then declare replacements (prevents flicker/race).
--
-- ❖ Quick Index
--   1) Unmaps (free up defaults)
--   2) Which-Key: Groups & Icons
--   3) Kitty Terminal Behavior Matching
--   4) Plugin: Barbar (buffers)
--   5) Terminal mode mappings
--   6) Normal mode helpers (Telescope, Projects, ToggleTerm)
--   7) External tools (Yazi)
--   8) Editing helpers (Search/Replace, Save w/o format)
--   9) Clipboard / Cut & Text objects
--   10) Quit & Sessions
--   11) Codesnap
--   12) Avante
--------------------------------------------------------------------------------

-- Standard locals
local map, unmap = vim.keymap.set, vim.keymap.del
local remap = { silent = true, remap = true }
local opts = { noremap = true, silent = true }
local wk = require("which-key")

--------------------------------------------------------------------------------
-- 1) Unmaps ─ Free built-in or plugin defaults so we can reassign cleanly
--------------------------------------------------------------------------------

-- Diagnostics
unmap("n", "<leader>K")

-- Buffers
unmap("n", "<leader>bb")
unmap("n", "<leader>bo")
unmap("n", "<leader>bd")
unmap("n", "<leader>bD")
unmap("n", "<leader>fn")

-- Find
unmap("n", "<leader>fp")

-- CopilotChat
unmap({ "n", "v" }, "<leader>aa")
unmap({ "n", "v" }, "<leader>ax")
unmap({ "n", "v" }, "<leader>aq")
unmap({ "n", "v" }, "<leader>ap")

--------------------------------------------------------------------------------
-- 2) Which-Key: Groups & Icons
--------------------------------------------------------------------------------

wk.add({
    { "<leader>bs", group = "sort buffers", mode = "n" },
    { "<leader>a", group = "AI", mode = { "n", "v" } },
    { "<leader>ac", group = "CopilotChat", mode = { "n", "v" } },
    { "<leader>cp", group = "codesnap", mode = "v" },
})

wk.add({
    { "<leader>aa", desc = "avante: Ask", icon = { icon = "", color = "green" }, mode = { "n", "v" } },
    { "<leader>/", desc = "Comments: toggle line", icon = { icon = "", color = "orange" }, mode = { "n" } },
    { "<leader>'", desc = "Comments: toggle block", icon = { icon = "", color = "orange" }, mode = { "n" } },
})

-- stylua: ignore start

--------------------------------------------------------------------------------
-- 3) Kitty Terminal Behavior Matching
--------------------------------------------------------------------------------

--[[
`kitty.conf`
map alt+left      send_text all \x1b\x62
map alt+right     send_text all \x1b\x66
map alt+backspace send_text all \x1b\x7f
map alt+up        send_text all \x1b[F
map alt+down      send_text all \x1b[H

--------------------------------------------------------------------------------
Shell-like Alt word/line motions
kitty sends:
    ⌥← -> M-b, ⌥→ -> M-f, ⌥⌫ -> M-BS
    ⌥↑ -> <End>, ⌥↓ -> <Home>
 ]]
--------------------------------------------------------------------------------

-- NORMAL mode: Alt-word + Home/End
map("n", "<M-b>", "b", vim.tbl_extend("force", opts, { desc = "Alt: word left" }))
map("n", "<M-f>", "w", vim.tbl_extend("force", opts, { desc = "Alt: word right" }))
map("n", "<End>", "$", vim.tbl_extend("force", opts, { desc = "Alt: end of line (via End)" }))
map("n", "<Home>", "0", vim.tbl_extend("force", opts, { desc = "Alt: beginning of line (via Home)" }))

-- VISUAL mode: Alt-word + Home/End (adjust selection by words/line)
map("v", "<M-b>", "b", vim.tbl_extend("force", opts, { desc = "Alt: word left (visual)" }))
map("v", "<M-f>", "w", vim.tbl_extend("force", opts, { desc = "Alt: word right (visual)" }))
map("v", "<End>", "$", vim.tbl_extend("force", opts, { desc = "Alt: end of line (visual)" }))
map("v", "<Home>", "0", vim.tbl_extend("force", opts, { desc = "Alt: beginning of line (visual)" }))

-- INSERT mode: stay in insert while moving/deleting by word
-- Use <C-o>{motion} so we don't leave insert-mode
map("i", "<M-b>", "<C-o>b", vim.tbl_extend("force", opts, { desc = "Alt: word left (insert)" }))
map("i", "<M-f>", "<C-o>w", vim.tbl_extend("force", opts, { desc = "Alt: word right (insert)" }))

-- ⌥⌫ deletes previous word; kitty sends ESC 0x7f (M-BS). Cover both notations.
map("i", "<M-BS>", "<C-w>", vim.tbl_extend("force", opts, { desc = "Alt: delete previous word (insert)" }))
map("i", "<M-Backspace>", "<C-w>", vim.tbl_extend("force", opts, { desc = "Alt: delete previous word (insert, alt name)" }))

-- ⌥↑ / ⌥↓ are End/Home from kitty
-- insert-mode already handles <End>/<Home>, but we add explicit maps
-- for clarity (and to keep WhichKey descriptions consistent).
map("i", "<End>", "<End>", vim.tbl_extend("force", opts, { desc = "Alt: end of line (insert)" }))
map("i", "<Home>", "<Home>", vim.tbl_extend("force", opts, { desc = "Alt: beginning of line (insert)" }))

-- COMMAND-LINE mode: word-jump/delete + Home/End
map("c", "<M-b>", "<S-Left>", vim.tbl_extend("force", opts, { desc = "Alt: word left (cmdline)" }))
map("c", "<M-f>", "<S-Right>", vim.tbl_extend("force", opts, { desc = "Alt: word right (cmdline)" }))
map("c", "<M-BS>", "<C-w>", vim.tbl_extend("force", opts, { desc = "Alt: delete previous word (cmdline)" }))
map("c", "<M-Backspace>", "<C-w>", vim.tbl_extend("force", opts, { desc = "Alt: delete previous word (cmdline, alt name)" }))
map("c", "<End>", "<End>", vim.tbl_extend("force", opts, { desc = "Alt: end of line (cmdline)" }))
map("c", "<Home>", "<Home>", vim.tbl_extend("force", opts, { desc = "Alt: beginning of line (cmdline)" }))

--------------------------------------------------------------------------------
-- 4) Plugin: BARBAR — Buffer navigation & management
--    Requires: 'romgrk/barbar.nvim'
--------------------------------------------------------------------------------

map("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>",     vim.tbl_extend("force", opts, { desc = "Move to previous buffer" }))
map("n", "<Tab>",   "<Cmd>BufferNext<CR>",         vim.tbl_extend("force", opts, { desc = "Move to next buffer" }))
map("n", "<A-<>",   "<Cmd>BufferMovePrevious<CR>", vim.tbl_extend("force", opts, { desc = "Re-order to previous buffer" }))
map("n", "<A->>",   "<Cmd>BufferMoveNext<CR>",     vim.tbl_extend("force", opts, { desc = "Re-order to next buffer" }))
map("n", "<A-1>",   "<Cmd>BufferGoto 1<CR>",       vim.tbl_extend("force", opts, { desc = "Goto buffer 1" }))
map("n", "<A-2>",   "<Cmd>BufferGoto 2<CR>",       vim.tbl_extend("force", opts, { desc = "Goto buffer 2" }))
map("n", "<A-3>",   "<Cmd>BufferGoto 3<CR>",       vim.tbl_extend("force", opts, { desc = "Goto buffer 3" }))
map("n", "<A-4>",   "<Cmd>BufferGoto 4<CR>",       vim.tbl_extend("force", opts, { desc = "Goto buffer 4" }))
map("n", "<A-5>",   "<Cmd>BufferGoto 5<CR>",       vim.tbl_extend("force", opts, { desc = "Goto buffer 5" }))
map("n", "<A-6>",   "<Cmd>BufferGoto 6<CR>",       vim.tbl_extend("force", opts, { desc = "Goto buffer 6" }))
map("n", "<A-7>",   "<Cmd>BufferGoto 7<CR>",       vim.tbl_extend("force", opts, { desc = "Goto buffer 7" }))
map("n", "<A-8>",   "<Cmd>BufferGoto 8<CR>",       vim.tbl_extend("force", opts, { desc = "Goto buffer 8" }))
map("n", "<A-9>",   "<Cmd>BufferGoto 9<CR>",       vim.tbl_extend("force", opts, { desc = "Goto buffer 9" }))
map("n", "<A-0>",   "<Cmd>BufferGoto 0<CR>",       vim.tbl_extend("force", opts, { desc = "Goto buffer 0" }))
map("n", "<A-p>",   "<Cmd>BufferPin<CR>",          vim.tbl_extend("force", opts, { desc = "Pin/unpin buffer" }))

-- Replace the default close with a helper that falls back to Alpha if last window
map("n", "<A-c>", function()
  require("util.close_or_alpha").run(false)
end, vim.tbl_extend("force", opts, { desc = "Close (Alpha if last)" }))

-- Force-close version
map("n", "<A-C>", function()
  require("util.close_or_alpha").run(true)
end, vim.tbl_extend("force", opts, { desc = "Force close (Alpha if last)" }))

-- Buffers
map("n", "<leader>bn", "<Cmd>enew<CR>",                       vim.tbl_extend("force", opts, { desc = "New File" }))

-- Close commands
map("n", "<leader>ba", "<Cmd>BufferCloseAllButCurrent<CR>",   vim.tbl_extend("force", opts, { desc = "Close others (keep current)" }))
map("n", "<leader>bp", "<Cmd>BufferCloseAllButPinned<CR>",    vim.tbl_extend("force", opts, { desc = "Close unpinned buffers" }))
map("n", "<leader>bP", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", vim.tbl_extend("force", opts, { desc = "Close others (keep current & pinned)" }))

-- Sort buffers
map("n", "<leader>bsb", "<Cmd>BufferOrderByBufferNumber<CR>", vim.tbl_extend("force", opts, { desc = "Sort buffers by buffer number" }))
map("n", "<leader>bsd", "<Cmd>BufferOrderByDirectory<CR>",    vim.tbl_extend("force", opts, { desc = "Sort buffers by directory" }))
map("n", "<leader>bsl", "<Cmd>BufferOrderByLanguage<CR>",     vim.tbl_extend("force", opts, { desc = "Sort buffers by language" }))
map("n", "<leader>bsw", "<Cmd>BufferOrderByWindowNumber<CR>", vim.tbl_extend("force", opts, { desc = "Sort buffers by window number" }))

--------------------------------------------------------------------------------
-- 5) Terminal mode mappings
--    Alt+z: exit terminal-mode and close all ToggleTerm windows
--    Requires: 'akinsho/toggleterm.nvim'
--------------------------------------------------------------------------------

map("t", "<A-z>", function()
  -- exit to normal mode
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
  -- close all toggleterm terminals
  vim.cmd("ToggleTermToggleAll")
end, vim.tbl_extend("force", opts, { desc = "Exit terminal mode and close floating terminal" }))

--------------------------------------------------------------------------------
-- 6) Normal mode helpers (Telescope, Projects, ToggleTerm)
--    Requires: telescope.nvim, toggleterm.nvim, project plugin providing :AddProject
--------------------------------------------------------------------------------

-- Toggle floating terminal
map("n", "<A-z>",     "<cmd>ToggleTerm direction=float<CR>",            vim.tbl_extend("force", opts, { desc = "Toggle Terminal" }))

-- Telescope helpers
map("n", "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>",  vim.tbl_extend("force", opts, { desc = "Find words in current buffer" }))

-- Rebound after unmap above: projects picker
map("n", "<leader>fp", "<cmd>Telescope projects<cr>",                   vim.tbl_extend("force", opts, { desc = "Projects" }))

-- Project add
map("n", "<leader>bA", "<cmd>AddProject<cr>",                           vim.tbl_extend("force", opts, { desc = "Add Project" }))

--------------------------------------------------------------------------------
-- 7) External tools: Yazi file manager (in a floating terminal)
--    Requires: toggleterm.nvim and `yazi` installed on PATH
--------------------------------------------------------------------------------

do
  local yazi_term
  map("n", "<leader>y", function()
    local ok, term = pcall(require, "toggleterm.terminal")
    if not ok then return end
    local Terminal = term.Terminal
    yazi_term = yazi_term or Terminal:new({ cmd = "yazi", hidden = true, direction = "float" })
    yazi_term:toggle()
  end, vim.tbl_extend("force", opts, { desc = "Open Yazi file manager" }))
end

--------------------------------------------------------------------------------
-- 8) Editing helpers
--------------------------------------------------------------------------------

-- Search & replace (current buffer) and Save without formatting
map("n", "<leader>s.", ":SearchBoxReplace<CR>",  vim.tbl_extend("force", opts, { desc = "Search and Replace on Current Buffer" }))
map("n", "<leader>W",  ":noautocmd w<CR>",       vim.tbl_extend("force", opts, { desc = "Save without formatting" }))

--------------------------------------------------------------------------------
-- 9) Clipboard / Cut / Text objects
--------------------------------------------------------------------------------

-- Copy entire file / selection
map("n", "<C-c>", ":%y+<CR>",                    vim.tbl_extend("force", opts, { desc = "Copy entire file to clipboard" }))
map("v", "<C-c>", '"+y',                         vim.tbl_extend("force", opts, { desc = "Copy selection to clipboard" }))

-- Cut entire file / selection
map("n", "<C-x>", ":%d<CR>",                     vim.tbl_extend("force", opts, { desc = "Delete entire file" }))
map("v", "<C-x>", '"+d',                         vim.tbl_extend("force", opts, { desc = "Cut selection to clipboard" }))

-- Visual mode: Tab = indent right, Shift-Tab = indent left (keep selection)
map('v', '<Tab>',    '>gv', vim.tbl_extend('force', opts, { desc = 'Indent right' }))
map('v', '<S-Tab>',  '<gv', vim.tbl_extend('force', opts, { desc = 'Indent left' }))

-- Linewise toggle
map('n', '<leader>/', 'gcc', vim.tbl_extend('force', remap, { desc = 'Comments: toggle line' }))
map('x', '<leader>/', 'gc',  vim.tbl_extend('force', remap, { desc = 'Comments: toggle line (visual)' }))

-- Blockwise toggle
map('n', '<leader>\'', 'gbc', vim.tbl_extend('force', remap, { desc = 'Comments: toggle block' }))
map('x', '<leader>\'', 'gb',  vim.tbl_extend('force', remap, { desc = 'Comments: toggle block (visual)' }))

--------------------------------------------------------------------------------
-- Numbers: + increment / = decrement
--------------------------------------------------------------------------------

map({ "n", "v" }, "+", "<C-a>", vim.tbl_extend("force", opts, { desc = "Increment number" }))
map({ "n", "v" }, "=", "<C-x>", vim.tbl_extend("force", opts, { desc = "Decrement number" }))

--------------------------------------------------------------------------------
-- 10) Quit & Sessions remap (confirming)
--------------------------------------------------------------------------------

-- Simple quit on <leader>q
map("n", "<leader>qq", "<cmd>confirm q<CR>",     vim.tbl_extend("force", opts, { desc = "Quit window" }))

-- Quit ALL on <leader>QQ
map("n", "<leader>qQ", "<cmd>confirm qall<CR>",  vim.tbl_extend("force", opts, { desc = "Quit All" }))

--------------------------------------------------------------------------------
-- 11) Codesnap
--     Requires: CodeSnap plugin
--------------------------------------------------------------------------------

map("v", "<leader>cpc", "<cmd>CodeSnap<cr>",     vim.tbl_extend("force", opts, { desc = "Save code snapshot into clipboard" }))
map("v", "<leader>cps", "<cmd>CodeSnapSave<cr>", vim.tbl_extend("force", opts, { desc = "Save code snapshot in ~/Downloads" }))

--------------------------------------------------------------------------------
-- 12) Avante
--     Requires: Avante plugin
--------------------------------------------------------------------------------

map({"n", "v"}, "<leader>aa", "<cmd>AvanteAsk<cr>",     vim.tbl_extend("force", opts, { desc = "avante: ask" }))

-- stylua: ignore end
