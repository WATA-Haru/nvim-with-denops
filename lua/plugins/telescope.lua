-- telescope.nvim depends on plenary.nvim, so plenary must be loaded first
vim.pack.add({
  {
    src = 'https://github.com/nvim-lua/plenary.nvim',
    version = 'master'
  },
  {
    src = 'https://github.com/nvim-telescope/telescope.nvim',
    version = 'master'
  },
  {
    src = 'https://github.com/kiyoon/telescope-insert-path.nvim',
    version = 'master'
  }
})

-- insert path actions
local path_actions = require('telescope_insert_path')

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
    },
    mappings = {
      n = {
        -- insert path mappings
        -- E.g. Type `[i`, `[I`, `[a`, `[A`, `[o`, `[O` to insert relative path and select the path in visual mode.
        -- Other mappings work the same way with a different prefix.
        ["["] = path_actions.insert_reltobufpath_visual,
        ["]"] = path_actions.insert_abspath_visual,
        ["{"] = path_actions.insert_reltobufpath_insert,
        ["}"] = path_actions.insert_abspath_insert,
        ["-"] = path_actions.insert_reltobufpath_normal,
        ["="] = path_actions.insert_abspath_normal,
	-- If you want to get relative path that is relative to the cwd, use
	-- `relpath` instead of `reltobufpath`
        -- You can skip the location postfix if you specify that in the function name.
        -- ["<C-o>"] = path_actions.insert_relpath_o_visual,
      }
    }
  }
})

