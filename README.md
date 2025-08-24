Memo
- Masonではなくmiseを使っているの

TODO:
- ディレクトリ構造、理想の構成を考える

## 参考
1. https://github.com/adibhanna/nvim/tree/main/lua
2. https://github.com/block-cube-lib/dotfiles/blob/master/nvim/dpp/toml/ddc.toml

## Directory structure
init.lua
lsp/
- lsp: lspをまとめるもの
- config: 要件等: 設定、pluginの設定がdpp以下で完結するから複雑にしなくてよさそう
  - common.lua: set nuとか基本的な設定
  - lsp.lua: lspの設定
  - keys.lua: keyの設定
  - dpp.ts: dpp.vimの設定
- dpp/
  - hooks/: plugins-setting
    - telescope.lua
    - xxx.lua
    ...
  - toml/: plugin
    - ddp.toml
    - ddc.toml
    - tool.toml

