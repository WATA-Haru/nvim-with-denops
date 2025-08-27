local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

vim.opt.termguicolors = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.syntax = on
vim.opt.number = true
vim.opt.encoding = "utf-8"
vim.opt.mouse = 'a'
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.list = true
vim.opt.listchars = {
    tab='-»',
    -- eol='↲',
    space = '·'
    --trail='-',
    --extends='»', 
    --precedes='«', 
    --nbsp='%',
}
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"

-- treesitter parser directory
-- local parser_dir = vim.fn.stdpath("data") .. "/treesitter-parsers"
-- vim.opt.runtimepath:append(parser_dir)

-- update leader key to space
vim.g.mapleader = " "
vim.cmd("filetype plugin indent on")

-- colorscheme
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.clipboard = 'unnamedplus' --クリップボードとレジスタを共有

-- clipboard
if vim.fn.has("wsl") == 1 then
    vim.g.clipboard = {
        name = "myClipboard",
        copy = {
            ["+"] = "win32yank.exe -i",
            ["*"] = "win32yank.exe -i",
        },
        paste = {
            ["+"] = "win32yank.exe -o",
            ["*"] = "win32yank.exe -o",
        },
        cache_enabled = 1,
    }
end

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

-- telescope
map('n', 'gd', '<cmd>lua require"telescope.builtin".lsp_definitions()<CR>', opts)
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

-- lsp settings
-- https://gpanders.com/blog/whats-new-in-neovim-0-11/
-- TODO
-- vim.diagnostic.config({ virtual_text = true })
-- vim.lsp.enable('lua_ls')
-- vim.lsp.enable('marksman')
-- vim.lsp.enable({'vtsls', 'vue_ls'}) -- If using `ts_ls` replace `vtsls` to `ts_ls`
-- vim.lsp.enable('pyright')

-- -- for snacks
-- auto path rename
-- vim.api.nvim_create_autocmd("User", {
--   pattern = "OilActionsPost",
--   callback = function(event)
--       if event.data.actions.type == "move" then
--           Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
--       end
--   end,
-- })
--

require('plugins.tender')
