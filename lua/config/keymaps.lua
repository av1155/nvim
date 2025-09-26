-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- This file is automatically loaded by lazyvim.config.init
-- Use vim.keymap.set in your own config (not LazyVim.safe_keymap_set)

local map, unmap = vim.keymap.set, vim.keymap.del
local opts = { noremap = true, silent = true }
local wk = require("which-key")

-- ───────────────────────── Unmapping ─────────────────────────

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

-- ───────────────────── Which-key Groups ─────────────────────
wk.add({
    { "<leader>bs", group = "sort buffers", mode = "n" },
    { "<leader>a", group = "AI", mode = "n" },
    { "<leader>a", group = "AI", mode = "v" },
    { "<leader>cp", group = "codesnap", mode = "v" },
})

-- ───────────────────── Which-key Icons ─────────────────────
wk.add({
    { "<leader>z", desc = "Open Alpha Dashboard", icon = "󰋜", mode = "n" },
    -- or with a color:
    -- { "<leader>z", desc = "Open Alpha Dashboard", icon = { icon = "󰕮", color = "blue" }, mode = "n" },
})

-- stylua: ignore start

-- ───────────────────── BARBAR: Buffer navigation & management ─────────────────────
map("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>", vim.tbl_extend("force", opts, { desc = "Move to previous buffer" }))
map("n", "<Tab>",   "<Cmd>BufferNext<CR>",     vim.tbl_extend("force", opts, { desc = "Move to next buffer" }))
map("n", "<A-<>",   "<Cmd>BufferMovePrevious<CR>", vim.tbl_extend("force", opts, { desc = "Re-order to previous buffer" }))
map("n", "<A->>",   "<Cmd>BufferMoveNext<CR>",     vim.tbl_extend("force", opts, { desc = "Re-order to next buffer" }))
map("n", "<A-1>",   "<Cmd>BufferGoto 1<CR>",   vim.tbl_extend("force", opts, { desc = "Goto buffer 1" }))
map("n", "<A-2>",   "<Cmd>BufferGoto 2<CR>",   vim.tbl_extend("force", opts, { desc = "Goto buffer 2" }))
map("n", "<A-3>",   "<Cmd>BufferGoto 3<CR>",   vim.tbl_extend("force", opts, { desc = "Goto buffer 3" }))
map("n", "<A-4>",   "<Cmd>BufferGoto 4<CR>",   vim.tbl_extend("force", opts, { desc = "Goto buffer 4" }))
map("n", "<A-5>",   "<Cmd>BufferGoto 5<CR>",   vim.tbl_extend("force", opts, { desc = "Goto buffer 5" }))
map("n", "<A-6>",   "<Cmd>BufferGoto 6<CR>",   vim.tbl_extend("force", opts, { desc = "Goto buffer 6" }))
map("n", "<A-7>",   "<Cmd>BufferGoto 7<CR>",   vim.tbl_extend("force", opts, { desc = "Goto buffer 7" }))
map("n", "<A-8>",   "<Cmd>BufferGoto 8<CR>",   vim.tbl_extend("force", opts, { desc = "Goto buffer 8" }))
map("n", "<A-9>",   "<Cmd>BufferGoto 9<CR>",   vim.tbl_extend("force", opts, { desc = "Goto buffer 9" }))
map("n", "<A-0>",   "<Cmd>BufferGoto 0<CR>",   vim.tbl_extend("force", opts, { desc = "Goto buffer 0" }))
map("n", "<A-p>",   "<Cmd>BufferPin<CR>",      vim.tbl_extend("force", opts, { desc = "Pin/unpin buffer" }))
map("n", "<A-c>",   "<Cmd>BufferClose<CR>",    vim.tbl_extend("force", opts, { desc = "Close buffer" }))
map("n", "<leader>z",   "<Cmd>Alpha<CR>",      vim.tbl_extend("force", opts, { desc = "Open Alpha Dashboard" }))

-- Buffers
map("n", "<leader>bn", "<Cmd>enew<CR>", vim.tbl_extend("force", opts, { desc = "New File" }))

