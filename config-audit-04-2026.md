# Neovim Configuration: Complete Analysis

> Comprehensive audit of Andrea Venti's Neovim + LazyVim configuration.
> All 8 documentation agents completed. Full cross-reference included.

---

## Environment

- Neovim: **v0.12.0** (Release, LuaJIT 2.1.1774896198)
- Framework: **LazyVim v8** (main branch)
- Plugin manager: **lazy.nvim** (main branch)
- Platform: macOS Darwin 24.6.0
- Formatter: StyLua (4-space indent, 120 col width)
- Python host: set via `$NVIM_PYTHON_PATH` env var

---

## Directory Structure

```
~/.config/nvim/
  init.lua                      # Entry point: require("config.lazy")
  lazyvim.json                  # 38 enabled LazyVim extras
  lazy-lock.json                # 88 locked plugins
  .editorconfig                 # UTF-8, 4-space indent, final newline
  .neoconf.json                 # neodev library + lua_ls plugin enabled
  stylua.toml                   # 4 spaces, 120 col width
  LICENSE
  ansi/gopher.sh                # Shell script resource
  lua/
    config/
      lazy.lua                  # Bootstrap lazy.nvim, load specs
      options.lua               # Editor options (4-tab, no relnumber, wrap)
      keymaps.lua               # 208 lines of custom keybindings
      autocmds.lua              # 233 lines of highlight overrides + autocmds
    plugins/                    # 32 plugin spec files
      alpha.lua
      avante.lua                # DISABLED
      barbar.lua
      blink-cmp.lua
      code-runner.lua
      codesnap.lua
      colorscheme.lua
      comment.lua
      copilot.lua
      edgy.lua
      goto-preview.lua
      guess-indent.lua
      illuminate.lua
      lsp-config.lua
      lualine.lua
      markdown-preview.lua
      mason.lua
      mini-animate.lua
      neo-tree.lua
      noice.lua
      nvim-lint.lua
      opencode-nvim.lua         # DISABLED
      opencode-terminal.lua     # DISABLED
      searchbox.lua
      sidekick.lua
      statuscol.lua
      telescope.lua
      tiny-code-action.lua
      tiny-inline-diagnostic.lua
      toggleterm.lua
      which-key.lua
      yanky.lua
      code_runner/projects.json # Project configs (Dockitect: pnpm run dev)
    util/
      close_or_alpha.lua        # Smart buffer close, fallback to Alpha
      go_iferr.lua              # Go "if err != nil" snippet inserter
      man_hover.lua             # Man page hover in floating window
  .claude/
    settings.local.json         # Claude Code local permissions
```

No `ftplugin/`, `after/`, `snippets/`, `spell/`, or `.luarc.json` directories.

---

## Core Config Files

### options.lua
| Option | Value | Note |
|---|---|---|
| relativenumber | false | Absolute line numbers |
| shiftwidth | 4 | Indent size |
| tabstop | 4 | Tab width |
| wrap | true | Line wrapping on |
| showbreak | "up arrow " | Wrap indicator |
| python3_host_prog | $NVIM_PYTHON_PATH | External env var |
| lazyvim_prettier_needs_config | true | Prettier only with config file |

### keymaps.lua (208 lines, 8 sections)

**Unmapped LazyVim defaults:** `<leader>bb`, `bo`, `bd`, `bD`, `fn`, `K`, `|`

**Kitty terminal emulation:**
- `M-b` / `M-f` word left/right (normal, visual, insert, cmdline)
- `Home` / `End` line start/end
- `M-BS` delete word (insert, cmdline)

