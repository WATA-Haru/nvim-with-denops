vim.pack.add({
  {
    src = 'https://github.com/folke/snacks.nvim',
    version = 'main'
  }
})

require("snacks").setup({
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  explorer = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true },
  notifier = { enabled = false },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = false },
  statuscolumn = { enabled = false },
})
