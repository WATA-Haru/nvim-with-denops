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
vim.lsp.enable('copilot')

-- https://eiji.page/blog/neovim-diagnostic-config/
vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
    end,
  },
})

-- LSP attach autocmd for additional keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'vtsls' then
      -- Auto import keymaps for TypeScript/JavaScript
      vim.keymap.set('n', '<leader>ii', function()
        vim.lsp.buf.code_action({
          filter = function(action)
            local matches = action.kind and (
              action.kind:match("source%.addMissingImports") or
              action.kind:match("source%.fixAll") or
              action.kind:match("quickfix")
            )
            -- デバッグ: マッチしたaction kindを表示
            if matches then
              print("Auto import action found: " .. (action.kind or "unknown"))
            end
            return matches
          end,
          apply = true,
        })
      end, { buffer = args.buf, desc = 'Add missing imports' })
      
      -- Alternative: Show all available code actions
      vim.keymap.set('n', '<leader>ia', function()
        vim.lsp.buf.code_action()
      end, { buffer = args.buf, desc = 'Show all code actions' })
      
      vim.keymap.set('n', '<leader>io', function()
        vim.lsp.buf.code_action({
          filter = function(action)
            return action.kind and action.kind:match("source%.organizeImports")
          end,
          apply = true,
        })
      end, { buffer = args.buf, desc = 'Organize imports' })
    end
  end,
})
