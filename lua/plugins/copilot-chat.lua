vim.pack.add({
  {
    src = "https://github.com/nvim-lua/plenary.nvim",
    version = "master",
  },
  {
    src = "https://github.com/CopilotC-Nvim/CopilotChat.nvim",
    version = "main",
  },
})

require("CopilotChat").setup({})
