-- -- treesitter parser directory
local parser_dir = vim.fn.stdpath('data') .. '/treesitter-parsers'
vim.opt.runtimepath:append(parser_dir)

-- https://gpanders.com/blog/whats-new-in-neovim-0-11/
-- vim.diagnostic.config({ virtual_text = true })
-- Enable LSP servers
vim.lsp.enable('lua_ls')
vim.lsp.enable('marksman')
vim.lsp.enable({'vtsls', 'vue_ls'}) -- If using `ts_ls` replace `vtsls` to `ts_ls`
vim.lsp.enable('pyright')

-- https://gpanders.com/blog/whats-new-in-neovim-0-11/
-- vim.diagnostic.config({ virtual_text = true })
-- Enable LSP servers
vim.lsp.enable('lua_ls')
vim.lsp.enable('marksman')
vim.lsp.enable({'vtsls', 'vue_ls'}) -- If using `ts_ls` replace `vtsls` to `ts_ls`
vim.lsp.enable('pyright')


