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
    layout_strategy = "vertical",
    layout_config = {
      vertical = { width = 0.9 },
    },
    -- -- cursor version
    -- layout_strategy = "cursor",
    -- layout_config = {
    --   cursor = { width = 0.9 },
    -- },
    sorting_strategy = "ascending",
    file_ignore_patterns = {
      "^.git/",
      "^node_modules/",
    }
  }
})
