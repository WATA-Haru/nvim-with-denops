vim.pack.add({
  {
    src = "https://github.com/zbirenbaum/copilot.lua",
    version = "master"
  }
})

-- cf. https://zenn.dev/kawarimidoll/books/6064bf6f193b51/viewer/90a5be
-- cf. https://syu-m-5151.hatenablog.com/entry/2025/02/11/183337
local home_dir = os.getenv("HOME")
local copilot_path = home_dir .. "/.local/share/mise/installs/npm-github-copilot-language-server/latest/bin/copilot-language-server"

require('copilot').setup({
  server = {
    type = "nodejs",
    custom_server_filepath = copilot_path,
  },
  suggestion = {
    auto_trigger = true,
    hide_during_completion = false,
    keymap = {
      accept = "<Tab>",
    }
  },
  filetypes = {
    yaml = true,
    markdown = true,
    help = false,
    gitcommit = true,
    gitrebase = true,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
    ['*'] = function()
      -- disable for files with specific names
      local fname = vim.fs.basename(vim.api.nvim_buf_get_name(0))

      local disable_patterns = { 'env', 'conf', 'local', 'private' }
      return vim.iter(disable_patterns):all(
        function(pattern)
          return not string.match(fname, pattern)
        end
      )
    end,
  },
})

local hl = vim.api.nvim_get_hl(0, { name = 'Comment' })
vim.api.nvim_set_hl(0, 'CopilotSuggestion', vim.tbl_extend('force', hl, { underline = true }))

