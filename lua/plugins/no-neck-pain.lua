vim.pack.add({
  {
    src = "https://github.com/shortcuts/no-neck-pain.nvim",
    version = "main"
  }
})

require("no-neck-pain").setup({
    -- The width of the focused window that will be centered. When the terminal width is less than the `width` option, the side buffers won't be created.
    ---@type integer|"textwidth"|"colorcolumn"
    width = 140,
})

