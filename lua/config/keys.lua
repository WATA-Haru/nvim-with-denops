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
map('n', 'gd', '<cmd>lua require"telescope.builtin".lsp_definitions()<CR>', opts)
map('n', 'gtab', '<cmd>lua require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })<CR>', opts)
-- or map('n', 'gd', '<cmd>lua vim.lsp.buf.definition() <CR>', opts)
map('n', 'gb', '<C-t>', opts)
map('n', 'gr', '<cmd>lua require"telescope.builtin".lsp_references()<CR>', opts)
map('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
map('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

-- fuzzy-finder
map('n', '<leader>ff', '<cmd>lua require"telescope.builtin".find_files()<CR>', { desc = 'Telescope find files' })
map('n', '<leader>fg', '<cmd>lua require"telescope.builtin".live_grep()<CR>', { desc = 'Telescope live grep' })
map('n', '<leader>fb', '<cmd>lua require"telescope.builtin".buffers()<CR>', { desc = 'Telescope buffers' })
map('n', '<leader>fh', '<cmd>lua require"telescope.builtin".help_tags()<CR>', { desc = 'Telescope help tags' })

-- fern drawer
map('n', '<leader>e', '<cmd>Fern . -drawer -toggle <CR>', { desc = 'File viewer(fern)' })

-- copilot completion
-- vim.keymap.set('i', '<C-CR>', '<cmd>lua vim.lsp.inline_completion.get()<CR>', { silent = true })
vim.keymap.set('i', '<TAB>', '<cmd>lua vim.lsp.inline_completion.get()<CR>', { silent = true })

-- zen mode toggle
map('n', '<leader>ze', '<cmd>lua require("zen-mode").toggle()<CR>', { desc = 'Toggle Zen Mode' })

-- フローティングウィンドウへ移動するキーマッピングを定義
vim.keymap.set('n', '<C-w>f', function()
  local current_win = vim.api.nvim_get_current_win()

  -- すべてのウィンドウをチェック
  for _, win_id in ipairs(vim.api.nvim_list_wins()) do
    local win_config = vim.api.nvim_win_get_config(win_id)

    -- フローティングウィンドウであり、かつ現在アクティブでないウィンドウを探す
    if win_config.relative ~= '' and win_id ~= current_win then
      vim.api.nvim_set_current_win(win_id)
      return
    end
  end

  -- フローティングウィンドウが見つからない場合、通常のウィンドウ移動を試みる
  vim.cmd('wincmd w')
end, { desc = 'Jump to a floating window' })
