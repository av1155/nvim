# Agent Guidelines for Neovim Configuration

## Build/Test Commands

- **Format Lua files**: `stylua .` (indent: 4 spaces, column width: 120)
- **Check health**: `:checkhealth` in Neovim
- **Test configuration**: `nvim --headless -c "Lazy! sync" -c "qa"`
  (sync plugins headlessly)
- No automated test suite exists; verify changes manually with `:Lazy check` and
  `:Mason`

## Code Style

- **Language**: Lua (Neovim configuration)
- **Indentation**: 4 spaces (configured in stylua.toml and options.lua)
- **Line length**: 120 characters max
- **Imports**: Use `require()` for plugins and utilities; lazy-load with
  LazyVim patterns
- **Plugin structure**: One plugin per file in `lua/plugins/`, return table with
  plugin spec
- **Naming**: snake_case for files/functions, PascalCase for plugin names
- **Tables**: Use `vim.tbl_deep_extend("force", ...)` to merge tables safely
- **Options**: Access via `vim.opt` or `vim.g`, not `vim.o`
- **Keymaps**: Define in plugin specs or `lua/config/keymaps.lua` with
  descriptive `desc` field.
- **Error handling**: Use `pcall()` for risky operations; notify with
  `vim.notify()` levels
- **Comments**: Minimal; prefer self-documenting code and descriptive
  keymap/option names
- **Borders**: Use "rounded" for floating windows/menus (consistency across UI)
- **Disabled defaults**: Check README for unmapped LazyVim keys before adding
  conflicting binds

## Conventions

- LazyVim-based config; extend via `opts` function, don't override base config
- Keep existing integration patterns (e.g., Snacks picker, Blink completion,
  Catppuccin colors)
- Add new plugins to `lua/plugins/`, not `lazy-lock.json` (auto-generated)
