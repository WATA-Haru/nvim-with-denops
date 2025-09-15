vim.pack.add({
  {
    src = "https://github.com/olimorris/codecompanion.nvim",
    version = "main",
  },
  -- dependencies
  {
    src = "https://github.com/nvim-lua/plenary.nvim",
    version = "master",
  },
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "master",
  },
  {
    src = "https://github.com/zbirenbaum/copilot.lua",
    version = "master"
  }
})

require("codecompanion").setup({
  opts = {
    log_level = "DEBUG", -- or "TRACE"
  },
  strategies = {
    chat = {
      adapter = "copilot",
    },
    inline = {
      adapter = "copilot",
    },
    cmd = {
      adapter = "copilot",
    }
  },
  display = {
    chat = {
      window = {
        layout = "vertical",
        position = "right",
        width = 0.4,
      }
    }
  }
})

