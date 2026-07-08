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

---

## Usage guide

> Leader is `Space`. Lost? Press `Space` and wait — which-key shows what's
> possible. `<leader>?` lists the current buffer's keymaps, `<leader>sk`
> fuzzy-searches all of them.

### I want to open / find something

| Situation | Keys |
|---|---|
| Open a file by name | `<leader>sf` |
| Find text anywhere in the project | `<leader>sg` |
| Find the word under my cursor | `<leader>sw` |
| Switch between open buffers | `<leader><leader>` |
| Reopen my last search | `<leader>sr` |
| Browse the file tree | `<leader>t` (inside: `a` add, `r` rename, `d` delete, `?` help) |
| Search Neovim's help | `<leader>sh` |

### I want to move around

| Situation | Keys |
|---|---|
| Jump to any visible text | `s` + 2 chars, then the label |
| Select a code block structurally | `S`, then pick the label (expression → function → module) |
| Next / previous function | `]f` / `[f` |
| Move between splits (incl. terminal) | `<C-h/j/k/l>` |
| Half-page scroll, cursor centered | `<C-d>` / `<C-u>` |
| Clear search highlight | `<Esc>` |

### I'm reading / navigating code (LSP)

| Situation | Keys |
|---|---|
| Where is this defined? | `gd` |
| Who uses this? | `gr` |
| Who implements this? | `gI` |
| What is this? (docs popup) | `K` |
| What's this error? | `<leader>e` (next/prev: `]d` / `[d`) |
| Collapse everything to see the file's skeleton | `zM` (reopen all: `zR`, toggle one: `za`) |
| Where am I? | sticky context header at the top of the window |

### I want to change code

| Situation | Keys |
|---|---|
| Rename a symbol everywhere | `<leader>rn` |
| Apply a suggested fix | `<leader>ca` |
| Delete / change / copy a whole function | `daf` / `caf` / `yaf` (body only: `dif`…) |
| Same for an argument | `daa`, `cia`, … |
| Surround word with quotes | `saiw"` |
| Delete / change surrounding quotes | `sd"` / `sr"'` |
| Move selected lines up/down | select, then `K` / `J` |
| Re-indent selection (and keep it) | `<` / `>` |
| Paste over selection without losing the register | `p` |
| Format the buffer now | `<leader>f` (also runs automatically on save) |

### Something went wrong

| Situation | Keys |
|---|---|
| Undo / redo | `u` / `<C-r>` |
| Browse full undo history (branches, old sessions) | `<leader>u` |
| A file changed on disk | nothing — buffer auto-reloads, you get a notification |
| Unsaved changes? | buffers auto-save when you leave them or Neovim loses focus |

### Git

| Situation | Keys |
|---|---|
| What did I change here? | look at the sign column (`+` `~` `-`) |
| Jump between my changes | `]h` / `[h` |
| Preview a change's diff | `<leader>hp` |
| Stage / undo just this change | `<leader>hs` / `<leader>hr` |
| Who wrote this line? | `<leader>hb` |

### AI (Claude Code / Codex)

| Situation | Keys |
|---|---|
| Talk to Claude (send selection in visual mode) | `<leader>ac` |
| Talk to Codex | `<leader>ax` |
| Use a canned prompt (explain, fix, tests…) | `<leader>ap` |
| Toggle AI on/off for this session | `<leader>aT` |
| Ban AI from a project permanently | `touch .noai` at the project root |

### Completion menu (insert mode)

| Situation | Keys |
|---|---|
| Navigate suggestions | `<C-n>` / `<C-p>` |
| Accept | `<C-y>` |
| Show docs for the selected item | `<C-Space>` |

### Maintenance

| Situation | Command |
|---|---|
| Plugin status / updates | `:Lazy` (update: `U`, restore lockfile: `R`) |
| LSP servers / formatters install | `:Mason` |
| Which LSP is attached here? | `:LspInfo` |
| Which formatter applies here? | `:ConformInfo` |
| Something feels broken | `:checkhealth` |

---

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
