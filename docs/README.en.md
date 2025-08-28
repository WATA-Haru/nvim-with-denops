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
├── lua/
│   ├── config/                # Core Neovim configurations
│   │   ├── clipboard.lua      # Clipboard settings (WSL win32yank)
│   │   ├── keys.lua           # Key mappings
│   │   ├── lsp.lua            # LSP global settings
│   │   ├── opts.lua           # Neovim options
│   │   └── plugins.lua        # Plugin loading orchestration
│   │   └── colorscheme.lua    # coloscheme setting and toggle color
│   └── plugins/               # Plugin configurations
└── vimscript_for_plugins/     # VimScript configurations
```

### Directory Descriptions

- **`lsp/`**: Individual LSP server configurations using `vim.lsp.config()`
- **`lua/config/`**: Core Neovim settings split by concern
- **`lua/plugins/`**: Plugin installation and setup using `vim.pack.add()`
- **`vimscript_for_plugins/`**: VimScript configs for plugins that require it

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
