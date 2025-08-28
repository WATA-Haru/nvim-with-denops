-- oil.nvim depends on nvim-web-devicons, so devicons must be loaded first
vim.pack.add({
  {
    src = 'https://github.com/nvim-tree/nvim-web-devicons',
    version = 'master'
  },
  { 
    src = 'https://github.com/stevearc/oil.nvim',
    version = 'master'
  }
})

require("oil").setup({
  view_options = {
    show_hidden = true,
    is_hidden_file = function(name, bufnr)
      local m = name:match("^%.")
      return m ~= nil
    end,
    is_always_hidden = function(name, bufnr)
      return false
    end,
  },
  lsp_file_methods = {
    -- https://github.com/stevearc/oil.nvim/blob/07f80ad645895af849a597d1cac897059d89b686/README.md?plain=1#L182
    autosave_changes = true,
  }
})

-- Ex, Ve, Seコマンドを定義
vim.api.nvim_create_user_command("Ex", function(opts)
  local path = opts.args
  if path == "" then
    vim.cmd("Oil %:p:h")
  else
    vim.cmd("Oil " .. path)
  end
end, { nargs = '?', complete = 'file' })

vim.api.nvim_create_user_command("Ve", function(opts)
  local path = opts.args
  if path == "" then
    vim.cmd("vertical Oil %:p:h")
  else
    vim.cmd("vertical Oil " .. path)
  end
end, { nargs = '?', complete = 'file' })

vim.api.nvim_create_user_command("Se", function(opts)
  local path = opts.args
  if path == "" then
    vim.cmd("split Oil %:p:h")
  else
    vim.cmd("split Oil " .. path)
  end
end, { nargs = '?', complete = 'file' })
