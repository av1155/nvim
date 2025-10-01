# AGENTS.md - Neovim Configuration Guide

## Build/Lint/Test Commands

- **Lint**: `stylua --check lua/` (4 spaces, 120 cols, double quotes)
- **Format**: `stylua lua/`
- **Test**: `nvim --headless +checkhealth +qa` or launch `nvim`
- **Plugin management**: `:Lazy` (install/update/clean), `:Mason` (LSP/tools)
- **Reload config**: `:Lazy reload {plugin}` or restart Neovim

## Project Structure (LazyVim-based)

- `init.lua`: Bootstrap entry point (loads lazy.nvim)
- `lua/config/`: Core config (options.lua, keymaps.lua, autocmds.lua, lazy.lua)
- `lua/plugins/*.lua`: Plugin specs (auto-loaded by lazy.nvim)
- `lua/util/*.lua`: Custom helper functions
- `lazyvim.json`: LazyVim extras (AI, LSP, lang support) - edit with `:LazyExtras`

## Code Style

- **Plugin specs**: `return { "author/plugin", opts = {}, config = function() end }`
- **Extend opts**: Use `opts = function(_, opts) ... return opts end` to modify defaults
- **Keymaps in plugins**: Define in `keys = {}` table for lazy-loading
- **LSP keymaps**: Modify via `opts.keys` in lsp-config.lua (see existing pattern)
- **Naming**: snake_case vars/funcs, PascalCase classes, `local` over globals

## Development Workflow

1. **Add plugin**: Create `lua/plugins/name.lua` with spec, run `:Lazy install`
2. **Modify LSP**: Edit `lua/plugins/lsp-config.lua` opts function (see tiny-code-action example)
3. **Custom keymaps**: Add to `lua/config/keymaps.lua` (unmap defaults first to avoid conflicts)
4. **Disable LazyVim plugin**: Set `{ "plugin-name", enabled = false }` in any plugin file
5. **Test changes**: `:Lazy reload {plugin}` or `:source %` for Lua files, check `:checkhealth`
6. **Debug**: `:Lazy profile`, `:messages`, `:LspInfo`, `:Mason` for tooling issues
7. **Global highlights**: Use autocmd pattern in autocmds.lua (works across all themes)

## Key Patterns

- **opts function**: `opts = function(_, opts) vim.tbl_deep_extend("force", opts, {...}) end`
- **Keymap unmapping**: `keys[#keys + 1] = { "<key>", false }` (LSP) or `vim.keymap.del()` (global)
- **LazyVim extras**: Managed in `lazyvim.json`, enable/disable with `:LazyExtras`
- **Custom commands**: Define in plugin config or autocmds (see neo-tree copy_selector)
- **Conditional loading**: Use `event`, `ft`, `cmd`, `keys` in plugin spec for lazy-loading
- **Which-key integration**: Set `desc` on all keymaps for auto-discovery

## Common Pitfalls

- Don't modify LazyVim core files directly - override via plugin specs
- Always unmap conflicting LazyVim defaults before reassigning (prevents race conditions)
- Use `vim.schedule()` in autocmds when changing UI/highlights
- Check `lazy-lock.json` into git to ensure reproducible plugin versions
- Set `NVIM_PYTHON_PATH` env var for Python LSP/plugins (see options.lua)
