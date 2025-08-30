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
  {
    src = 'https://github.com/Shougo/ddc-ui-native',
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
    src = 'https://github.com/matsui54/denops-popup-preview.vim',
    version = 'main'
  },
  {
    src = 'https://github.com/matsui54/denops-signature_help',
    version = 'main'
  },
})

-- DDC Configuration in Lua (converted from VimScript)
-- cf. https://qiita.com/maachan_9692/items/9b507fd043424013abde

-- Global DDC configuration
vim.fn['ddc#custom#patch_global']('ui', 'native')

-- Sources configuration
-- ddc-source-lsp supports native-lsp!
-- https://github.com/Shougo/ddc-source-lsp/blob/main/doc/ddc-source-lsp.txt
vim.fn['ddc#custom#patch_global']('sources', {'lsp', 'around', 'file'})

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
    sorters = {'sorter_lsp-kind'},
    minAutoCompleteLength = 1,
    maxItems = 10,
  },
})

-- Source parameters configuration
-- https://github.com/shun/dotconfig/blob/0bf4c710b448020f7f10d79b1bfe8374d3beaeee/nvim/rc/plugins/ddc/ddc.vim#L49
vim.fn['ddc#custom#patch_global']('sourceParams', {
  lsp = {
    lspEngine = 'nvim-lsp',
    snippetEngine = vim.fn['denops#callback#register'](function(body)
      return vim.fn['vsnip#anonymous'](body)
    end),
    bufnr = vim.NIL,
    confirmBehavior = 'insert',
    enableAdditionalTextEdit = true,
    enableDisplayDetail = true,
    enableResolveItem = true,
  },
})

-- Auto complete events
vim.fn['ddc#custom#patch_global']('autoCompleteEvents', {
  'InsertEnter', 'TextChangedI', 'TextChangedP', 'TextChangedT'
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

-- Register snippet engine (vim-vsnip) if available
if vim.fn.exists('*vsnip#anonymous') == 1 then
  vim.fn['ddc#custom#patch_global']('sourceParams', {
    lsp = {
      snippetEngine = vim.fn['denops#callback#register'](function(body)
        return vim.fn['vsnip#anonymous'](body)
      end),
    }
  })
end

-- Enable DDC
vim.fn['ddc#enable']()

-- Key mappings for completion
vim.keymap.set('i', '<TAB>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-n>'
  elseif vim.fn.col('.') <= 1 or vim.fn.getline('.'):sub(vim.fn.col('.') - 2, vim.fn.col('.') - 2):match('%s') then
    return '<TAB>'
  else
    return vim.fn['ddc#map#manual_complete']()
  end
end, { expr = true, desc = 'DDC completion or tab' })

vim.keymap.set('i', '<S-TAB>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-p>'
  else
    return '<C-h>'
  end
end, { expr = true, desc = 'DDC completion back' })

-- Setup additional DDC components
require("ddc_source_lsp_setup").setup()
require("lspconfig").denols.setup({})


