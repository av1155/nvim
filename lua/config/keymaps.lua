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
--   2) Kitty Terminal Behavior Matching
--   3) Buffers
--   4) External tools (Yazi)
--   5) Editing helpers (Search/Replace, Save w/o format)
--   6) Clipboard / Cut & Text objects
--   7) Quit & Sessions
--   7) Go: if err != nil helper
--------------------------------------------------------------------------------

-- Standard locals
local map, unmap = vim.keymap.set, vim.keymap.del
local opts = { noremap = true, silent = true }
-- local remap = { silent = true, remap = true }

-- Disable Space's default behavior (move right) to prevent race conditions with leader key
map({ "n", "v" }, "<Space>", "<Nop>", opts)

--------------------------------------------------------------------------------
-- 1) Unmaps ─ Free built-in or LazyVim defaults so we can reassign cleanly
--------------------------------------------------------------------------------

-- LazyVim defaults
unmap("n", "<leader>bb")
unmap("n", "<leader>bo")
unmap("n", "<leader>bd")
unmap("n", "<leader>bD")
unmap("n", "<leader>fn")
unmap("n", "<leader>K")

-- stylua: ignore start

--------------------------------------------------------------------------------
-- 2) Kitty Terminal Behavior Matching
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
-- 3) Buffer navigation & management
--------------------------------------------------------------------------------

-- Replace the default close with a helper that falls back to Alpha if last window
map("n", "<A-c>", function()
  require("util.close_or_alpha").run(false)
end, vim.tbl_extend("force", opts, { desc = "Close (Alpha if last)" }))

-- Force-close version
map("n", "<A-C>", function()
  require("util.close_or_alpha").run(true)
end, vim.tbl_extend("force", opts, { desc = "Force close (Alpha if last)" }))

-- Buffers
map("n", "<leader>bn", "<Cmd>enew<CR>", vim.tbl_extend("force", opts, { desc = "New File" }))

-- Project add
map("n", "<leader>bA", "<cmd>AddProject<cr>", vim.tbl_extend("force", opts, { desc = "Add current dir as project" }))

--------------------------------------------------------------------------------
-- 4) External tools: Yazi file manager (in a floating terminal)
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
-- 5) Editing helpers
--------------------------------------------------------------------------------

-- Save without formatting
map("n", "<leader>W",  ":noautocmd w<CR>", vim.tbl_extend("force", opts, { desc = "Save without formatting" }))

-- Find words with ripgrep
if vim.fn.executable("rg") == 1 then
    map("n", "<leader>fw", function() require("snacks").picker.grep() end, vim.tbl_extend("force", opts, { desc = "Find words in all files" }))
end

--------------------------------------------------------------------------------
-- 6) Clipboard / Cut / Text objects
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

--------------------------------------------------------------------------------
-- Numbers: + increment / = decrement
--------------------------------------------------------------------------------

map({ "n", "v" }, "+", "<C-a>", vim.tbl_extend("force", opts, { desc = "Increment number" }))
map({ "n", "v" }, "=", "<C-x>", vim.tbl_extend("force", opts, { desc = "Decrement number" }))

--------------------------------------------------------------------------------
-- 7) Quit & Sessions remap (confirming)
--------------------------------------------------------------------------------

-- Quit with Ctrl-q
map("n", "<C-q>", "<cmd>confirm qall<CR>",       vim.tbl_extend("force", opts, { desc = "Quit Neovim" }))

-- Simple quit on <leader>q
map("n", "<leader>qq", "<cmd>confirm q<CR>",     vim.tbl_extend("force", opts, { desc = "Quit window" }))

-- Quit ALL on <leader>QQ
map("n", "<leader>qQ", "<cmd>confirm qall<CR>",  vim.tbl_extend("force", opts, { desc = "Quit All" }))

--------------------------------------------------------------------------------
-- 8) Go: if err != nil helper
--------------------------------------------------------------------------------

map("n", "<leader>ce", function()
  require("util.go_iferr").insert()
end, vim.tbl_extend("force", opts, { desc = "Go: Insert if err != nil" }))

-- stylua: ignore end
