# Agent Guidelines for Neovim Configuration

## Build/Test Commands

- **Format code**: `stylua .` (4-space indent, 120 column width)
- **Health check**: `:checkhealth` in Neovim
- **Validate config**: `nvim --headless -c "Lazy! sync" -c "qa"` (headless plugin sync)
- **Plugin management**: `:Lazy check` and `:Lazy sync` in Neovim
- **LSP tools**: `:Mason` to manage language servers
- No automated test suite; verify changes manually in Neovim

## Code Style

- **Language**: Lua (Neovim configuration)
- **Indentation**: 4 spaces (enforced in stylua.toml and lua/config/options.lua)
- **Line length**: 120 characters max
- **Imports**: Use `require()` with lazy-loading patterns; check existing plugins for integration patterns (e.g., `require("snacks")`, `require("telescope.builtin")`)
- **Plugin structure**: One plugin per file in `lua/plugins/`; return table with lazy.nvim spec
- **Naming**: snake_case for files/functions/variables, PascalCase for plugin names
- **Tables**: Merge with `vim.tbl_deep_extend("force", base, override)` or `vim.tbl_extend()`
- **Options**: Access via `vim.opt` or `vim.g` (never `vim.o`)
- **Keymaps**: Define in plugin specs or `lua/config/keymaps.lua`; always include `desc` field for WhichKey
  - Use `vim.keymap.set()` (not LazyVim.safe_keymap_set)
  - Standard opts: `{ noremap = true, silent = true }`
  - Extend opts: `vim.tbl_extend("force", opts, { desc = "..." })`
- **Error handling**: Wrap risky operations in `pcall()`; notify via `vim.notify()` with severity levels
- **Comments**: Minimal; self-documenting code preferred; use descriptive names
- **UI borders**: Use "rounded" for consistency across floating windows/menus
- **Unmapping**: Check README "Unmapped LazyVim Defaults" section before adding keybinds that may conflict

## Conventions

- **LazyVim-based**: Extend via `opts` function; don't override base config unless necessary
- **Integrations**: Maintain existing patterns (Snacks picker, Blink completion, Catppuccin theme)
- **Plugin additions**: Add to `lua/plugins/` (lazy-lock.json is auto-generated, never edit manually)
- **Config structure**: Options in `lua/config/options.lua`, keymaps in `lua/config/keymaps.lua`, autocmds in `lua/config/autocmds.lua`
- **LSP setup**: Configure in `lua/plugins/lsp-config.lua` using `opts` function pattern
- **Custom utilities**: Place in `lua/util/` directory
- **Stylua ignore**: Use `-- stylua: ignore start/end` blocks for complex tables or alignment-sensitive code
