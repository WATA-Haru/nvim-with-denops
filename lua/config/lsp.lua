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
vim.lsp.inline_completion.enable(true)

-- https://eiji.page/blog/neovim-diagnostic-config/
vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
    end,
  },
})

vim.api.nvim_create_user_command(
  'ToggleCopilot',
  function ()
    print("=== ToggleCopilot DEBUG START ===")
    
    local client_list = vim.lsp.get_clients()
    print("client_list type: " .. type(client_list))
    print("client_list length: " .. #client_list)
    
    -- クライアント一覧をデバッグ出力
    for i, client in ipairs(client_list) do
      print("Client " .. i .. ": name=" .. (client.name or "nil") .. ", id=" .. (client.id or "nil"))
    end
    
    -- copilotクライアントがあるかチェック
    local copilot_client = nil
    for _, client in ipairs(client_list) do
      if client.name == "copilot" then
        copilot_client = client
        break
      end
    end
    
    print("copilot_client found: " .. tostring(copilot_client ~= nil))
    
    if copilot_client then
      print("Disabling copilot...")
      -- 全てのcopilotクライアントを停止
      for _, client in ipairs(client_list) do
        if client.name == "copilot" then
          print("Stopping copilot client id: " .. client.id)
          client.stop()
        end
      end
      vim.notify("Copilot disabled", vim.log.levels.INFO)
      return
    else
      print("Enabling copilot...")
      vim.lsp.enable('copilot')
      vim.notify("Copilot enabled", vim.log.levels.INFO)
    end
    
    print("=== ToggleCopilot DEBUG END ===")
  end,
  { desc = "toggle copilot activation" }
)

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
