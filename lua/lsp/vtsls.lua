-- https://github.com/vuejs/language-tools/wiki/Neovim
local home_dir = os.getenv("HOME")

-- vtsls path
local vtsls_path = home_dir .. "/.local/share/mise/installs/npm-vtsls-language-server/latest/lib/node_modules/@vtsls/language-server/bin/vtsls.js"


-- vtsls for vue
local vue_language_server_path = home_dir .. "/.local/share/mise/installs/npm-vue-language-server/latest/lib/node_modules/@vue/language-server"

local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}

local vtsls_config = {
  -- root_markersはデフォルトだと .git も含まれており、Denoプロジェクトでも有効になってしまうのを避けるため設定し直している
  -- https://minerva.mamansoft.net/Notes/%F0%9F%93%9C2025-07-07+Neovim+nvim-lspconfig%E3%81%A7Vue+Language+Tools+%E3%82%92+v2+%E3%81%8B%E3%82%89+v3+%E3%81%AB%E3%82%A2%E3%83%83%E3%83%97%E3%83%87%E3%83%BC%E3%83%88%E3%81%99%E3%82%8B
  -- workspace_required = true, -- root_markersがある場合のみlsp起動
  -- root_markers = { "package.json", "tsconfig.json", "jsconfig.json" },
  cmd = { "node", vtsls_path, "--stdio" },
  -- cmd = { "node", vtsls_path },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = tsserver_filetypes,
}

local ts_ls_config = {
  init_options = {
    plugins = {
      vue_plugin,
    },
  },
  filetypes = tsserver_filetypes,
}

-- Simple vue_ls config for testing
local vue_ls_config = {
  filetypes = { 'vue' },
}

-- nvim 0.11 or above
vim.lsp.config('vtsls', vtsls_config)
vim.lsp.config('vue_ls', vue_ls_config)
-- vim.lsp.config('ts_ls', ts_ls_config) -- vtslsはts_lsのwrapperなので使わない
vim.lsp.enable({'vtsls', 'vue_ls'}) -- If using `ts_ls` replace `vtsls` to `ts_ls`

