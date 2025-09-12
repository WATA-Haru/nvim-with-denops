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

require("CopilotChat").setup({
  model = 'claude-3.7-sonnet',
  -- model = 'claude-4.0-sonnet',
  temperature = 0.1,           -- Lower = focused, higher = creative
  window = {
   layout = 'vertical',       -- 'vertical', 'horizontal', 'float'
   width = 0.5,              -- 50% of screen width
  },
  auto_insert_mode = true,     -- Enter insert mode when opening
  window = {
    layout = 'float',
    width = 80, -- Fixed width in columns
    height = 20, -- Fixed height in rows
    border = 'rounded', -- 'single', 'double', 'rounded', 'solid'
    title = '🤖 AI Assistant',
    zindex = 100, -- Ensure window stays on top
  },

  headers = {
    user = '👤 You',
    assistant = '🤖 Copilot',
    tool = '🔧 Tool',
  },

  separator = '━━',
  auto_fold = true, -- Automatically folds non-assistant messages
})

-- Auto-command to customize chat buffer behavior
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'copilot-*',
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.conceallevel = 0
  end,
})

-- In your colorscheme or init.lua
vim.api.nvim_set_hl(0, 'CopilotChatHeader', { fg = '#7C3AED', bold = true })
vim.api.nvim_set_hl(0, 'CopilotChatSeparator', { fg = '#374151' })
