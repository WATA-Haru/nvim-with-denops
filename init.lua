local nvimDir = "~/.config/nvim-with-denos"
local dppSrc = "~/.cache/dpp/repos/github.com/Shougo/dpp.vim"
local denopsSrc = "~/.cache/dpp/repos/github.com/denops/denops.vim"
local denopsInstaller = "~/.cache/dpp/repos/github.com/Shougo/dpp-ext-installer"

-- プラグイン内のLuaモジュールを読み込むため、先にruntimepathに追加する必要があります。(https://zenn.dev/comamoca/articles/howto-setup-dpp-vim#fnref-f53a-2)
vim.opt.runtimepath:prepend(dppSrc)

local dpp = require("dpp")
local dppBase = "~/.cache/dpp"
local dppConfig = "${nvimDir}/dpp.ts"

local denopsSrc = "$HOME/.cache/dpp/repos/github.com/vim-denops/denops.vim"
local extToml = "$HOME/.cache/dpp/repos/github.com/Shougo/dpp-ext-toml"
local extLazy = "$HOME/.cache/dpp/repos/github.com/Shougo/dpp-ext-lazy"
local extInstaller = "$HOME/.cache/dpp/repos/github.com/Shougo/dpp-ext-installer"
local extGit = "$HOME/.cache/dpp/repos/github.com/Shougo/dpp-protocol-git"

vim.opt.runtimepath:append(extToml)
vim.opt.runtimepath:append(extLazy)
vim.opt.runtimepath:append(extInstaller)
vim.opt.runtimepath:append(extGit)


if dpp.load_state(dppBase) then
  vim.opt.runtimepath:prepend(denopsSrc)
  vim.opt.runtimepath:prepend(denopsInstaller)

  vim.api.nvim_create_autocmd("User", {
    pattern = "DenopsReady",
    callback = function()
      vim.notify("dpp load_state() is failed")
      dpp.make_state(dppBase, dppConfig)
    end,
  })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "Dpp:makeStatePost",
  callback = function()
    vim.notify("dpp make_state() is done")
  end,
})

vim.cmd("filetype indent plugin on")
vim.cmd("syntax on")
vim.cmd("set nu")


------  setting ------
---===================
-- いったん下にkeysを書いておく

--fetch keyvim.api.nvim_set_keymap
local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

-- update leader key to space
vim.g.mapleader = " "

-- map('n', '<leader>f', '1z=', opts)
-- map('n', '<leader>s', ':set spell!<CR>', opts)
-- window resize
map('n', '<leader><', '5<c-w><', opts)
map('n', '<leader>>', '5<c-w>>', opts)

-- ESC to jk
map("i", "jk", "<ESC>", opts)

-- \C を付けた状態で検索開始
map('n', '<Leader>/', '/\\C', opts)
map('n', '<Leader>?', '?\\C', opts)

-- 最後の検索に \C を付け加えた状態で検索し直す
map('n', '<Leader>n', '/<Up>\\C<CR>', opts)
map('n', '<Leader>N', '?<Up>\\C<CR>', opts)


