-- Terminal configuration
-- cf. https://zenn.dev/ryo_kawamata/articles/improve-neovmi-terminal

-- カスタムコマンド T: 下部に高さ20のターミナルを開く
vim.api.nvim_create_user_command('T', function(opts)
  vim.cmd('split')           -- 水平分割
  vim.cmd('wincmd j')        -- 下のウィンドウに移動
  vim.cmd('resize 10')       -- 高さを20に設定
  if opts.args and opts.args ~= '' then
    vim.cmd('terminal ' .. opts.args)  -- 引数がある場合はそれを実行
  else
    vim.cmd('terminal')      -- 引数がない場合は普通のターミナル
  end
end, {
  nargs = '*',              -- 任意の数の引数を受け取る
  desc = 'Open terminal in bottom split with height 20'
})

-- ターミナル開始時に自動的に挿入モードに入る
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.cmd('startinsert')
  end,
  desc = 'Start insert mode when terminal opens'
})

