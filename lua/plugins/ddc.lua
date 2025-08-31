-- DDC (Dark Deno-powered Completion) setup with vim.pack.add()
-- DDC requires denops.vim and has specific loading order requirements

vim.pack.add({
  -- ddc.vim core
  {
    src = 'https://github.com/Shougo/ddc.vim',
    version = 'main'
  },
  -- dependencies
  {
    -- denops.vim must be loaded first (required by ddc.vim)
    src = 'https://github.com/vim-denops/denops.vim',
    version = 'main'
  },
  {
    -- pum.vim
    src = 'https://github.com/Shougo/pum.vim',
    version = 'main'
  },
  {
    -- lspconfig (ddc-source-lsp-setup)
    src = 'https://github.com/neovim/nvim-lspconfig',
    version = "master"
  },
  {
    -- tree sitter (otter)
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'master'
  },
  {
    src = 'https://github.com/hrsh7th/vim-vsnip',
    version = 'master'
  },
  {
    -- vim-vsnipet-integ for ddc source
    src = 'https://github.com/uga-rosa/ddc-source-vsnip',
    version = 'main'
  },
  {
    -- markdown codeblock highlight
    src = 'https://github.com/jmbuhr/otter.nvim',
    version = 'main'
  },
  -- UI component
  -- {
  --   src = 'https://github.com/Shougo/ddc-ui-native',
  --   version = 'main'
  -- },
  {
    -- pum
    src = 'https://github.com/Shougo/ddc-ui-pum',
    version = 'main'
  },
  -- Sources (completion providers)
  {
    src = 'https://github.com/Shougo/ddc-source-around',
    version = 'main'
  },
  {
    src = 'https://github.com/LumaKernel/ddc-source-file',
    version = 'main'
  },
  {
    src = 'https://github.com/Shougo/ddc-source-lsp',
    version = 'main'
  },
  {
    src = 'https://github.com/uga-rosa/ddc-source-lsp-setup',
    version = 'main'
  },
  -- Filters (matchers, sorters, converters)
  {
    src = 'https://github.com/Shougo/ddc-filter-matcher_head',
    version = 'main'
  },
  {
    src = 'https://github.com/Shougo/ddc-filter-sorter_rank',
    version = 'main'
  },
  {
    src = 'https://github.com/tani/ddc-fuzzy',
    version = 'main'
  },
  -- completion help (signature and popup-preview)
  {
    src = 'https://github.com/matsui54/denops-signature_help',
    version = 'main'
  },
 -- {
 --   src = 'https://github.com/matsui54/denops-popup-preview.vim',
 --   version = 'main'
 -- },
  {
    src = 'https://github.com/uga-rosa/ddc-previewer-floating',
    version = 'main'
  },
})

-- Global DDC configuration
vim.fn['ddc#custom#patch_global']('ui', 'pum')

-- Sources configuration
-- ddc-source-lsp supports native-lsp!
-- https://github.com/Shougo/ddc-source-lsp/blob/main/doc/ddc-source-lsp.txt
-- snip https://github.com/uga-rosa/ddc-source-vsnip/blob/main/doc/ddc-source-vsnip.txt
vim.fn['ddc#custom#patch_global']('sources', {'lsp', 'around', 'file', 'vsnip'})

-- Source options configuration
vim.fn['ddc#custom#patch_global']('sourceOptions', {
  _ = {
    ignoreCase = true,
    matchers = {'matcher_fuzzy'},
    sorters = {'sorter_fuzzy'},
    converters = {'converter_fuzzy'},
  },
  around = {
    mark = 'A',
    maxItems = 5,
  },
  file = {
    mark = 'F',
    isVolatile = true,
    forceCompletionPattern = [[\S/\S*]],
    minAutoCompleteLength = 1,
    maxItems = 5,
  },
  lsp = {
    isVolatile = true,
    mark = 'lsp',
    forceCompletionPattern = [[\.\w*|:\w*|->\w*]],
    keywordPattern = [[\k+]],
    sorters = {'sorter_lsp-kind'},
    minAutoCompleteLength = 1,
    -- maxItems = 10,
  },
  vsnip = {
    mark = 'vsnip',
  },
})

