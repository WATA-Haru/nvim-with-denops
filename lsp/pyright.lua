local home_dir = os.getenv("HOME")
local pyright_path = home_dir .. "/.local/share/mise/installs/npm-pyright/latest/lib/node_modules/pyright/langserver.index.js"

vim.lsp.config('pyright', {
  cmd = { 'node', pyright_path, '--stdio' },
  filetypes = { 'python' },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true
      }
    }
  }
})

