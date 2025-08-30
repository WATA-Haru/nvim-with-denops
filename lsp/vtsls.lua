-- ref:https://github.com/vuejs/language-tools/wiki/Neovim
-- ref: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#vtsls
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
  --  or
  -- cmd = { "deno", "run", "--allow-all", "--unstable-detect-cjs", vtsls_path, "--stdio" },
  cmd = { "node", vtsls_path, "--stdio" },
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

--local ts_ls_config = {
--  init_options = {
--    plugins = {
--      vue_plugin,
--    },
--  },
--  filetypes = tsserver_filetypes,
--}

-- Simple vue_ls config for testing
local vue_ls_config = {}

-- nvim 0.11 or above
vim.lsp.config('vtsls', vtsls_config)
vim.lsp.config('vue_ls', vue_ls_config)

