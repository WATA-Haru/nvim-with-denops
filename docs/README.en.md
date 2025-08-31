# Neovim Configuration with vim.pack

Modern Neovim configuration using Neovim's native package manager (`vim.pack`) with Denops integration.

## Requirements

- **Neovim**: >= 0.12.0 (prerelease)
- **Package Manager**: vim.pack (>= **Neovim 0.12.0 prerelease**)
- **Runtime**: Deno (for Denops plugins)

## Directory Structure

```
nvim-with-denops/
├── init.lua                    # Main configuration entry point
├── lsp/                        # LSP server configurations
└── lua/
    ├── config/                # Core Neovim configurations
    │   ├── clipboard.lua      # Clipboard settings (WSL win32yank)
    │   ├── colorscheme.lua    # Colorscheme settings and ToggleCol command
    │   ├── keys.lua           # Key mappings
    │   ├── lsp.lua            # LSP global settings
    │   ├── opts.lua           # Neovim options
    │   └── plugins.lua        # Plugin loading orchestration
    └── plugins/               # Plugin configurations
```

### Directory Descriptions

- **`lsp/`**: Individual LSP server configurations using `vim.lsp.config()`
- **`lua/config/`**: Core Neovim settings split by concern
- **`lua/plugins/`**: Plugin installation and setup using `vim.pack.add()`

### lua/config/ Files

- **`clipboard.lua`**: WSL clipboard integration with win32yank
- **`colorscheme.lua`**: Colorscheme settings and ToggleCol command
- **`keys.lua`**: Key mappings and shortcuts
- **`lsp.lua`**: Global LSP settings and diagnostics
- **`opts.lua`**: Neovim options (UI, behavior, etc.)
- **`plugins.lua`**: Plugin loading coordination

## Package Management

This configuration uses Neovim's native `vim.pack.add()` system:

- **Installation**: Automatic on first launch
- **Updates**: Manual via restart Neovim or using `vim.pack.update()` function
- **Dependencies**: Handled via load order in plugin files

**References**:
- Documentation: https://neovim.io/doc/user/pack.html#vim.pack.update()
- Video: https://youtu.be/UE6XQTAxwE0?si=aVc1tpYEP0Wmy2NX

## Appendix: Package Addition Steps

Steps to add a new plugin:

1. **Create plugin configuration file**
   ```
   lua/plugins/<plugin-name>.lua
   ```

2. **Add to plugin loader**
   Add require() call in `lua/config/plugins.lua`:
   ```lua
   require('plugins.<plugin-name>')
   ```

3. **Restart Neovim**
   Reload configuration to automatically install and load the package

**Note**: If the plugin has dependencies, load dependency plugins first using `vim.pack.add()` in `lua/plugins/<plugin-name>.lua`.

### LSP Servers (mise-managed + nvim-lspconfig)
LSP servers are managed via **mise** (not mason). Ensure the following tools are installed and paths are configured:

mise.toml example in`docs/sample.mise.toml`
Verify paths in `lsp/` directory files match your mise installation paths.

### WSL: Win32yank (WSL Clipboard)
For WSL users, install win32yank for clipboard integration:

```bash
# Install win32yank to ~/.local/bin/
curl -L https://github.com/equalsraf/win32yank/releases/latest/download/win32yank-x64.zip -o /tmp/win32yank.zip
unzip /tmp/win32yank.zip -d ~/.local/bin/
chmod +x ~/.local/bin/win32yank.exe
```

Configuration is in `lua/config/clipboard.lua`.

## WSL: Opening URLs with Windows Browser

Configuration for opening URLs with Windows-side browsers (Brave, Chrome, etc.) from WSL:

### Setup

1. **Add `.env*` to `.gitignore`** (exclude personal settings from Git management)

2. **Create `.env.win_browser` file**
   ```bash
   # Create in nvim config directory
   touch ~/.config/nvim-with-denops/.env.win_browser
   ```

3. **Set browser path**
   ```bash
   BROWSER_PATH_ON_WINDOWS=/mnt/c/<your-browser-path.exe>
   ```

### Usage

- **`gx` key**: Open HTTP/HTTPS URL under cursor with Windows browser
- **`:Open https://example.com`**: Open specified URL with Windows browser

Configuration is in `lua/config/open_url_from_win_browser_from_wsl.lua`.
