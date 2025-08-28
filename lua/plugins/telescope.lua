-- telescope.nvim depends on plenary.nvim, so plenary must be loaded first
vim.pack.add({
  {
    src = 'https://github.com/nvim-lua/plenary.nvim',
    version = 'master'
  },
  {
    src = 'https://github.com/nvim-telescope/telescope.nvim',
    version = 'master'
  }
})

require('telescope').setup({
  defaults = {
    sorting_strategy = "ascending",
    winblend = 4,
    file_ignore_patterns = {
      "^.git/",
      "^node_modules/",
    }
  }
})
