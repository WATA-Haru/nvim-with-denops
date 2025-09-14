local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- leader key is Space
vim.g.mapleader = ' '

-- map('n', '<leader>f', '1z=', opts)
-- map('n', '<leader>s', ':set spell!<CR>', opts)
-- window resize
map('n', '<leader><', '5<c-w><', opts)
map('n', '<leader>>', '5<c-w>>', opts)

-- ESC to jk
map('i', 'jk', '<ESC>', opts)

map('n', '<Leader>/', '/\\C', opts)
map('n', '<Leader>?', '?\\C', opts)

map('n', '<Leader>n', '/<Up>\\C<CR>', opts)
map('n', '<Leader>N', '?<Up>\\C<CR>', opts)

-- terminal mode settings
-- https://zenn.dev/ryo_kawamata/articles/improve-neovmi-terminal
map('t', 'jk', '<C-\\><C-n>', opts)

-- telescope
-- -- lsp definition
map('n', 'gd', '<cmd>lua require"telescope.builtin".lsp_definitions()<CR>', opts)
map('n', 'gtab', '<cmd>lua require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })<CR>', opts)
-- or map('n', 'gd', '<cmd>lua vim.lsp.buf.definition() <CR>', opts)
map('n', 'gb', '<C-t>', opts)
map('n', 'gr', '<cmd>lua require"telescope.builtin".lsp_references()<CR>', opts)
map('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
map('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

-- -- fuzzy-finder
map('n', '<leader>ff', '<cmd>lua require"telescope.builtin".find_files({ winblend = 15 })<CR>', { desc = 'Telescope find files' })
map('n', '<leader>fg', '<cmd>lua require"telescope.builtin".live_grep({ winblend = 15 })<CR>', { desc = 'Telescope live grep' })
map('n', '<leader>fb', '<cmd>lua require"telescope.builtin".buffers({ winblend = 15 })<CR>', { desc = 'Telescope buffers' })
map('n', '<leader>fh', '<cmd>lua require"telescope.builtin".help_tags({ winblend = 15 })<CR>', { desc = 'Telescope help tags' })

-- fern drawer
map('n', '<leader>e', '<cmd>Fern . -drawer -toggle <CR>', { desc = 'File viewer(fern)' })

-- disable tab when in markdown file because it conflicts with copilot
-- https://github.com/ixru/nvim-markdown?tab=readme-ov-file#visual-mode
vim.keymap.set('i', '<Plug>', '<Plug>Markdown_Jump', opts)
vim.keymap.set('n', '<Plug>', '<Plug>Markdown_MoveToParentHeader', opts)

-- copilot completion
-- https://neovim.io/doc/user/lsp.html#vim.lsp.inline_completion.get()
vim.keymap.set('i', '<tab>', function()
  if not vim.lsp.inline_completion.get() then
    return '<tab>'
  end
end, { expr = true, desc = 'Accept the current inline completion' })

-- no-neck-pain toggle
map('n', '<leader>ze', '<cmd>lua NoNeckPain.toggle()<CR>', { desc = 'Toggle No Neck Pain nvim' })

-- popup_preview.vimのフローティングウィンドウに移動
vim.keymap.set('n', '<C-w>p', function()
  -- popup_preview.vimのwinidを取得
  local ok, winid = pcall(vim.fn['popup_preview#doc#get_winid'])
  
  if ok and winid and winid ~= 0 and vim.api.nvim_win_is_valid(winid) then
    -- popup_previewのウィンドウに移動
    vim.api.nvim_set_current_win(winid)
  else
    -- フォールバック: 他のフローティングウィンドウを探す
    local current_win = vim.api.nvim_get_current_win()
    for _, win_id in ipairs(vim.api.nvim_list_wins()) do
      local win_config = vim.api.nvim_win_get_config(win_id)
      if win_config.relative ~= '' and win_id ~= current_win then
        vim.api.nvim_set_current_win(win_id)
        return
      end
    end
    -- どちらも見つからない場合は通常のウィンドウ移動
    vim.cmd('wincmd w')
  end
end, { desc = 'Jump to popup preview or floating window' })

-- フローティングウィンドウへ移動するキーマッピングを定義
-- vim.keymap.set('i', '<C-q>', function()
--   local current_win = vim.api.nvim_get_current_win()
-- 
--   -- すべてのウィンドウをチェック
--   for _, win_id in ipairs(vim.api.nvim_list_wins()) do
--     local win_config = vim.api.nvim_win_get_config(win_id)
-- 
--     -- フローティングウィンドウであり、かつ現在アクティブでないウィンドウを探す
--     if win_config.relative ~= '' and win_id ~= current_win then
--       vim.api.nvim_set_current_win(win_id)
--       return
--     end
--   end
-- end, { desc = 'Jump to a floating window' })
