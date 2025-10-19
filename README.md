# 💤 LazyVim Configuration

<!-- prettier-ignore-start -->

An opinionated Neovim setup built on top of [LazyVim](https://github.com/LazyVim/LazyVim).

It focuses on great UX out of the box: a slick dashboard, discoverable keymaps, modern
UI, sane LSP/completion defaults, and practical quality-of-life plugins.

This configuration extends LazyVim with custom plugins, keybinds, and workflow
optimizations. For LazyVim's base features, refer to the [official documentation](https://www.lazyvim.org).

---

<!--toc:start-->

- [💤 LazyVim Configuration](#-lazyvim-configuration)
  - [Quick Start](#quick-start)
    - [Post-install tips](#post-install-tips)
  - [Configuration Overview](#configuration-overview)
  - [Custom Plugins](#custom-plugins)
    - [UI/Dashboard](#uidashboard)
      - [alpha.nvim (`lua/plugins/alpha.lua`)](#alphanvim-luapluginsalphalua)
      - [barbar.nvim (`lua/plugins/barbar.lua`)](#barbarnvim-luapluginsbarbarlua)
    - [Editor/Navigation](#editornavigation)
      - [telescope.nvim (`lua/plugins/telescope.lua`)](#telescopenvim-luapluginstelescopelua)
      - [neo-tree.nvim (`lua/plugins/neo-tree.lua`)](#neo-treenvim-luapluginsneo-treelua)
      - [toggleterm.nvim (`lua/plugins/toggleterm.lua`)](#toggletermnvim-luapluginstoggletermlua)
      - [yazi file manager (`lua/config/keymaps.lua`)](#yazi-file-manager-luaconfigkeymapslua)
    - [Completion/LSP](#completionlsp)
      - [blink.cmp (`lua/plugins/blink-cmp.lua`)](#blinkcmp-luapluginsblink-cmplua)
      - [lsp-config.lua (`lua/plugins/lsp-config.lua`)](#lsp-configlua-luapluginslsp-configlua)
      - [tiny-inline-diagnostic.lua (`lua/plugins/tiny-inline-diagnostic.lua`)](#tiny-inline-diagnosticlua-luapluginstiny-inline-diagnosticlua)
      - [tiny-code-action.lua (`lua/plugins/tiny-code-action.lua`)](#tiny-code-actionlua-luapluginstiny-code-actionlua)
      - [illuminate.lua (`lua/plugins/illuminate.lua`)](#illuminatelua-luapluginsilluminatelua)
      - [goto-preview.lua (`lua/plugins/goto-preview.lua`)](#goto-previewlua-luapluginsgoto-previewlua)
    - [AI/Code Generation](#aicode-generation)
      - [copilot.lua (`lua/plugins/copilot.lua`)](#copilotlua-luapluginscopilotlua)
      - [sidekick.nvim (`lua/plugins/sidekick.lua`)](#sidekicknvim-luapluginssidekicklua)
    - [Code Execution](#code-execution)
      - [code-runner.lua (`lua/plugins/code-runner.lua`)](#code-runnerlua-luapluginscode-runnerlua)
    - [UI Enhancements](#ui-enhancements)
      - [lualine.nvim (`lua/plugins/lualine.lua`)](#lualinenvim-luapluginslualinelua)
      - [noice.nvim (`lua/plugins/noice.lua`)](#noicenvim-luapluginsnoicelua)
      - [edgy.nvim (`lua/plugins/edgy.lua`)](#edgynvim-luapluginsedgylua)
      - [statuscol.nvim (`lua/plugins/statuscol.lua`)](#statuscolnvim-luapluginsstatuscollua)
      - [colorscheme.lua (`lua/plugins/colorscheme.lua`)](#colorschemelua-luapluginscolorschemelua)
      - [which-key.nvim (`lua/plugins/which-key.lua`)](#which-keynvim-luapluginswhich-keylua)
    - [Plugin Utilities](#plugin-utilities)
      - [comment.nvim (`lua/plugins/comment.lua`)](#commentnvim-luapluginscommentlua)
      - [yanky.nvim (`lua/plugins/yanky.lua`)](#yankynvim-luapluginsyankylua)
      - [searchbox.nvim (`lua/plugins/searchbox.lua`)](#searchboxnvim-luapluginssearchboxlua)
      - [guess-indent.lua (`lua/plugins/guess-indent.lua`)](#guess-indentlua-luapluginsguess-indentlua)
      - [mini-animate.lua (`lua/plugins/mini-animate.lua`)](#mini-animatelua-luapluginsmini-animatelua)
      - [codesnap.lua (`lua/plugins/codesnap.lua`)](#codesnaplua-luapluginscodesnaplua)
      - [markdown-preview.nvim (`lua/plugins/markdown-preview.nvim`)](#markdown-previewnvim-luapluginsmarkdown-previewlua)
      - [mason.nvim (`lua/plugins/mason.lua`)](#masonnvim-luapluginsmasonlua)
  - [Keymaps](#keymaps)
    - [Unmapped LazyVim Defaults](#unmapped-lazyvim-defaults)
    - [Kitty Terminal Integration](#kitty-terminal-integration)
    - [Buffer Management](#buffer-management)
    - [Editing](#editing)
    - [External Tools](#external-tools)
    - [File Navigation](#file-navigation)
    - [LSP/Code](#lspcode)
    - [Code Execution](#code-execution)
    - [Comments/Snapshots](#commentssnapshots)
    - [Markdown](#markdown)
    - [Yanky](#yanky)
    - [Search](#search)
    - [AI/Sidekick](#aisidekick)
    - [Quit/Session](#quitsession)
  - [Options](#options)
  - [Autocmds](#autocmds)
    - [Global Color Overrides](#global-color-overrides)
    - [Disable Spell Check in Markdown](#disable-spell-check-in-markdown)
    - [Auto-Update Mason After Lazy Sync](#auto-update-mason-after-lazy-sync)
  - [Custom Utilities](#custom-utilities)
    - [close_or_alpha.lua (`lua/util/close_or_alpha.lua`)](#close_or_alphalua-luautilclose_or_alphalua)
    - [go_iferr.lua (`lua/util/go_iferr.lua`)](#go_iferrlua-luautilgo_iferrlua)
    - [man_hover.lua (`lua/util/man_hover.lua`)](#man_hoverlua-luautilman_hoverlua)
  - [License](#license)
  - [Credits](#credits)

<!--toc:end-->
<!-- prettier-ignore-end -->

---

## Quick Start

```bash
# backup any existing config
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

# clone this repo as your Neovim config
git clone https://github.com/av1155/nvim ~/.config/nvim

# start nvim (plugins bootstrap automatically)
nvim
```

### Post-install tips

- Run `:checkhealth` to verify dependencies.
- `:Lazy` to manage plugins; `:Mason` to install language tools if needed.
- If using Python plugins, export:

    ```bash
    export NVIM_PYTHON_PATH="$(pyenv which python || which python3)"
    ```

**Requirements**: See
[LazyVim's requirements](https://www.lazyvim.org/#%EF%B8%8F-requirements).
Additional dependencies: `yazi` for file manager integration, Kitty terminal for
optimal keybind support.

---

## Configuration Overview

| Category       | Location                  |
| -------------- | ------------------------- |
| **Options**    | `lua/config/options.lua`  |
| **Keymaps**    | `lua/config/keymaps.lua`  |
| **Autocmds**   | `lua/config/autocmds.lua` |
| **Lazy Setup** | `lua/config/lazy.lua`     |
| **Plugins**    | `lua/plugins/*.lua`       |
| **Utilities**  | `lua/util/*.lua`          |

---

## LazyVim Extras

> **36 extras enabled** (from `lazyvim.json`). Manage with `:LazyExtras`.  
> Docs: <https://www.lazyvim.org/extras>

### Summary

| Category       | Extras                                                                                                                  | Count |
| -------------- | ----------------------------------------------------------------------------------------------------------------------- | ----: |
| **AI**         | copilot, sidekick                                                                                                       |     2 |
| **Coding**     | luasnip, yanky                                                                                                          |     2 |
| **DAP**        | core, nlua                                                                                                              |     2 |
| **Editor**     | aerial, illuminate, inc-rename, neo-tree                                                                                |     4 |
| **Formatting** | black, prettier                                                                                                         |     2 |
| **Languages**  | ansible, clangd, cmake, docker, git, go, java, json, markdown, python, sql, tailwind, terraform, toml, typescript, yaml |    16 |
| **Test**       | core                                                                                                                    |     1 |
| **UI**         | alpha, edgy, mini-animate, treesitter-context                                                                           |     4 |
| **Util**       | dot, mini-hipatterns, project                                                                                           |     3 |

---

### **Plugin architecture**

- `lazyvim.json` — Base features (36 LazyVim extras)
- `lua/plugins/` — Custom plugins & overrides

---

## Lazy.nvim Configuration

Custom lazy.nvim setup in `lua/config/lazy.lua`:

- **UI customizations**:
  - Backdrop: 100 (opaque background)
  - Border: rounded
  - Size: 80% width and height
- **Auto-checker**: Enabled with notifications for plugin updates
- **Performance**: Disabled plugins (gzip, tarPlugin, tohtml, tutor, zipPlugin)
- **Colorscheme fallbacks**: tokyonight, habamax

---

## Custom Plugins

All custom plugins are in `lua/plugins/`. LazyVim automatically loads these specs.

**Note:** Some plugins are present but disabled (via `if true then return {} end`):

- `avante.lua` - AI pair programming assistant (disabled)
- `opencode-nvim.lua` - OpenCode plugin integration (disabled)
- `opencode-terminal.lua` - Alternative OpenCode terminal implementation (disabled)

### UI/Dashboard

#### alpha.nvim (`lua/plugins/alpha.lua`)

Custom dashboard with personalized greeting, fortune quotes, and centered layout.

- ASCII header with NEOVIM branding
- Time-based greetings (morning/afternoon/evening/night)
- Custom button actions with shortcuts (find files, recent files, config, etc.)
- Centered scrolling disabled for consistent layout
- Footer shows plugin load time and count
- Fortune quotes integration with configurable width/format

#### barbar.nvim (`lua/plugins/barbar.lua`)

Replaces LazyVim's default bufferline with barbar for better buffer management.

- **Key features**: Pinnable buffers, git status indicators, diagnostic icons
- **Buffer navigation**: `Tab`/`Shift-Tab` to cycle, `Alt-1` through `Alt-9`
  for direct access
- **Buffer management**: `<leader>ba` closes all but current, `<leader>bp`
  closes unpinned, `<leader>bP` closes all but current and pinned
- **Sorting**: `<leader>bs[b|d|l|w]` sorts by buffer number, directory,
  language, or window number
- **Pinning**: `Alt-p` to pin/unpin a buffer
- **Reordering**: `Alt-<` and `Alt->` to move buffers left/right
- Sidebar integration with neo-tree
- Replaces: `bufferline.nvim` (disabled in config)

### Editor/Navigation

#### telescope.nvim (`lua/plugins/telescope.lua`)

Enhanced file finder with custom layout and additional pickers.

- Layout: horizontal with prompt at top, ascending sort
- `<leader>fP`: Browse plugin files (lazy.nvim root)
- `<leader>f/`: Fuzzy find in current buffer
- `<leader>fp`: Projects picker

#### neo-tree.nvim (`lua/plugins/neo-tree.lua`)

File explorer with custom copy command, focus restore, and auto-close behavior.

- Custom expanders: ``(collapsed), ``(expanded)
- `Y` key: Smart copy selector (filename, path, CWD path, HOME path, URI)
- Copy selector restores Neo-tree focus and cursor after picking option
- `P` key: Floating preview with image support (uses snacks)
- `e` key: Disabled (unmapped)
- `close_if_last_window = true`: Closes with last buffer
- Shows hidden files by default (except `.DS_Store`, `thumbs.db`)
- File watcher enabled for real-time updates
- Bound to CWD disabled for better flexibility

#### toggleterm.nvim (`lua/plugins/toggleterm.lua`)

Floating terminal integration.

- `Alt-z` (normal): Opens floating terminal
- `Alt-z` (terminal): Exits terminal mode and closes all terminals
- Default direction: float

#### yazi file manager (`lua/config/keymaps.lua`)

External file manager in floating terminal.

- `<leader>y`: Opens yazi file manager in toggleterm float
- Requires `yazi` installed on PATH

### Completion/LSP

#### blink.cmp (`lua/plugins/blink-cmp.lua`)

Completion engine with custom keybinds and Copilot integration.

- `Tab`/`Shift-Tab`: Cycle completions, snippet jump, fallback
- `Enter`: Accept completion
- `Ctrl-j`/`Ctrl-k`: Alternative cycling keys
- Arrow keys disabled for completion navigation
- Rounded borders on completion menu and docs
- Ghost text enabled on selection
- Preset disabled to avoid conflicts
- **Copilot provider**: Conditionally enabled via `vim.b.copilot_enabled`
  - Only provides completions when buffer-level toggle is enabled
  - See lualine section for toggle control
- **Signature help disabled**: Prevents duplicate popups with noice.nvim
  - LSP signature handled by noice instead

#### lsp-config.lua (`lua/plugins/lsp-config.lua`)

LSP configuration with custom diagnostics and keybinds.

- Virtual text disabled (using tiny-inline-diagnostic instead)
- Custom diagnostic icons (error/warn/info/hint)
- `gh`: LSP hover documentation (native `vim.lsp.buf.hover()` routed through noice)
- `<leader>ca`: Code action with preview (uses tiny-code-action)
- `<leader>cA`: Source action with preview
- Underline enabled for diagnostics
- Severity sort enabled

#### tiny-inline-diagnostic.lua (`lua/plugins/tiny-inline-diagnostic.lua`)

Inline diagnostic display that replaces LSP virtual text.

- Preset: modern style
- Transparent cursorline for better visibility
- Multiline diagnostics enabled with always-show
- Wrap mode for overflow handling
- Zero throttle for immediate updates
- High priority (2048) to override other plugins

#### tiny-code-action.lua (`lua/plugins/tiny-code-action.lua`)

Code action preview UI with custom picker integration.

- Backend: vim diff
- Picker: snacks (instead of default telescope)
- Custom icons for action kinds (quickfix, refactor, source, rename, etc.)
- Preview changes before applying

#### illuminate.lua (`lua/plugins/illuminate.lua`)

Highlights other occurrences of word under cursor.

- Disabled for specific filetypes: alpha, avante, aerial, lazy, neo-tree,
  toggleterm, help, Trouble

#### goto-preview.lua (`lua/plugins/goto-preview.lua`)

Inline LSP navigation with floating preview windows.

- Preview definitions, references, implementations without leaving context
- Rounded border style (90% width, 85% height)
- Stack height: 40% for multi-level navigation
- Integrates with lsp-config for all `g*` navigation keys

### AI/Code Generation

#### copilot.lua (`lua/plugins/copilot.lua`)

GitHub Copilot integration with telemetry disabled.

- Enabled via LazyVim extra: `lazyvim.plugins.extras.ai.copilot`
- Telemetry disabled: `telemetryLevel = "off"`
- Buffer-level toggle: `vim.b.copilot_enabled` controls per-buffer state
- Integration with blink.cmp (conditional provider)
- See lualine section for clickable status indicator

#### sidekick.nvim (`lua/plugins/sidekick.lua`)

OpenCode CLI integration with Copilot Next Edit Suggestions (NES).

- Layout: Float (90% width, 85% height, rounded border)
- `Alt-a` (normal): Toggle OpenCode terminal (focus on open)
- `Alt-a` (terminal): Return to editor
- `Alt-Tab` (insert/normal): Jump to/apply Next Edit Suggestion
- Telemetry disabled
- Terminal reuse: Opens existing or creates new focused terminal

### Code Execution

#### code-runner.lua (`lua/plugins/code-runner.lua`)

Code execution plugin with toggleterm integration.

- Plugin: `CRAG666/code_runner.nvim`
- Output mode: toggleterm (floating terminal)
- Focus on open, start in insert mode
- **Filetype configurations**: Inline opts (C, C++, Rust, Java, Go, Python, JavaScript, TypeScript, Ruby, Lua, Shell, Zig, Kotlin)
  - Compiled languages: Auto-detects compile + run workflow
  - Interpreted languages: Direct execution
- **Project configurations** (`lua/plugins/code_runner/projects.json`):
  - Per-directory custom run commands
- **Keybindings**:
  - `<leader>ra`: Run with args (prompts for compiler flags + runtime args)
  - `<leader>rr`: Run code
  - `<leader>rf`: Run file
  - `<leader>rp`: Run project
  - `<leader>rP`: Configure projects
  - `<leader>rm*`: Run mode (term/float/tab/toggleterm/buf)

### UI Enhancements

#### lualine.nvim (`lua/plugins/lualine.lua`)

Custom statusline with bubbles theme and selective interactive components.

- **Mode indicator**: Shows current mode (Normal/Insert/Visual/etc.)
- **Filename**: Current buffer filename
- **Branch**: Git branch with `` icon
- **Diagnostics**: Error/warn/info/hint counts (click to open Trouble workspace diagnostics)
- **LSP status**: Active LSP clients (click for LspInfo), hides copilot
- **Python interpreter**: Shows active pyenv environment name
- **Diff stats**: Git added/modified/removed (click to open git status picker)
- **Lazy updates**: Shows pending plugin updates
- **DAP status**: Shows debugger status when active
- **Snacks profiler**: Shows profiler status when enabled
- **Copilot status**: Interactive per-buffer toggle
  - Shows `(green) when enabled,` (gray) when disabled
  - Click to toggle Copilot for current buffer
  - Displays notification on toggle
  - Only visible when Copilot is installed
- Theme: custom bubbles with transparent backgrounds
- Disabled for: neo-tree, alpha
- Responsive: Hides components on narrow windows (<100 cols)

#### noice.nvim (`lua/plugins/noice.lua`)

Enhanced UI for messages, cmdline, popups, and LSP documentation.

- **Cmdline**: popup view positioned at 30% vertical, 50% horizontal
- **LSP integration**:
  - `lsp_doc_border = true`: Rounded borders for LSP documentation
  - Hover enabled with auto-open
  - Signature help enabled with auto-open
  - Routes native LSP hover and signature through noice UI
- **Routes**: Filters out img-clip "Content is not an image" warnings
  and Mason update notifications

#### edgy.nvim (`lua/plugins/edgy.lua`)

Window layout manager for sidebars/panels.

- `exit_when_last = true`: Closes sidebar when last window
- Custom window separator highlight for sidebar distinction

#### statuscol.nvim (`lua/plugins/statuscol.lua`)

Custom status column with DAP breakpoints, line numbers, and git signs.

- **DAP breakpoint column** (first column):
  - Shows debugger breakpoint signs (DapBreakpoint, DapBreakpointRejected, DapBreakpointCondition)
  - Click handlers: Click on any DAP sign to toggle breakpoint
- **Line numbers** (second column): Absolute numbering
- **Git signs** (third column): Gitsigns integration with click handlers
  - Left click: Preview hunk
  - Ctrl + Left click: Reset hunk
  - Right click: Stage hunk
  - Middle click: Reset hunk
- **UFO folding**: nvim-ufo for improved fold handling
  - Custom fold virtual text showing line count
  - Providers: treesitter, indent
  - `zR`: Open all folds
  - `zM`: Close all folds
  - Custom fold icons: foldopen , foldclose
- **Gitsigns**: Rounded border preview
- Disabled for alpha filetype

#### colorscheme.lua (`lua/plugins/colorscheme.lua`)

Colorscheme configuration with transparency.

- Primary: catppuccin (transparent background, solid floats disabled)
- Fallback: tokyonight (transparent sidebars and floats)
- Both configured with `transparent_background = true`

#### which-key.nvim (`lua/plugins/which-key.lua`)

Keybind helper with helix preset.

- Preset: helix

### Plugin Utilities

#### comment.nvim (`lua/plugins/comment.lua`)

Smart commenting with custom keybinds.

- `<leader>/`: Toggle line comment (normal/visual)
- `<leader>'`: Toggle block comment (normal/visual)
- Custom which-key icons and descriptions

#### yanky.nvim (`lua/plugins/yanky.lua`)

Enhanced yank/paste history.

- `-p`: Put after with filter (replaces `=p`)
- `-P`: Put before with filter (replaces `=P`)

#### searchbox.nvim (`lua/plugins/searchbox.lua`)

Enhanced search and replace UI.

- `<leader>s.`: Search and replace on current buffer
- Nui.nvim integration for popup UI

#### guess-indent.lua (`lua/plugins/guess-indent.lua`)

Auto-detects indentation settings per file.

- Automatically adjusts `shiftwidth` and `tabstop` based on file content
- Respects `.editorconfig` files when present (does not override)
- Excludes UI buffers: help, dashboard, neo-tree, Trouble, lazy, mason, notify, toggleterm
- Ideal for working across projects with different indent conventions

#### mini-animate.lua (`lua/plugins/mini-animate.lua`)

Smooth scrolling and cursor animations.

- Close animations disabled
- Scroll, resize, and open animations available (commented out)

#### codesnap.lua (`lua/plugins/codesnap.lua`)

Code screenshot generator with macOS window bar.

- `<leader>cpc`: Save code snapshot to clipboard (visual mode)
- `<leader>cps`: Save code snapshot to `~/Downloads` (visual mode)
- Features: macOS window bar, breadcrumbs, custom fonts
- Font: CaskaydiaCove Nerd Font
- Watermark font: Pacifico (disabled by default)
- Theme: default with custom padding

#### markdown-preview.nvim (`lua/plugins/markdown-preview.lua`)

Live Markdown preview in your web browser.

- Default theme: light
- `<leader>cp`: Open Markdown preview (Markdown buffers only)
- Command: `:MarkdownPreview`

#### mason.nvim (`lua/plugins/mason.lua`)

Mason configuration with extra commands and UI customization.

- Rounded border UI
- Dependency: Zeioth/mason-extra-cmds for additional commands
- Supports `MasonUpdateAll` command for batch updates

---

## Keymaps

All custom keymaps are in `lua/config/keymaps.lua`. LazyVim's default keymaps
are documented at [lazyvim.org/keymaps](https://www.lazyvim.org/keymaps).

### Unmapped LazyVim Defaults

The following LazyVim defaults have been unmapped:

| Key          | Original Action       | Reason                          |
| ------------ | --------------------- | ------------------------------- |
| `<leader>bb` | Buffer list           | Replaced with barbar navigation |
| `<leader>bo` | Delete other buffers  | Using barbar's `<leader>ba`     |
| `<leader>bd` | Delete buffer         | Using `Alt-c` for close         |
| `<leader>bD` | Delete buffer (force) | Using `Alt-C` for force close   |
| `<leader>fn` | New file              | Moved to `<leader>bn`           |
| `<leader>fp` | Find config files     | Reassigned to projects          |
| `<leader>K`  | Keywordprg            | Not needed                      |
| `<leader>\|` | Split window right    | Remapped to `<leader>\`         |
| `<Space>`    | Move right            | Prevent leader race conditions  |

### Kitty Terminal Integration

Kitty sends special sequences for Alt-based navigation. Keymaps handle these in
all modes.

**kitty.conf mappings:**

```conf
map alt+left      send_text all \x1b\x62    # ⌥ + ← (word left)
map alt+right     send_text all \x1b\x66    # ⌥ + → (word right)
map alt+backspace send_text all \x1b\x7f    # ⌥ + ⌫ (delete word)
map alt+up        send_text all \x1b[F      # ⌥ + ↑ (end of line)
map alt+down      send_text all \x1b[H      # ⌥ + ↓ (start of line)
```

**Neovim mappings:**

| Mode    | Key     | Action                                 |
| ------- | ------- | -------------------------------------- |
| Normal  | `⌥ + ←` | Jump to previous word                  |
| Normal  | `⌥ + →` | Jump to next word                      |
| Normal  | `⌥ + ↑` | Jump to end of line                    |
| Normal  | `⌥ + ↓` | Jump to start of line                  |
| Insert  | `⌥ + ←` | Jump to previous word (stay in insert) |
| Insert  | `⌥ + →` | Jump to next word (stay in insert)     |
| Insert  | `⌥ + ⌫` | Delete previous word                   |
| Insert  | `⌥ + ↑` | Jump to end of line                    |
| Insert  | `⌥ + ↓` | Jump to start of line                  |
| Visual  | `⌥ + ←` | Extend selection left by word          |
| Visual  | `⌥ + →` | Extend selection right by word         |
| Visual  | `⌥ + ↑` | Extend selection to end of line        |
| Visual  | `⌥ + ↓` | Extend selection to start of line      |
| Command | `⌥ + ←` | Jump to previous word                  |
| Command | `⌥ + →` | Jump to next word                      |
| Command | `⌥ + ⌫` | Delete previous word                   |

### Buffer Management

| Key                | Mode   | Action                           |
| ------------------ | ------ | -------------------------------- |
| `Alt-c`            | Normal | Close buffer (or Alpha if last)  |
| `Alt-C`            | Normal | Force close buffer               |
| `<leader>bn`       | Normal | New file                         |
| `<leader>bA`       | Normal | Add project                      |
| `Tab`              | Normal | Next buffer (barbar)             |
| `Shift-Tab`        | Normal | Previous buffer (barbar)         |
| `Alt-1` to `Alt-9` | Normal | Jump to buffer N                 |
| `Alt-0`            | Normal | Jump to last buffer              |
| `Alt-p`            | Normal | Pin/unpin buffer                 |
| `Alt-<`            | Normal | Move buffer to previous position |
| `Alt->`            | Normal | Move buffer to next position     |
| `<leader>ba`       | Normal | Close all but current            |
| `<leader>bp`       | Normal | Close unpinned buffers           |
| `<leader>bP`       | Normal | Close all but current and pinned |
| `<leader>bsb`      | Normal | Sort by buffer number            |
| `<leader>bsd`      | Normal | Sort by directory                |
| `<leader>bsl`      | Normal | Sort by language                 |
| `<leader>bsw`      | Normal | Sort by window number            |

### Editing

| Key         | Mode          | Action                               |
| ----------- | ------------- | ------------------------------------ |
| `<leader>W` | Normal        | Save without formatting              |
| `Ctrl-c`    | Normal        | Copy entire file to clipboard        |
| `Ctrl-c`    | Visual        | Copy selection to clipboard          |
| `Ctrl-x`    | Normal        | Delete entire file                   |
| `Ctrl-x`    | Visual        | Cut selection to clipboard           |
| `Tab`       | Visual        | Indent right (keep selection)        |
| `Shift-Tab` | Visual        | Indent left (keep selection)         |
| `+`         | Normal/Visual | Increment number (replaces `Ctrl-a`) |
| `=`         | Normal/Visual | Decrement number (replaces `Ctrl-x`) |

### Window Management

| Key          | Mode   | Action             |
| ------------ | ------ | ------------------ |
| `<leader>\`` | Normal | Split window right |

### External Tools

| Key         | Mode     | Action                       |
| ----------- | -------- | ---------------------------- |
| `<leader>y` | Normal   | Open Yazi file manager       |
| `Alt-z`     | Normal   | Toggle floating terminal     |
| `Alt-z`     | Terminal | Exit terminal mode and close |

### File Navigation

| Key          | Mode   | Action                       |
| ------------ | ------ | ---------------------------- |
| `<leader>fP` | Normal | Browse plugin files          |
| `<leader>f/` | Normal | Fuzzy find in current buffer |
| `<leader>fp` | Normal | Projects picker              |
| `<leader>fw` | Normal | Find words in all files (rg) |

### LSP/Code

| Key          | Mode          | Action                           |
| ------------ | ------------- | -------------------------------- |
| `gd`         | Normal        | Definition preview               |
| `gr`         | Normal        | References preview               |
| `gI`         | Normal        | Implementation preview           |
| `gy`         | Normal        | Type definition preview          |
| `gD`         | Normal        | Declaration preview              |
| `gP`         | Normal        | Close all preview windows        |
| `gh`         | Normal        | LSP hover (via noice)            |
| `gm`         | Normal        | Man page hover popup             |
| `<leader>ca` | Normal/Visual | Code action (tiny-code-action)   |
| `<leader>cA` | Normal        | Source action (tiny-code-action) |
| `<leader>ce` | Normal        | Go: Insert if err != nil         |

### Code Execution Mappings

| Key           | Mode   | Action                             |
| ------------- | ------ | ---------------------------------- |
| `<leader>ra`  | Normal | Run with args (compiler + runtime) |
| `<leader>rr`  | Normal | Run code                           |
| `<leader>rf`  | Normal | Run file                           |
| `<leader>rp`  | Normal | Run project                        |
| `<leader>rP`  | Normal | Configure projects                 |
| `<leader>rmt` | Normal | Run (term)                         |
| `<leader>rmf` | Normal | Run (float)                        |
| `<leader>rmT` | Normal | Run (tab)                          |
| `<leader>rmo` | Normal | Run (toggleterm)                   |
| `<leader>rmb` | Normal | Run (buffer)                       |

### Comments/Snapshots

| Key           | Mode   | Action                           |
| ------------- | ------ | -------------------------------- |
| `<leader>/`   | Normal | Toggle line comment              |
| `<leader>/`   | Visual | Toggle line comment (selection)  |
| `<leader>'`   | Normal | Toggle block comment             |
| `<leader>'`   | Visual | Toggle block comment (selection) |
| `<leader>cpc` | Visual | Save code snapshot to clipboard  |
| `<leader>cps` | Visual | Save code snapshot to Downloads  |

### Markdown

| Key          | Mode   | Action                |
| ------------ | ------ | --------------------- |
| `<leader>cp` | Normal | Open Markdown preview |

### Yanky

| Key  | Mode   | Action                 |
| ---- | ------ | ---------------------- |
| `-p` | Normal | Put after with filter  |
| `-P` | Normal | Put before with filter |

### Search

| Key          | Mode   | Action                               |
| ------------ | ------ | ------------------------------------ |
| `<leader>s.` | Normal | Search and replace on current buffer |

### AI/Sidekick

| Key       | Mode          | Action                          |
| --------- | ------------- | ------------------------------- |
| `Alt-a`   | Normal        | Toggle OpenCode (Sidekick)      |
| `Alt-a`   | Terminal      | Return to editor                |
| `Alt-Tab` | Insert/Normal | Goto/Apply Next Edit Suggestion |

### Quit/Session

| Key          | Mode   | Action                          |
| ------------ | ------ | ------------------------------- |
| `<leader>qq` | Normal | Quit window (with confirmation) |
| `<leader>qQ` | Normal | Quit all (with confirmation)    |
| `Ctrl-q`     | Normal | Quit all (with confirmation)    |

---

## Options

Custom options are in `lua/config/options.lua`. These override LazyVim defaults:

```lua
opt.relativenumber = false  -- Use absolute line numbers (LazyVim default: true)
opt.shiftwidth = 4          -- 4-space indents (LazyVim default: 2)
opt.tabstop = 4             -- Tab = 4 spaces (LazyVim default: 2)
opt.wrap = true             -- Enable line wrapping (LazyVim default: false)
opt.showbreak = "↪ "        -- Line wrap indicator

g.python3_host_prog = os.getenv("NVIM_PYTHON_PATH")
g.lazyvim_prettier_needs_config = true
```

---

## Autocmds

Custom autocmds are in `lua/config/autocmds.lua`.

### Global Color Overrides

Global highlight groups are applied after any colorscheme loads, ensuring
consistent colors across themes. These overrides affect:

- **nvim-dap-virtual-text**: Custom colors for debug virtual text (error, info,
  changed states)
- **barbar**: All buffer states with custom colors
  - Current buffer: Orange foreground (#ef9e76)
  - Current index: Pink (#ff5189)
  - Inactive buffers: Muted gray (#6c7087)
  - Alternate buffers: Orange (#ef9e76)
  - Visible buffers: Blue (#8caaee)
  - Git status: Green (added), Pink (deleted), Yellow (changed)
  - Diagnostics: Error (pink), Warn (yellow), Info (cyan), Hint (teal)
- **cursor**: CursorLine (#3a3c47) and Visual selection (#775d46)
- **window separators**:
  - WinSeparator: Transparent (#45475a for Edgy/Neo-tree sidebars)
  - EdgyWinSep: Gray separator for edgy.nvim sidebars
  - NeoTreeWinSeparator: Gray separator for neo-tree windows
- **neo-tree**: Tab separators, dotfile colors (#A8A8A8)
- **completion (blink.cmp)**: VS Code-inspired colors
  - Constructor/Class: Orange (#f28b25)
  - Method/Function: Purple (#C586C0)
  - Variables/Fields: Blue (#9CDCFE)
  - Match text: Bright blue (#18a2fe, bold)
  - Menu: Gray (#777d86)
- **aerial**: Symbol outline colors matching VS Code theme
- **spelling**: Undercurl with salmon color (#ffbba6)
- **LSP inlay hints**: Subtle gray (#8f939b)

The autocmd re-applies these highlights on every `:colorscheme` change, making
them theme-agnostic.

**Implementation**: Uses `ColorScheme` autocmd with `vim.schedule()` to run
after theme's own callbacks. A helper function normalizes empty strings to
"NONE" for proper transparency.

### Disable Spell Check in Markdown

Spell checking is disabled for Markdown files to prevent highlighting of
technical terms, code snippets, and special syntax.

- **Event**: `FileType` for `markdown` pattern
- **Action**: Sets `spell = false` locally for the buffer

### Auto-Update Mason After Lazy Sync

Automatically runs Mason updates after Lazy plugin sync completes.

- **Event**: `User` pattern `LazySync`
- **Action**: Schedules `MasonUpdate` and `MasonUpdateAll` commands
- Ensures language tools stay up-to-date with plugin updates

---

## Custom Utilities

### close_or_alpha.lua (`lua/util/close_or_alpha.lua`)

Smart buffer closing utility that shows the Alpha dashboard when closing the
last buffer.

**Features**:

- Detects if closing the last real buffer (excludes alpha and special buffers)
- Prompts to save if buffer is modified (unless force mode)
- Shows Alpha dashboard instead of empty buffer
- Supports force-close mode to skip prompts
- Used by: `Alt-c` and `Alt-C` keybinds
- Handles unsaved buffers with 3-way confirmation (Yes/No/Cancel)

**Usage**:

```lua
require("util.close_or_alpha").run(false)  -- Normal close
require("util.close_or_alpha").run(true)   -- Force close
```

### go_iferr.lua (`lua/util/go_iferr.lua`)

Smart Go error handling insertion utility inspired by go.nvim's iferr feature.

**Features**:

- Automatically installs `iferr` binary via `go install` if missing
- Analyzes function signatures to generate appropriate zero-value returns
- Intelligently detects return types (string→`""`, int→`0`, pointer→`nil`, etc.)
- Inserts `if err != nil` block at cursor position with proper formatting
- Auto-indents inserted code for clean formatting
- Configurable vertical shift after insertion (default: 2 lines)

**Usage**:

- Keymap: `<leader>ce` (Go buffers only)
- Place cursor after a function call that returns an error
- Press `<leader>ce` to insert error handling block

**Example**:

```go
// Before (cursor after this line):
file, err := os.Open("file.txt")

// After pressing <leader>ce:
file, err := os.Open("file.txt")
if err != nil {
    return nil, err
}
```

### man_hover.lua (`lua/util/man_hover.lua`)

LSP-style man page viewer that shows Unix manual pages in a smart floating popup.

**Features**:

- **Smart positioning**: Uses `vim.lsp.util.open_floating_preview()` for cursor-relative placement
- **Automatic edge handling**: Positions below cursor (or above if more space), handles screen edges
- **Scrollable content**: Max height of 25 lines with smooth scrolling for longer pages
- **Interactive**: Click inside popup to select/copy text without closing
- **Focus toggle**: Press `gm` twice to jump into the popup for navigation
- **Smart close**: Press `q` to close and return cursor to original position
- **Auto-close**: Closes automatically when cursor moves in source buffer

**Usage**:

- Keymap: `gm` (global, all modes)
- Place cursor on a word/command/function
- Press `gm` to view its man page
- Press `gm` again to jump into popup for scrolling/selection
- Press `q` to close and return to code

**Supported Languages/Tools**:

- **C/C++**: Standard library functions, system calls (`printf`, `malloc`, `pthread_*`)
- **Shell**: Bash, Zsh, Fish commands and builtins
- **POSIX APIs**: Networking, file I/O, process management
- **CLI tools**: Any tool with man pages (git, make, grep, sed, awk, curl, etc.)
- **System programming**: Perfect for low-level development

**Example**:

```c
// Hover over 'printf' and press 'gm'
printf("Hello, world!\n");
// → Shows man 3 printf in floating popup

// Click inside popup to select/copy text
// Press 'q' to close and return to code
```

**Note**: For modern languages (JavaScript, Rust, Go, Java), use LSP hover (`gh`) instead, as they don't use Unix man pages.

---

## License

MIT — see [`LICENSE`](./LICENSE).

---

## Credits

Built on the shoulders of **LazyVim** and the excellent Neovim plugin ecosystem.