-- Close commands
map("n", "<leader>ba", "<Cmd>BufferCloseAllButCurrent<CR>",            vim.tbl_extend("force", opts, { desc = "Close others (keep current)" }))
map("n", "<leader>bp", "<Cmd>BufferCloseAllButPinned<CR>",             vim.tbl_extend("force", opts, { desc = "Close unpinned buffers" }))
map("n", "<leader>bP", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>",    vim.tbl_extend("force", opts, { desc = "Close others (keep current & pinned)" }))

-- Sort buffers
map("n", "<leader>bsb", "<Cmd>BufferOrderByBufferNumber<CR>", vim.tbl_extend("force", opts, { desc = "Sort buffers by buffer number" }))
map("n", "<leader>bsd", "<Cmd>BufferOrderByDirectory<CR>",    vim.tbl_extend("force", opts, { desc = "Sort buffers by directory" }))
map("n", "<leader>bsl", "<Cmd>BufferOrderByLanguage<CR>",     vim.tbl_extend("force", opts, { desc = "Sort buffers by language" }))
map("n", "<leader>bsw", "<Cmd>BufferOrderByWindowNumber<CR>", vim.tbl_extend("force", opts, { desc = "Sort buffers by window number" }))

-- ───────────────────────────── Terminal mode mappings ─────────────────────────────
-- Alt+z: exit terminal-mode and close all ToggleTerm windows
map("t", "<A-z>", function()
  -- exit to normal mode
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
  -- close all toggleterm terminals
  vim.cmd("ToggleTermToggleAll")
end, vim.tbl_extend("force", opts, { desc = "Exit terminal mode and close floating terminal" }))

-- ───────────────────────────── Normal mode helpers ───────────────────────────────
-- Toggle floating terminal
map("n", "<A-z>", "<cmd>ToggleTerm direction=float<CR>", vim.tbl_extend("force", opts, { desc = "Toggle Terminal" }))
map("n", "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", vim.tbl_extend("force", opts, { desc = "Find words in current buffer" }))
map("n", "<leader>fp", "<cmd>Telescope projects<cr>", vim.tbl_extend("force", opts, { desc = "Projects" }))
map("n", "<leader>bA", "<cmd>AddProject<cr>", vim.tbl_extend("force", opts, { desc = "Add Project" }))


-- Open yazi in a floating terminal
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

-- Search & replace and save-without-formatting
map("n", "<leader>s.", ":SearchBoxReplace<CR>", vim.tbl_extend("force", opts, { desc = "Search and Replace on Current Buffer" }))
map("n", "<leader>W",  ":noautocmd w<CR>",      vim.tbl_extend("force", opts, { desc = "Save without formatting" }))

-- ─────────────────────── Clipboard / Cut  ────────────────────
-- Copy entire file / selection
map("n", "<C-c>", ":%y+<CR>",      vim.tbl_extend("force", opts, { desc = "Copy entire file to clipboard" }))
map("v", "<C-c>", '"+y',           vim.tbl_extend("force", opts, { desc = "Copy selection to clipboard" }))

-- Cut entire file / selection
map("n", "<C-x>", ":%d<CR>",       vim.tbl_extend("force", opts, { desc = "Delete entire file" }))
map("v", "<C-x>", '"+d',           vim.tbl_extend("force", opts, { desc = "Cut selection to clipboard" }))

-- Increment / Decrement numbers
map("n", "+", "<C-a>",             vim.tbl_extend("force", opts, { desc = "Increment number" }))
map("n", "=", "<C-x>",             vim.tbl_extend("force", opts, { desc = "Decrement number" }))
map("v", "+", "g<C-a>`<gv",        vim.tbl_extend("force", opts, { desc = "Increment number (keep selection)" }))
map("v", "=", "g<C-x>`<gv",        vim.tbl_extend("force", opts, { desc = "Decrement number (keep selection)" }))

-- Save with Ctrl-S (LazyVim already maps <C-s> globally; this keeps your habit in normal mode)
map("n", "<C-s>", ":w<CR>",        vim.tbl_extend("force", opts, { desc = "Save" }))

-- ───────────────────────── Quit & Sessions remap ─────────────────────────

-- Simple quit on <leader>q
map("n", "<leader>qq", "<cmd>confirm q<CR>", vim.tbl_extend("force", opts, { desc = "Quit window" }))

-- Quit ALL on <leader>QQ
map("n", "<leader>qQ", "<cmd>confirm qall<CR>", vim.tbl_extend("force", opts, { desc = "Quit All" }))

-- ───────────────────────── Codesnap ─────────────────────────

map("v", "<leader>cpc", "<cmd>CodeSnap<cr>", vim.tbl_extend("force", opts, { desc = "Save code snapshot into clipboard" }))
map("v", "<leader>cps", "<cmd>CodeSnapSave<cr>", vim.tbl_extend("force", opts, { desc = "Save code snapshot in ~/Downloads" }))

-- stylua: ignore end
