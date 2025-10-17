vim.pack.add({
  {
    src = 'https://github.com/folke/snacks.nvim',
    version = 'main'
  }
})

require("snacks").setup({
  rename = { enable = true },
  image = { enable = true },
  bigfile = { enable = true },
  indent = { enable = true },
  animate = { enable = false },
  bufdelete = { enable = false },
  dashboard = { enable = false },
  debug = { enable = false },
  dim = { enable = false },
  explorer = { enable = false },
  git = { enable = false },
  gitbrowse = { enable = false },
  health = { enable = false },
  input = { enable = false },
  layout = { enable = false },
  lazygit = { enable = false },
  meta = { enable = false },
  notifier = { enable = false },
  notify = { enable = false },
  picker = { enable = false },
  profiler = { enable = false },
  quickfile = { enable = false },
  scope = { enable = false },
  scratch = { enable = false },
  scroll = { enable = false },
  statuscolumn = { enable = false },
  terminal = { enable = false },
  toggle = { enable = false },
  util = { enable = false },
  win = { enable = false },
  words = { enable = false },
  zen = { enable = false },
})

-- Auto path rename for Oil.nvim integration
-- https://github.com/folke/snacks.nvim/blob/454ba02d69347c0735044f159b95d2495fc79a73/docs/rename.md?plain=1#L16
vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(event)
      if event.data.actions.type == "move" then
          Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
      end
  end,
})
