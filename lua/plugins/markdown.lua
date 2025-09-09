-- markdown plugins

vim.pack.add({
  {
    -- markdown useful completion (ex. bullet points completetion)
    src = "https://github.com/ixru/nvim-markdown",
    version = "master"
  },
  {
    -- render markdown
    src = "https://github.com/MeanderingProgrammer/render-markdown.nvim.git",
    version = "main"
  }
})

require('render-markdown').setup({
  render_modes = true,
  heading = {
    width = "block",
    left_pad = 0,
    right_pad = 4,
    icons = {},
  },
  code = {
    width = "block",
  },
  bullet = {
      enabled = false,
  },
})

