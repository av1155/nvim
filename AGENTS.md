# Agent Instructions for Neovim Configuration

## Build/Lint/Test Commands
- **Format Lua**: `stylua .` (indent: 4 spaces, column width: 120)
- **No tests**: This is a personal Neovim config (no test suite)
- **Check health**: `nvim +checkhealth +qa` or open Neovim and run `:checkhealth`

## Code Style Guidelines
- **Language**: Lua (Neovim configuration)
- **Indentation**: 4 spaces (enforced by `.editorconfig` and `stylua.toml`)
- **Line length**: 120 characters max
- **Naming**: `snake_case` for functions/variables, `PascalCase` for plugin specs
- **Imports**: Use `require("module")`, prefer local variables: `local opt = vim.opt`
- **Comments**: Avoid unless explaining non-obvious logic; use descriptive variable/function names
- **Plugin specs**: Return table from `lua/plugins/*.lua`, use lazy.nvim format
- **Options**: Set via `vim.opt.*` in `lua/config/options.lua`
- **Keymaps**: Define in `lua/config/keymaps.lua` using `vim.keymap.set()`
- **Autocmds**: Define in `lua/config/autocmds.lua` using `vim.api.nvim_create_autocmd()`
- **Error handling**: Use `pcall()` for operations that might fail, check return values
- **Types**: No strict typing (Lua), but document expected types in comments when helpful
- **Final newline**: Always insert (enforced by `.editorconfig`)
- **LazyVim integration**: Extend LazyVim defaults, don't replace; use `opts` functions to merge configs
- **File organization**: Plugins in `lua/plugins/*.lua`, utilities in `lua/util/*.lua`, config in `lua/config/*.lua`
