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
      - [hovercraft.lua (`lua/plugins/hovercraft.lua`)](#hovercraftlua-luapluginshovercraftlua)
    - [AI/Code Generation](#aicode-generation)
      - [avante.nvim (`lua/plugins/avante.lua`)](#avantenvim-luapluginsavantelua)
      - [copilot-chat.nvim (`lua/plugins/copilot-chat.lua`)](#copilot-chatnvim-luapluginscopilot-chatlua)
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
      - [markdown-preview.nvim (`lua/plugins/markdown-preview.lua`)](#markdown-previewnvim-luapluginsmarkdown-previewlua)
      - [opencode-nvim.lua (`lua/plugins/opencode-nvim.lua`)](#opencode-nvimlua-luapluginsopencode-nvimlua)
      - [opencode-terminal.lua (`lua/plugins/opencode-terminal.lua`)](#opencode-terminallua-luapluginsopencode-terminallua)
  - [Keymaps](#keymaps)
    - [Unmapped LazyVim Defaults](#unmapped-lazyvim-defaults)
    - [Kitty Terminal Integration](#kitty-terminal-integration)
    - [Buffer Management](#buffer-management)
    - [Editing](#editing)
    - [External Tools](#external-tools)
    - [File Navigation](#file-navigation)
    - [LSP/Code](#lspcode)
    - [Comments/Snapshots](#commentssnapshots)
    - [Markdown](#markdown)
    - [Yanky](#yanky)
    - [Search](#search)
    - [AI/Copilot](#aicopilot)
    - [OpenCode](#opencode)
    - [Quit/Session](#quitsession)
  - [Options](#options)
  - [Autocmds](#autocmds)
    - [Global Color Overrides](#global-color-overrides)
    - [Disable Spell Check in Markdown](#disable-spell-check-in-markdown)
    - [Auto-Update Mason After Lazy Sync](#auto-update-mason-after-lazy-sync)
  - [Custom Utilities](#custom-utilities)
    - [close_or_alpha.lua (`lua/util/close_or_alpha.lua`)](#close_or_alphalua-luautilclose_or_alphalua)
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

| Category      | Location                  |
| ------------- | ------------------------- |
| **Options**   | `lua/config/options.lua`  |
| **Keymaps**   | `lua/config/keymaps.lua`  |
| **Autocmds**  | `lua/config/autocmds.lua` |
| **Plugins**   | `lua/plugins/*.lua`       |
| **Utilities** | `lua/util/*.lua`          |

---

## Custom Plugins

All custom plugins are in `lua/plugins/`. LazyVim automatically loads these specs.

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

File explorer with custom copy command and auto-close behavior.

- `Y` key: Smart copy selector (filename, path, CWD path, HOME path, URI)
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

Completion engine with custom keybinds and behavior.

- `Tab`/`Shift-Tab`: Cycle completions without auto-inserting
- `Enter`: Accept completion
- `Ctrl-j`/`Ctrl-k`: Alternative cycling keys
- Arrow keys disabled for completion navigation
- Rounded borders on completion menu and docs
- Ghost text enabled on selection
- Preset disabled to avoid conflicts

#### lsp-config.lua (`lua/plugins/lsp-config.lua`)

LSP configuration with custom diagnostics and keybinds.

- Virtual text disabled (using tiny-inline-diagnostic instead)
- Custom diagnostic icons (error/warn/info/hint)
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

#### hovercraft.lua (`lua/plugins/hovercraft.lua`)

Enhanced hover documentation with enter-to-focus capability.

- `gh`: Show hover info or enter popup if already visible
- Rounded border style
- Loaded on LspAttach event

### AI/Code Generation

#### avante.nvim (`lua/plugins/avante.lua`)

> [**DISABLED**]

AI-powered code assistant using Claude or Moonshot.

- Primary provider: Claude (sonnet-4-20250514)
- Alternative provider: Moonshot (kimi-k2-0711-preview)
- `<leader>aa`: Ask Avante (normal/visual)
- Selector: snacks picker
- Input: snacks input provider
- Supports image pasting with img-clip.nvim
- Custom instructions file: `avante.md`
- Temperature: 0.75, Max tokens: 20480 (Claude) / 32768 (Moonshot)

#### copilot-chat.nvim (`lua/plugins/copilot-chat.lua`)

GitHub Copilot chat interface with custom keybinds.

- `<leader>aca`: Toggle CopilotChat
- `<leader>acx`: Clear chat history
- `<leader>acq`: Quick chat prompt
- `<leader>acp`: Prompt actions
- Unmaps default `<leader>a[a|x|q|p]` to avoid conflicts with Avante

### UI Enhancements

#### lualine.nvim (`lua/plugins/lualine.lua`)

Custom statusline with bubbles theme and interactive click handlers.

- **Mode indicator**: Click to open man pages
- **Filename**: Click to open buffer picker
- **Branch**: Click to open git branches
- **Diagnostics**: Click to open Trouble workspace diagnostics
- **LSP status**: Shows active LSP clients (click for LspInfo), hides copilot
- **Python interpreter**: Shows active pyenv environment name
- **Diff stats**: Click to open git status picker (Snacks or Telescope)
- **Lazy updates**: Shows pending plugin updates
- **DAP status**: Shows debugger status when active
- **Snacks profiler**: Shows profiler status when enabled
- Theme: custom bubbles with transparent backgrounds
- Disabled for: neo-tree, alpha, Avante buffers
- Responsive: Hides components on narrow windows (<100 cols)

#### noice.nvim (`lua/plugins/noice.lua`)

Enhanced UI for messages, cmdline, and popups.

- Cmdline: popup view positioned at 30% vertical, 50% horizontal
- Routes: Filters out img-clip "Content is not an image" warnings
  and Mason update notifications

#### edgy.nvim (`lua/plugins/edgy.lua`)

Window layout manager for sidebars/panels.

- `exit_when_last = true`: Closes sidebar when last window

#### statuscol.nvim (`lua/plugins/statuscol.lua`)

Custom status column with folding, line numbers, and git signs.

- **Fold column**: UFO integration with custom icons
- **Line numbers**: Absolute numbering
- **Git signs**: Gitsigns integration with click handlers
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
- Custom groups: `<leader>a` (AI), `<leader>o` (OpenCode)

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

- `<leader>cp`: Open Markdown preview (Markdown buffers only)
- Command: `:MarkdownPreview`

#### opencode-nvim.lua (`lua/plugins/opencode-nvim.lua`)

SST OpenCode integration for AI-powered development.

- Preferred picker: snacks
- Preferred completion: blink
- Default global keymaps disabled (custom keymaps defined in keymaps section)
- Render-markdown integration for opencode_output filetype

#### opencode-terminal.lua (`lua/plugins/opencode-terminal.lua`)

> [**DISABLED**]

Alternative OpenCode integration.

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

### LSP/Code

| Key          | Mode          | Action                           |
| ------------ | ------------- | -------------------------------- |
| `gh`         | Normal        | Show hover or enter hover popup  |
| `<leader>ca` | Normal/Visual | Code action (tiny-code-action)   |
| `<leader>cA` | Normal        | Source action (tiny-code-action) |

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

### AI/Copilot

| Key           | Mode          | Action             |
| ------------- | ------------- | ------------------ |
| `<leader>aa`  | Normal/Visual | Ask Avante         |
| `<leader>aca` | Normal/Visual | Toggle CopilotChat |
| `<leader>acx` | Normal/Visual | Clear CopilotChat  |
| `<leader>acq` | Normal/Visual | Quick chat         |
| `<leader>acp` | Normal/Visual | Prompt actions     |

### OpenCode

All OpenCode keybinds are under `<leader>o` prefix.

| Key           | Mode   | Action                     |
| ------------- | ------ | -------------------------- |
| `<leader>og`  | Normal | Toggle OpenCode            |
| `<leader>oi`  | Normal | Open input                 |
| `<leader>oI`  | Normal | Open input (new session)   |
| `<leader>oo`  | Normal | Open output                |
| `<leader>ot`  | Normal | Toggle focus               |
| `<leader>oq`  | Normal | Close                      |
| `<leader>ox`  | Normal | Swap position              |
| `<leader>oss` | Normal | Select session             |
| `<leader>osS` | Normal | Select child session       |
| `<leader>omb` | Normal | Build mode                 |
| `<leader>omp` | Normal | Plan mode                  |
| `<leader>oms` | Normal | Select agent               |
| `<leader>op`  | Normal | Configure provider         |
| `<leader>odo` | Normal | Open diff                  |
| `<leader>odn` | Normal | Next file                  |
| `<leader>odp` | Normal | Previous file              |
| `<leader>odc` | Normal | Close diff                 |
| `<leader>ora` | Normal | Revert all (last prompt)   |
| `<leader>ort` | Normal | Revert this file (last)    |
| `<leader>orA` | Normal | Revert all (session)       |
| `<leader>orT` | Normal | Revert this file (session) |
| `<leader>oui` | Normal | Initialize AGENTS.md       |
| `<leader>oum` | Normal | List MCP servers           |
| `<leader>ouc` | Normal | Run user command           |
| `<leader>ous` | Normal | Stop execution             |

### Quit/Session

| Key          | Mode   | Action                          |
| ------------ | ------ | ------------------------------- |
| `<leader>qq` | Normal | Quit window (with confirmation) |
| `<leader>qQ` | Normal | Quit all (with confirmation)    |

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

---

## License

MIT — see [`LICENSE`](./LICENSE).

---

## Credits

Built on the shoulders of **LazyVim** and the excellent Neovim plugin ecosystem.
