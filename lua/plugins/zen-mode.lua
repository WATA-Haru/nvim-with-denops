vim.pack.add({
  {
    src = 'https://github.com/folke/zen-mode.nvim',
    version = 'main'
  }
})
require('zen-mode').setup {
  plugins = {
    options = {
      laststatus = 3, -- turn off the statusline in zen mode
    },
  }
}