-- Source parameters configuration
-- https://github.com/shun/dotconfig/blob/0bf4c710b448020f7f10d79b1bfe8374d3beaeee/nvim/rc/plugins/ddc/ddc.vim#L49
vim.fn['ddc#custom#patch_global']('sourceParams', {
  lsp = {
    enableResolveItem = true,
    enableAdditionalTextEdit = true,
    enableDisplayDetail = true,
    enableMatchLabel = true,
    lspEngine = 'nvim-lsp',
    snippetEngine = vim.fn['denops#callback#register'](function(body)
      return vim.fn['vsnip#anonymous'](body)
    end),
    confirmBehavior = 'insert',
  },
})

-- Filetype specific configuration
vim.fn['ddc#custom#patch_filetype'](
  {'ps1', 'dosbatch', 'autohotkey', 'registry'},
  {
    sourceOptions = {
      file = {
        forceCompletionPattern = [[\S\/\S*]],
      },
    },
    sourceParams = {
      file = {
        mode = 'unix',
      },
    }
  }
)

-- Setup additional DDC components
require("ddc_source_lsp_setup").setup()
--require("lspconfig").denols.setup({})
-- require("lspconfig").lua_ls.setup({})

-- pum completetion setting
vim.fn['pum#set_option']({
  border = "double",
  preview = false, -- pum help preview off
})

-- completetion help (floating window) settings
local ddc_previewer_floating = require("ddc_previewer_floating")
ddc_previewer_floating.setup({
  ui = "pum",
  border = "double",
  max_width = 80,
  max_height = 80,
  min_width = 30,
  min_height = 30,
  window_options = {
    number = true,
  },
})

-- Configure signature help
vim.g.signature_help_config = {
  contentsStyle = "labels",
  viewStyle = "floating"
}

-- enable
ddc_previewer_floating.enable()
vim.fn['signature_help#enable']()
vim.fn['ddc#enable']()

-- Key mappings for completion using pum.vim
-- Use Cmd mode to avoid E565 error with text changes
vim.keymap.set('i', '<TAB>', function()
  local pum_visible = vim.fn['pum#visible']()
  if pum_visible then
    return '<Cmd>call pum#map#insert_relative(1)<CR>'
  elseif vim.fn.col('.') <= 1 or vim.fn.getline('.'):sub(vim.fn.col('.') - 2, vim.fn.col('.') - 2):match('%s') then
    return '<TAB>'
  else
    return vim.fn['ddc#map#manual_complete']()
  end
end, { expr = true, desc = 'DDC completion or tab' })

vim.keymap.set('i', '<S-TAB>', function()
  local pum_visible = vim.fn['pum#visible']()
  if pum_visible then
    return '<Cmd>call pum#map#insert_relative(-1)<CR>'
  else
    return '<C-h>'
  end
end, { expr = true, desc = 'DDC completion back' })

-- Additional pum.vim keymaps for enhanced completion navigation
vim.keymap.set('i', '<C-n>', '<Cmd>call pum#map#insert_relative(+1)<CR>', { desc = 'Next completion item' })
vim.keymap.set('i', '<C-p>', '<Cmd>call pum#map#insert_relative(-1)<CR>', { desc = 'Previous completion item' })
vim.keymap.set('i', '<C-y>', '<Cmd>call pum#map#confirm()<CR>', { desc = 'Confirm completion' })
vim.keymap.set('i', '<C-e>', '<Cmd>call pum#map#cancel()<CR>', { desc = 'Cancel completion' })
vim.keymap.set('i', '<PageDown>', '<Cmd>call pum#map#insert_relative_page(+1)<CR>', { desc = 'Next completion page' })
vim.keymap.set('i', '<PageUp>', '<Cmd>call pum#map#insert_relative_page(-1)<CR>', { desc = 'Previous completion page' })

