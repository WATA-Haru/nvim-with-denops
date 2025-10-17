vim.pack.add({
  {
    src = 'https://github.com/folke/snacks.nvim',
    version = 'main'
  }
})

require("snacks").setup({
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  explorer = { enabled = false },
  indent = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true },
  notifier = { enabled = false },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = false },
  statuscolumn = { enabled = false },
})

-- Auto path rename for Oil.nvim integration
vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(event)
      if event.data.actions.type == "move" then
          Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
      end
  end,
})
