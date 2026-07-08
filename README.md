# mvim

My personal Neovim configuration, built from scratch — every line understood, no distro.

Runs side-by-side with any other Neovim config thanks to `NVIM_APPNAME`.

## Highlights

- **Plugin manager**: [lazy.nvim](https://github.com/folke/lazy.nvim) with lockfile-pinned versions
- **Syntax & structure**: nvim-treesitter (`main` rewrite) + textobjects + context, structural folding
- **LSP**: native `vim.lsp.config` (nvim 0.11+) with Mason — `lua_ls`, `rust_analyzer`, `basedpyright`
- **Completion**: blink.cmp + friendly-snippets + lazydev
- **Fuzzy finding**: telescope + fzf-native
- **Files**: neo-tree (netrw hijack)
- **Git**: gitsigns (hunk navigation, staging, blame)
- **Editing**: mini.surround, mini.pairs, flash.nvim, undotree
- **Formatting**: conform.nvim (format-on-save: stylua, rustfmt, ruff)
- **AI**: sidekick.nvim (Claude Code / Codex CLIs) with a **per-project kill-switch**
  (`.noai` marker file or blocked paths — school projects stay AI-free)
- **UI**: kanagawa-dragon, lualine, which-key, indent guides

## Requirements

- Neovim ≥ 0.11
- `git`, `ripgrep`, `fd`, a C compiler (treesitter), `node` (some LSP servers)
- A [Nerd Font](https://www.nerdfonts.com/) configured in your terminal
- Optional: `claude` / `codex` CLIs for the AI integration

## Install

```sh
git clone https://github.com/Fallrod2/mvim ~/.config/mvim
```

Add an alias to your shell config (`~/.zshrc`):

```sh
alias mvim='NVIM_APPNAME=mvim nvim'
```

First launch (`mvim`) bootstraps lazy.nvim, installs all plugins pinned by
`lazy-lock.json`, then Mason installs the LSP servers. Grab a coffee.

## Structure

```
init.lua                  -- entry point: leaders + requires
lua/config/
  options.lua             -- vim options
  keymaps.lua             -- global keymaps
  autocmds.lua            -- autoread, autosave, yank highlight
  ai.lua                  -- AI policy module (allowed/guard/toggle)
  lazy.lua                -- plugin manager bootstrap
lua/plugins/              -- one spec file per plugin
```

## AI kill-switch

Drop a `.noai` file at a project root (or list paths in `lua/config/ai.lua`)
and all AI tooling is disabled there — the plugin doesn't even load, and the
toggle refuses to re-enable it. `<leader>aT` toggles AI elsewhere.
