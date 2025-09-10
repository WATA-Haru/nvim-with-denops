-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#copilot
local home_dir = os.getenv("HOME")
local copilot_path = home_dir .. "/.local/share/mise/installs/npm-github-copilot-language-server/latest/bin/copilot-language-server"

vim.lsp.config('copilot', {
  cmd = { 'node', copilot_path, '--stdio'},
  root_markers = { ".git" },
  settings = {
    telemetry = {
      telemetryLevel = "all"
    }
  }
})

