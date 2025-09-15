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
  -- model = 'claude-3.7-sonnet',
  -- model = 'claude-opus-4',
  model = 'claude-sonnet-4',
  temperature = 0.1,           -- Lower = focused, higher = creative
  window = {
    layout = 'vertical',       -- 'vertical', 'horizontal', 'float'
    width = 0.4,
    border = 'rounded', -- 'single', 'double', 'rounded', 'solid'
    title = '🤖 AI Assistant',
    zindex = 100, -- Ensure window stays on top
  },

  auto_insert_mode = true,     -- Enter insert mode when opening

  headers = {
    user = '👤 You',
    assistant = '🤖 Copilot',
    tool = '🔧 Tool',
  },

  separator = '━━',
  auto_fold = true, -- Automatically folds non-assistant messages
  prompts = {
     Explain = {
         prompt = '選択したコードの説明を日本語で書いてください',
         mapping = '<leader>ce',
     },
     Review = {
         prompt = 'コードを日本語でレビューしてください',
         mapping = '<leader>cr',
     },
     Fix = {
         prompt = 'このコードには問題があります。バグを修正したコードを表示してください。説明は日本語でお願いします',
         mapping = '<leader>cf',
     },
     Optimize = {
         prompt = '選択したコードを最適化し、パフォーマンスと可読性を向上させてください。説明は日本語でお願いします',
         mapping = '<leader>co',
     },
     Docs = {
         prompt = '選択したコードに関するドキュメントコメントを日本語で生成してください',
         mapping = '<leader>cd',
     },
     Tests = {
         prompt = '選択したコードの詳細なユニットテストを書いてください。説明は日本語でお願いします',
         mapping = '<leader>ct',
     },
     Commit = {
         prompt = require('CopilotChat.config.prompts').Commit.prompt,
         mapping = '<leader>cco',
         selection = require('CopilotChat.select').gitdiff,
     },
   },
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


vim.keymap.set('n', '<leader>cc', '<CMD>CopilotChatToggle<CR>', { desc = 'CopilotChat - Toggle' })

vim.keymap.set('n', '<leader>cch', function()
  local actions = require('CopilotChat.actions')
  require('CopilotChat.integrations.telescope').pick(actions.help_actions())
end, { desc = 'CopilotChat - Help actions' })

vim.keymap.set('n', '<leader>ccp', function()
  local actions = require('CopilotChat.actions')
  local select = require('CopilotChat.select')
  require('CopilotChat.integrations.telescope').pick(actions.prompt_actions({
    selection = select.visual,
  }))
end, { desc = 'CopilotChat - Prompt actions' })

