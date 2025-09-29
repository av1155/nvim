# 💤 LazyVim — Personal Neovim Starter

An opinionated Neovim setup built on top of [LazyVim](https://github.com/LazyVim/LazyVim).  
It focuses on great UX out of the box: a slick dashboard, discoverable keymaps, modern
UI, sane LSP/completion defaults, and practical quality-of-life plugins.

---

## ✨ Highlights

- 🖥 **Dashboard (alpha.nvim)** with greeting, buttons, and fortune quotes
- 🧭 **which-key** (Helix preset) with group labels and per-mapping icons
- 🎨 **Catppuccin** (transparent) + tuned global highlights for many plugins
- 🗂 **barbar.nvim** bufferline + rich buffer keymaps
- 🤖 **blink.cmp** with clean keymap flow and non-intrusive selection
- 📂 **neo-tree** with helpful mappings (copy path, open with system, preview)
- 🧪 **LSP** tweaks (crisp diagnostics icons; non-obtrusive virtual text)
- 🧰 Quality-of-life: **toggleterm**, **searchbox**, **noice** cmdline popup,
  **hovercraft** (LSP hover), **codesnap** screenshots, **lualine** bubbles theme
- 🧠 Optional AI tooling via **avante.nvim** (providers scaffolded)

---

## 📦 Requirements

- Neovim **0.9+** (recommended: latest stable)
- Git, a **Nerd Font** (for icons), and common CLI tools:
  - `ripgrep` (for file/text pickers), `make` (some plugin builds)
- Optional:
  - API keys for AI providers you enable in `lua/plugins/avante.lua`
  - Python for plugins that need it: set `NVIM_PYTHON_PATH` (see below)

---

## 🚀 Quick Start

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

> Windows path: `%LOCALAPPDATA%\nvim`

**Post-install tips**

- Run `:checkhealth` to verify dependencies.
- `:Lazy` to manage plugins; `:Mason` to install language tools if needed.
- If using Python plugins, export:

    ```bash
    export NVIM_PYTHON_PATH="$(pyenv which python || which python3)"
    ```

---

## 🗺 Project Layout

```
.
├── init.lua                     # boots lazy.nvim and this config
├── lazyvim.json                 # LazyVim extras (UI/tools/langs)
├── lua/config/                  # core config: options, keymaps, autocmds
├── lua/plugins/                 # plugin specs (Lazy spec files)
├── ansi/gopher.sh               # fun ANSI art demo
├── stylua.toml                  # formatter config
└── README.md
```

---

## ⌨️ Keymaps (at a glance)

> which-key groups are defined in `lua/config/keymaps.lua` (Helix preset).
> Press keys slowly to discover mappings.

**General**

- `<leader>z` → **Open Dashboard (Alpha)**
- `<C-s>` → Save buffer
- `<leader>W` → Save without formatting
- `<leader>f/` → Fuzzy find in current buffer (Telescope)
- `<leader>s.` → Search & Replace (current buffer, Searchbox)

**Buffers (barbar)**

- `<Tab>` / `<S-Tab>` → Next / Previous buffer
- `Alt+1..0` → Go to buffer 1..10
- `Alt+p` → Pin / unpin
- `Alt+c` → Close
- Sort groups: `<leader>bs[b|d|l|w]` (number/dir/lang/window)
- New file: `<leader>bn`

**Terminal**

- `Alt+z` (normal) → Toggle floating terminal
- `Alt+z` (terminal) → Exit terminal mode & close all toggleterms

**neo-tree**

- `l` open · `h` close · `Y` copy path · `O` open with system · `P` preview

**Clipboard / Numbers**

- `<C-c>` copy file/selection · `<C-x>` cut file/selection
- `+`/`=` increment/decrement number (also visual variants keep selection)

---

## 🧩 Notable Plugins & Tweaks

- **alpha.nvim** (`lua/plugins/alpha.lua`)  
  Custom header/greeting/buttons, themed highlights, centered layout, and a
  quotes section powered by `fortune.nvim`.

- **which-key.nvim** (`lua/plugins/which-key.lua` + `keymaps.lua`)  
  Helix preset. Groups for buffers, AI, codesnap; icon example for `<leader>z`.

- **catppuccin / tokyonight** (`lua/plugins/colorscheme.lua`)  
  Transparent floats; global highlight overrides in `autocmds.lua` tailor many
  groups (barbar, Aerial, cmp kinds, dap virtual text, etc.).

- **barbar.nvim** (`lua/plugins/barbar.lua`)  
  Filetype/devicons, diagnostics, pin indicators, refined sorting & icons.

- **blink.cmp** (`lua/plugins/blink-cmp.lua`)  
  No preset collisions; `<Tab>/<S-Tab>` cycle first, snippets next; enter to accept.
  Rounded borders and tidy docs window.

- **neo-tree** (`lua/plugins/neo-tree.lua`)  
  Follow current file, libuv watcher, tasteful filters, quality mappings.

- **lualine** (`lua/plugins/lualine.lua`)  
  “Bubbles” theme, clickable segments (open Telescope/LSP/diagnostics pickers),
  DAP & Lazy status, Python env indicator via `NVIM_PYTHON_PATH`.

- **toggleterm** (float), **searchbox**, **noice** (cmdline popup), **hovercraft** (hover),  
  **mini.animate** (subtle), **codesnap** (pretty screenshots).

- **avante.nvim** (`lua/plugins/avante.lua`)  
  Provider scaffold for Claude/Moonshot (endpoints/models set).  
  Bring your own API keys and adjust `opts.providers` as needed.

- **LSP** (`lua/plugins/lsp-config.lua`)  
  Diagnostic styling (virtual text prefix, underline, sorted severities).

---

## ⚙️ Options & Autocmds

- `lua/config/options.lua`
  - spaces: 4 · wrap with `showbreak` (`↪`)
  - `relativenumber = false`
  - Python host from `NVIM_PYTHON_PATH`

- `lua/config/autocmds.lua`
  - Re-applies global highlight overrides on any colorscheme change.

---

## 🧪 Tips & Troubleshooting

- Icons missing? Install a Nerd Font and ensure your terminal uses it.
- Live grep not working? Install `ripgrep` and ensure it’s on your PATH.
- Windows builds (e.g., avante/codesnap) may require a compiler toolchain;
  plugins attempt platform-aware build commands (PowerShell/Make).
- Use `:Lazy health`, `:checkhealth`, and `:messages` to diagnose.

---

## 📝 License

MIT — see [`LICENSE`](./LICENSE).

---

## 🙏 Credits

Built on the shoulders of **LazyVim** and the excellent Neovim plugin ecosystem.