**Buffer management:**
- `A-c` close buffer (smart: falls back to Alpha if last window)
- `A-C` force close
- `leader+bn` new file
- `leader+bA` add current dir as project
- `leader+\` split right

**External tools:**
- `leader+y` open Yazi file manager (floating toggleterm)

**Editing:**
- `leader+W` save without formatting
- `leader+fw` ripgrep find words

**Clipboard:**
- `C-c` copy file (normal) / selection (visual)
- `C-x` delete file (normal) / cut selection (visual)
- `Tab` / `S-Tab` indent/dedent (visual)

**Numbers:**
- `+` increment, `=` decrement

**Quit:**
- `C-q` quit all (confirm)
- `leader+qq` quit window
- `leader+qQ` quit all

**Go:**
- `leader+ce` insert `if err != nil` block

### autocmds.lua (233 lines)

Massive highlight override system that applies on startup AND after every colorscheme change:
- Blink-cmp menu/doc: transparent backgrounds
- DAP virtual text: custom fg colors
- Barbar: full buffer tab color scheme (current, inactive, alternate, visible states with git/diagnostic/file status variants)
- Cursor/visual selection colors
- Neo-tree: directory/git status colors
- VS Code-style CMP item kind colors (Function=purple, Variable=blue, Class=orange, etc.)
- Aerial icon colors matching VS Code theme
- Spell underline colors
- LSP inlay hints: gray italic
- Alpha dashboard: custom header/button/shortcut/footer colors

Functional autocmds:
- Disable spell in markdown
- Mason auto-update after Lazy sync

---

## LazyVim Extras (38 enabled)

### AI
- `lazyvim.plugins.extras.ai.copilot`
- `lazyvim.plugins.extras.ai.sidekick`

### Coding
- `lazyvim.plugins.extras.coding.luasnip`
- `lazyvim.plugins.extras.coding.yanky`

### DAP (Debugging)
- `lazyvim.plugins.extras.dap.core`
- `lazyvim.plugins.extras.dap.nlua`

### Editor
- `lazyvim.plugins.extras.editor.aerial`
- `lazyvim.plugins.extras.editor.illuminate`
- `lazyvim.plugins.extras.editor.inc-rename`
- `lazyvim.plugins.extras.editor.neo-tree`

### Formatting
- `lazyvim.plugins.extras.formatting.black`
- `lazyvim.plugins.extras.formatting.prettier`

### Languages (17 total)
- Ansible, clangd, CMake, Docker, Git, Go, Java, JSON, Markdown, Python, SQL, Tailwind, Terraform, TOML, TypeScript, YAML

### Testing
- `lazyvim.plugins.extras.test.core`

### UI
- `lazyvim.plugins.extras.ui.alpha`
- `lazyvim.plugins.extras.ui.edgy`
- `lazyvim.plugins.extras.ui.mini-animate`
- `lazyvim.plugins.extras.ui.treesitter-context`

### Util
- `lazyvim.plugins.extras.util.dot`
- `lazyvim.plugins.extras.util.mini-hipatterns`
- `lazyvim.plugins.extras.util.project`

---

## Plugin Inventory (88 total in lazy-lock.json)

### Actively Configured (32 spec files)

#### Theme & Visual
| Plugin | Config Summary |
|---|---|
| **catppuccin** | Mocha flavor, transparent bg, 14+ integrations |
| **tokyonight** | Transparent, fallback colorscheme |
| **lualine** | Custom "bubbles" theme, mode colors, copilot toggle, python env, clickable diagnostics |
| **barbar** | Tab bar with git/diagnostic icons, S-Tab/Tab nav, A-1..9 jump, pin support |
| **alpha-nvim** | Dashboard with time greeting, fortune quotes, 10 buttons, locked scroll |
| **statuscol** | 3 segments: DAP signs, line numbers, gitsigns (clickable preview/stage/reset), UFO fold support |
| **mini.animate** | Window open/close animations (25 steps), disabled for sidekick |
| **noice** | Cmdline popup (30% row), LSP hover (rounded, 25x90), filtered notifications |
| **which-key** | Helix preset |
| **edgy** | Exit when last, rounded borders |

#### LSP & Completion
| Plugin | Config Summary |
|---|---|
| **nvim-lspconfig** | Custom diagnostic signs, no virtual text, underline, severity sort |
| **blink.cmp** | No preselect, manual selection, Tab/CR navigation, copilot source |
| **copilot.lua** | Telemetry disabled, blink integration |
| **mason** | Rounded borders, mason-extra-cmds |
| **tiny-code-action** | Snacks picker, vim diff backend |
| **tiny-inline-diagnostic** | Modern preset, multiline, transparent cursorline, priority 2048 |
| **goto-preview** | Box-drawing border, telescope refs, q to close |

#### Navigation & Search
| Plugin | Config Summary |
|---|---|
| **neo-tree** | Custom expanders, Y path copy (5 formats), P preview, exclude DS_Store |
| **telescope** | Horizontal layout, top prompt, ascending sort |
| **searchbox** | leader+s. search/replace buffer |
| **yanky** | -p/-P put with filter |
| **illuminate** | Denylist: alpha, avante, aerial, lazy, neo-tree, toggleterm, help, Trouble |

#### Code Execution & Tools
| Plugin | Config Summary |
|---|---|
| **code-runner** | Toggleterm mode, 14 languages, project configs |
| **toggleterm** | A-z toggle, floating |
| **codesnap** | CaskaydiaCove font, ~/Downloads output, clipboard/file modes |
| **markdown-preview** | Light theme, leader+cp |
| **comment** | leader+/ line, leader+' block |
| **guess-indent** | 10 excluded filetypes |
| **nvim-lint** | markdownlint-cli2 custom config |

#### AI (mostly disabled)
| Plugin | Config Summary |
|---|---|
| **sidekick** | A-a toggle, A-Tab edit suggestions, tmux support |
| **avante** | DISABLED; configured for Claude Sonnet 4 + Moonshot Kimi-K2 |
| **opencode-nvim** | DISABLED |
| **opencode-terminal** | DISABLED |

### LazyVim-Managed Plugins (not custom-configured, from extras)

aerial.nvim, bufferline.nvim (likely overridden by barbar), clangd_extensions.nvim,
cmake-tools.nvim, conform.nvim, flash.nvim, fortune.nvim, friendly-snippets,
gitsigns.nvim, grug-far.nvim, inc-rename.nvim, lazydev.nvim, logger.nvim,
LuaSnip, mason-lspconfig.nvim, mason-nvim-dap.nvim, mini.ai, mini.hipatterns,
mini.icons, mini.pairs, neotest + neotest-golang + neotest-python, nui.nvim,
nvim-ansible, nvim-dap + dap-go + dap-python + dap-ui + dap-virtual-text,
nvim-jdtls, nvim-nio, nvim-treesitter + context + textobjects, nvim-ts-autotag,
nvim-ufo + promise-async, nvim-web-devicons, one-small-step-for-vimkind,
persistence.nvim, plenary.nvim, project.nvim, render-markdown.nvim,
SchemaStore.nvim, snacks.nvim, telescope-terraform-doc.nvim,
telescope-terraform.nvim, todo-comments.nvim, trouble.nvim, ts-comments.nvim,
venv-selector.nvim, vim-dadbod + dadbod-completion + dadbod-ui

---

## Utility Modules

### close_or_alpha.lua
Smart buffer close: if last normal buffer, opens Alpha dashboard. Supports force close. Used by A-c / A-C keymaps.

### go_iferr.lua
Inserts Go `if err != nil` blocks. Auto-installs the `iferr` binary via `go install`. Strips ANSI codes, handles indentation. Bound to leader+ce.

### man_hover.lua
Opens man pages for word under cursor in a floating window with rounded border. Press q to close and return.

---

## LSP Keymap Architecture

The config replaces LazyVim's default LSP navigation with goto-preview floating windows:

| Key | Action | Plugin |
|---|---|---|
| `gd` | Definition preview | goto-preview |
| `gr` | References preview | goto-preview + telescope |
| `gI` | Implementation preview | goto-preview |
| `gy` | Type definition preview | goto-preview |
| `gD` | Declaration preview | goto-preview |
| `gh` | Hover documentation | Native LSP |
| `gm` | Man page hover | Custom util |
| `gP` | Close all previews | goto-preview |
| `leader+ca` | Code action | tiny-code-action |
| `leader+cA` | Source action | tiny-code-action |

---

## Design Patterns

1. **Modular plugin organization**: one file per plugin in lua/plugins/
2. **LazyVim extras for language support**: 17 language packs enabled
3. **goto-preview pattern**: all LSP navigation uses floating preview windows instead of quickfix
4. **Theme-agnostic highlight system**: autocmds override 100+ highlight groups after every colorscheme change
5. **Disabled-plugin convention**: `if true then return {} end` at top of file
6. **Smart close pattern**: buffer close falls back to Alpha dashboard
7. **Kitty terminal emulation**: Alt-key word motions replicated in all modes
8. **Transparent everything**: both catppuccin and tokyonight set transparent backgrounds

---

## Documentation Cross-Reference (All 8 Agents Complete)

### Theme & Visual Plugins

#### catppuccin (mocha)
- 4 flavors: latte, frappe, macchiato, mocha. You use the darkest.
- 60+ integrations. `auto_integrations = true` auto-detects installed plugins.
- You explicitly disable barbar integration (handled in autocmds instead).
- Unused options worth noting: `dim_inactive` (dim unfocused windows), `blink_cmp` integration has `'bordered'` style.
- `custom_highlights` function receives full color palette for theme-aware overrides.
- `highlight_overrides` supports per-flavor overrides.

#### tokyonight (fallback)
- 4 styles: storm, moon (default), night, day. You don't set one, so it defaults to moon.
- Your transparency config is comprehensive (`transparent = true` + sidebar/float transparent).
- Supports 60+ plugin integrations automatically.
- Has `on_colors()` and `on_highlights()` callbacks for customization.

#### lualine (bubbles theme)
- 40+ built-in themes available. Your custom bubbles theme is fully hand-crafted.
- The `z` sections you use are non-standard but functional.
- Bubble separators: `/`. Component separator: `|`.
- Available extensions you could add: `toggleterm`, `nvim-dap-ui`, `overseer`, `oil`.
- `globalstatus` option available for single statusline across splits.
- `refresh` supports `refresh_time` at 16ms for 60fps.

#### barbar
- 3 icon presets: `default`, `powerline`, `slanted`.
- `auto_hide` can be set to a number N to hide tabline with N or fewer buffers.
- `focus_on_close`: `"left"` / `"previous"` / `"right"` controls which buffer gets focus after close.
- `semantic_letters` for smart label assignment based on buffer names.
- Your icon config covers all states (current, inactive, alternate, visible).

#### alpha-nvim
- 4 section types: `text`, `button`, `padding`, `group`. Also `terminal` for embedded shell.
- Fires `User AlphaReady` and `User AlphaClosed` autocmds (you hook both).
- Your custom `center_layout()` with dynamic top padding is the recommended approach.
- `opts.noautocmd` available to suppress autocmds during setup.

#### statuscol
- Segments support text (string/function), sign (name/text/namespace patterns), and built-in functions.
- Click handlers receive rich `args`: `button` (l/r/m), `mods`, `mousepos.line`.
- Built-in handlers: `toggle_breakpoint`, `diagnostic_click`, `gitsigns_click`, `lnum_click`.
- Your custom `git_click` function follows the recommended pattern.
- `clickmod` option controls which modifier triggers special actions.

#### mini.animate
- 5 animation types: cursor, scroll, resize, open, close.
- Easing functions: none, linear, quadratic, cubic, quartic, exponential.
- Window config generators: `static` (yours), `center`, `wipe`.
- Your sidekick exclusion via custom winconfig returning `{}` is the recommended approach.
- `MiniAnimateDone{Type}` events fire after each animation completes.

#### noice
- 16 built-in views, 7 rendering backends.
- 6 presets: `bottom_search`, `command_palette`, `long_message_to_split`, `inc_rename`, `lsp_doc_border`, `cmdline_output_to_split`.
- 8 cmdline formats: cmdline, search_down, search_up, filter, lua, help, calculator, input.
- Your route filters use `find` (Lua pattern matching on message content).
- `inc_rename` preset integrates with your inc-rename extra.

#### which-key
- 3 presets: `classic` (full-width bottom), `modern` (90% centered), `helix` (compact bottom-right).
- Your helix preset: width 30-60, height up to 75%, rounded border, title left.
- Supports `expand` for lazy-loaded group definitions.
- Plugin integrations: marks, registers, spelling (with `suggestions` count).

#### edgy
- 4 edge positions: left (30), bottom (10), right (30), top (10).
- Has `close_when_all_hidden` and `fix_win_height` options.
- Built-in keymaps: `q` close, `C-q` hide, `Q` close sidebar, `]w`/`[w` window nav.
- Animation support with `fps`, `cps`, `spinner`.

### LSP & Completion Plugins

#### blink.cmp
- Built-in sources: `lsp`, `buffer`, `snippets`, `path`, `omni`.
- 50+ community sources (copilot, dadbod, lazydev, ripgrep, emoji, git, etc.).
- 4 keymap presets: `default`, `super-tab`, `enter`, `none` (yours).
- Ghost text available via `completion.ghost_text.enabled`.
- Snippet preset option: `default`/`luasnip`/`mini_snippets`/`vsnip`.
- Per-filetype source overrides via `sources.per_filetype`.

#### copilot.lua
- Has experimental NES (next edit suggestion) feature requiring `copilot-lsp`.
- `copilot_model` option to specify a particular model.
- `workspace_folders` for better context-aware suggestions.
- `should_attach` function for per-buffer control.
- `server.type`: `"nodejs"` or `"binary"`.
- Difference from copilot.vim: pure Lua, lower CPU, modular APIs, NES support, Neovim-only.

#### nvim-lspconfig
- Nvim 0.11+ introduced `vim.lsp.config()` + `vim.lsp.enable()` pattern.
- Configs can live in `lsp/` and `after/lsp/` directories (your v0.12.0 supports this).
- `virtual_lines` (Nvim 0.11+): renders diagnostics as lines below code (alternative to tiny-inline-diagnostic).
- `jump.wrap` and `jump.on_jump` callback for diagnostic navigation.
- Type annotations (`---@type lspconfig.settings.server_name`) enable setting autocompletion.

#### mason + mason-lspconfig
- `automatic_enable` (default true): auto-calls `vim.lsp.enable()` for installed servers.
- Version pinning with `@` syntax in `ensure_installed`.
- `PATH`: `"prepend"` / `"append"` / `"skip"` controls how Mason binaries are found.
- `max_concurrent_installers`: default 4.
- UI keymaps: i (install), u (update), U (update all), X (uninstall), C-f (language filter).

#### tiny-code-action
- 4 diff backends: `vim` (fastest, yours), `delta`, `difftastic`, `diffsofancy`.
- 5 picker options: `telescope`, `snacks` (yours), `select`, `buffer`, `fzf-lua`.
- `buffer` picker has extensive options: hotkeys, auto_preview, auto_accept, custom_keys.
- `filter`/`filters` for action filtering by string, kind, client, or line.
- `sort` function for custom ordering of code actions.
- `format_title` function for custom action display.

#### tiny-inline-diagnostic
- 8 presets: `modern` (yours), `classic`, `minimal`, `powerline`, `ghost`, `simple`, `nonerdfont`, `amongus`.
- Custom `signs`/`blend` tables completely replace preset defaults (no mixing).
- `show_all_diags_on_cursorline` and `show_diags_only_under_cursor` for cursor behavior.
- `break_line` option for splitting long diagnostics after N characters.
- `override_open_float`: auto-disable when native float opens.
- Experimental `use_window_local_extmarks`: prevents mirroring across splits.

#### goto-preview
- 5 preview types: definition, type_definition, implementation, declaration, references.
- 5 reference providers: `telescope` (yours), `fzf_lua`, `snacks`, `mini_pick`, `default`.
- `stack_floating_preview_windows` for layered preview windows.
- `same_file_float_preview` to open preview even when in same file.
- `post_open_hook`/`post_close_hook` callbacks.
- `dismiss_on_move` to auto-close when cursor moves.

### Navigation & Search Plugins

#### neo-tree
- 50+ event handlers available for lifecycle hooks.
- `group_empty_dirs`: merge empty directory chains into one node.
- `follow_current_file.enabled`: auto-reveal current file in tree.
- `hijack_netrw_behavior`: `"open_default"` / `"open_current"` / `"disabled"`.
- Sources: `filesystem`, `buffers`, `git_status`, `document_symbols`.
- Custom commands table (you use this for `copy_selector`).

#### telescope
- 6 layout strategies: `horizontal` (yours), `vertical`, `center`, `cursor`, `flex`, `bottom_pane`.
- 40+ built-in pickers across file, vim, LSP, git, treesitter categories.
- `telescope-fzf-native.nvim` (compiled C sorter) is strongly recommended for performance.
- Built-in themes: `get_dropdown`, `get_cursor`, `get_ivy`.
- Per-picker overrides via `pickers` table.
- Sizes accept absolute numbers, fractions, or `{ padding = N }`.

#### searchbox
- 5 search modes: `incsearch`, `match_all`, `simple`, `replace` (yours), `replace_last`.
- `confirm` for replace: `"off"`, `"native"`, `"menu"` (visual action list per match).
- 8 modifier options: `ignore-case`, `case-sensitive`, `no-magic`, `magic`, `very-magic`, etc.
- `show_matches` supports custom format strings with `{total}`/`{match}` placeholders.
- `before_mount`/`after_mount`/`on_done` hooks.

#### yanky
- Storage backends: `"shada"` (default), `"sqlite"`, `"memory"`.
- Picker integrations: vim.ui.select, Telescope, Snacks.picker (`Snacks.picker.yanky()`).
- `sync_with_numbered_registers` syncs registers 1-9.
- `update_register_on_cycle` updates register when cycling through ring.
- `system_clipboard.sync_with_ring`: auto-add external yanks.

#### vim-illuminate
- 3 providers in priority order: `lsp`, `treesitter`, `regex`.
- 3 highlight groups: `IlluminatedWordText`, `IlluminatedWordRead`, `IlluminatedWordWrite`.
- `large_file_cutoff` (default 10000 lines) for performance.
- `delay`: default 100ms (minimum 17ms).
- `under_cursor` and `min_count_to_highlight` options.

### Code Execution & Tools

#### toggleterm
- 4 directions: `horizontal`, `vertical`, `float` (yours), `tab`.
- Float border supports `"curved"` (custom to plugin).
- `persist_size`/`persist_mode` remember state across toggles.
- `Terminal:new()` for named custom terminals (lazygit, etc.).
- `shade_terminals`/`shading_factor` for visual distinction.
- `responsiveness.horizontal_breakpoint` for adaptive layouts.

#### code_runner
- 6 run modes: `term`, `float`, `tab`, `toggleterm` (yours), `better_term`, `vimux`.
- Filetype commands support variables: `$file`, `$fileName`, `$fileNameWithoutExt`, `$dir`, `$end`.
- Function-based filetype configs for interactive prompts via `vim.ui.input`.
- `hot_reload` (experimental) for live reloading.
- `before_run_filetype` for pre-execution hooks.

#### Comment.nvim
- `pre_hook` for TSX/JSX context-aware commenting via `ts_context_commentstring`.
- `post_hook` callback with cmode (comment/uncomment) info.
- `extra` mappings: `gcO` (above), `gco` (below), `gcA` (end of line).
- `padding`, `sticky`, `ignore` options for fine-tuning.

#### codesnap
- v2 uses completely different config from v1 (based on CodeSnap Rust library).
- Supports `.png`, `.svg`, `.html` output formats.
- Gradient backgrounds with `start`, `end`, `stops`.
- VSCode themes via Asset URL format: `"name@https://url/to/theme.json"`.
- `CodeSnapHighlight` command for highlighted block screenshots.
- ASCII art mode: `CodeSnapASCII`.

#### markdown-preview
- Theme: `dark`/`light` (yours is light).
- Rendering: KaTeX, PlantUML, Mermaid, Chart.js, Flowchart, sequence diagrams, TOC.
- `g:mkdp_preview_options` controls sync scroll: `'middle'`/`'top'`/`'relative'`.
- `g:mkdp_combine_preview` for tab reuse.
- `g:mkdp_open_to_the_world` for remote access.

#### guess-indent
- Detection runs in under 1ms, fixed heuristic (no tuning params).
- `override_editorconfig = false` (default). Set true to override .editorconfig.
- `on_tab_options`/`on_space_options` for custom behavior per detection result.
- `:GuessIndent` command for manual trigger.

#### nvim-lint
- 200+ built-in linters.
- `linters_by_ft` maps filetypes to lists. Compound filetypes (e.g., `yaml.ghaction`) match on any component.
- Custom linter fields: `cmd`, `stdin`, `args`, `stream`, `parser`, `env`.
- Linters can be tables or functions returning tables for dynamic configuration.

### AI Plugins

#### sidekick.nvim (by folke)
- Two subsystems: NES (Next Edit Suggestions from Copilot LSP) and CLI (terminal for AI tools).
- NES: auto-fetches suggestions, word/char-level diff visualization, hunk navigation.
- CLI tools: aider, claude, codex, copilot, gemini, grok, and more.
- `cli.mux.backend`: `"tmux"` (yours) / `"zellij"`.
- `cli.prompts`: explain, fix, tests, review, etc.
- `cli.picker`: `"snacks"` / `"telescope"` / `"fzf-lua"`.
- Disable per-buffer: `vim.b[buf].sidekick_nes = false`.

### LazyVim-Managed Plugins (docs summary)

#### gitsigns.nvim
- 6 change types with customizable `text`. Separate `signs_staged` table.
- Actions: stage/reset hunk (visual mode partial hunks), preview_hunk, blame_line/blame, diffthis.
- `current_line_blame` with `virt_text_pos` options.
- Statusline via `b:gitsigns_status_dict`.

#### nvim-treesitter + context
- Main branch requires Neovim 0.12+ (yours qualifies).
- Context options: `max_lines`, `mode` (`'cursor'`/`'topline'`), `separator`, `trim_scope`.
- Supports 70+ languages.
- Features enabled separately: highlighting, folds, indentation, injections, locals.

#### aerial.nvim
- 3 backends: `treesitter`, `lsp`, `markdown`. Default prefers treesitter with LSP fallback.
- `filter_kind`: list of SymbolKind strings to display.
- Layout: `prefer_right`/`left`/`float`, `min_width`/`max_width`.
- `show_guides` for tree line rendering.

#### flash.nvim
- Motion types: Search, Jump, Character, Treesitter, Remote, Treesitter Search.
- `search.mode`: `'exact'`/`'search'`/`'fuzzy'`.
- `label.rainbow` for treesitter rainbow colors.
- `jump.autojump` when single match.

#### conform.nvim
- 250+ built-in formatters.
- `format_on_save`/`format_after_save` (async post-save).
- `lsp_format`: `"never"`/`"fallback"`/`"prefer"`/`"first"`/`"last"`.
- Preserves extmarks and folds via minimal diffs.
- Range formatting works even when formatter doesn't support it.

#### trouble.nvim
- Modes: `diagnostics`, `symbols`, `lsp`, `lsp_incoming/outgoing_calls`, `qflist`, `loclist`, `telescope`, `fzf`, `snacks`.
- Preview types: `"main"`, `"split"`, `"float"`.
- `filter.buf = 0` for current buffer only.
- Inline Lua support in commands.

#### render-markdown.nvim
- Presets: `'none'`, `'obsidian'`, `'lazy'`.
- Heading: icons per level, position (overlay/eol/right/inline), width (full/block), border.
- Code blocks: border (none/thick/thin/hide), language icon/name, conceal delimiters.
- Also renders: list bullets, checkboxes, block quotes, callouts, tables, links, LaTeX.

#### nvim-dap + dap-ui + dap-virtual-text
- 3 adapter types: executable (stdio), server (TCP), pipe (unix socket).
- dap-ui: 6 elements (scopes, breakpoints, stacks, watches, repl, console).
- dap-virtual-text: `virt_text_pos` (`"inline"`/`"eol"`), `commented` (prefix with commentstring).
- `virt_lines` (experimental): render as virtual lines.

#### neotest + adapters
- neotest-golang: `runner` (`"go"`/`"gotestsum"`), `testify_enabled`, `dap_go_enabled`.
- neotest-python: `runner` (`"pytest"`/`"unittest"`), `pytest_discover_instances`.
- `default_strategy`: `"integrated"` or `"dap"`.
- `watch.enabled` for file-watch test rerunning.

#### persistence.nvim
- Only 3 options: `dir`, `need` (min buffer count), `branch` (git-branch sessions).
- Custom events: `PersistenceLoadPre/Post`, `PersistenceSavePre/Post`.
- `sessionoptions` (Neovim setting) controls what gets saved.

#### project.nvim
- Detection methods: `lsp` then `pattern` (order matters).
- Pattern syntax: `=` (exact), `^` (ancestor), `>` (direct parent), `!` (exclusion), `*` (glob).
- `scope_chdir`: `"global"` / `"tab"` / `"win"`.
- Telescope integration via `load_extension("projects")`.

#### todo-comments.nvim
- Default keywords: FIX, TODO, HACK, WARN, PERF, NOTE, TEST (each with aliases).
- `merge_keywords = true` merges custom with defaults.
- Search uses `rg` with pattern `\b(KEYWORDS):`.

#### inc-rename.nvim
- `input_buffer_type`: nil / `"dressing"` / `"snacks"`.
- Best integration with noice via `presets = { inc_rename = true }`.
- `post_hook` callback after rename.

#### mini.ai (text objects)
- Built-in: `()`, `[]`, `{}`, `<>`, `"`, `'`, `` ` ``, `?` (prompt), `t` (tag), `f` (function call), `a` (argument), `b` (any bracket), `q` (any quote).
- Treesitter integration via `gen_spec.treesitter()`.
- `search_method`: 6 options controlling match selection behavior.

#### mini.pairs
- Disable per-buffer: `vim.b.minipairs_disable = true`.
- `neigh_pattern` controls when pairs activate based on surrounding characters.

#### venv-selector.nvim
- Supports: venv, Poetry, Pipenv, Anaconda, Pyenv, Hatch, Pipx, PEP-723/uv.
- Picker backends: telescope, fzf-lua, snacks, mini-pick, vim.ui.select.
- Integrates with LSP (pyright/basedpyright), debugpy, lualine, and sets `VIRTUAL_ENV`.

---

## Framework Analysis

### LazyVim extras not enabled (notable candidates)
- `ai.claudecode`: Direct Claude Code integration in Neovim
- `ai.copilot-chat`: Conversational AI panel
- `coding.mini-surround`: Surround operations (no default surround plugin)
- `editor.dial`: Enhanced increment/decrement for dates, booleans, semver
- `editor.harpoon2`: Quick file bookmarks
- `editor.overseer`: Task runner for builds/scripts
- `linting.eslint`: ESLint diagnostics (useful with TypeScript extra)
- `util.startuptime`: Startup profiling (valuable with 38 extras)
- `util.octo`: GitHub PR review from Neovim

### snacks.nvim modules not enabled (recommended)
- `bigfile`: Auto-disables expensive features for large files. Near-zero cost.
- `quickfile`: Renders file content before plugins load. Instant `nvim file.txt`.
- `words`: LSP reference highlights + `]]`/`[[` navigation (complements illuminate).
- `scope`: Scope-aware text objects and jump-to-scope-boundary.

### lazy.nvim optimizations
- Could also disable `netrwPlugin` and `matchit` (since neo-tree is used).
- `git.throttle` exists for Raspberry Pi rate-limiting.
- `custom_keys` for keymaps inside the Lazy window.

---

## Architecture Summary

This is a highly integrated, production-grade Neovim setup with 88 plugins across 38 LazyVim extras, organized with these architectural pillars:

1. **Floating preview paradigm**: LSP navigation, code actions, man pages, and diagnostics all render in floating windows rather than quickfix lists or splits.

2. **Theme-agnostic highlight system**: 100+ highlight groups overridden via autocmds, making the entire UI consistent regardless of which colorscheme is active.

3. **Multi-language workstation**: 17 language packs covering systems (C/C++/Rust/Go), web (TypeScript/Tailwind), infrastructure (Docker/Terraform/Ansible/YAML), data (Python/SQL), and JVM (Java/Kotlin).

4. **AI-augmented workflow**: Copilot for inline completion, sidekick for NES + CLI tools, with avante and opencode as disabled alternatives.

5. **Transparent aesthetic**: Both colorschemes enforce transparency, with the autocmd system ensuring all plugin UIs match.

6. **Smart buffer lifecycle**: Custom close logic always keeps the Alpha dashboard as the fallback, preventing empty Neovim sessions.

7. **Click-driven status column**: Gitsigns preview/stage/reset, DAP breakpoint toggle, and fold operations all accessible via mouse clicks in the gutter.
