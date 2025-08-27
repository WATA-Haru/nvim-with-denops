-- DDC (Dark Deno-powered Completion) setup with vim.pack.add()
-- DDC requires denops.vim and has specific loading order requirements

vim.pack.add({
  -- 1. denops.vim must be loaded first (required by ddc.vim)
  {
    src = 'https://github.com/vim-denops/denops.vim',
    version = 'main'
  },
  -- 2. ddc.vim core
  {
    src = 'https://github.com/Shougo/ddc.vim',
    version = 'main'
  },
  -- 3. UI component
  {
    src = 'https://github.com/Shougo/ddc-ui-native',
    version = 'main'
  },
  -- 4. Sources (completion providers)
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
  -- 5. Filters (matchers, sorters, converters)
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
  }
})

-- Load DDC configuration in Lua
local function setup_ddc()
  -- cf. https://qiita.com/maachan_9692/items/9b507fd043424013abde
  
  -- Set UI to native
  vim.fn['ddc#custom#patch_global']('ui', 'native')
  
  -- ddc-source-lsp supports native-lsp!
  vim.fn['ddc#custom#patch_global']('sources', {'around', 'file', 'lsp'})
  
  -- Configure source options with marks for identification
  vim.fn['ddc#custom#patch_global']('sourceOptions', {
    _ = {
      matchers = {'matcher_fuzzy'},
      sorters = {'sorter_fuzzy'},
      converters = {'converter_fuzzy'},
      minAutoCompleteLength = 1,
    },
    around = {
      mark = 'A',
      maxItems = 5,
    },
    file = {
      mark = 'F',
      isVolatile = true,
      forceCompletionPattern = [[\S/\S*]],
      maxItems = 5,
    },
    lsp = {
      isVolatile = true,
      mark = 'lsp',
      forceCompletionPattern = [[\.\w*|:\w*|->\w*]],
      sorters = {'sorter_lsp-kind'},
      maxItems = 10,
    },
  })
  
  -- Configure for specific filetypes
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
  
  -- Configure LSP snippet engine (if vsnip is available)
  local ok, _ = pcall(require, 'vsnip')
  if ok then
    vim.fn['ddc#custom#patch_global']('sourceParams', {
      lsp = {
        snippetEngine = vim.fn['denops#callback#register'](function(body)
          vim.fn['vsnip#anonymous'](body)
        end),
      }
    })
  end
  
  -- Enable DDC
  vim.fn['ddc#enable']()
end

-- Safe setup with error handling
local ok, err = pcall(setup_ddc)
if not ok then
  vim.notify("DDC setup failed: " .. tostring(err), vim.log.levels.ERROR)
end

-- Key mappings
vim.keymap.set('i', '<TAB>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-n>'
  elseif vim.fn.col('.') <= 1 or vim.fn.getline('.'):sub(vim.fn.col('.') - 1, vim.fn.col('.') - 1):match('%s') then
    return '<TAB>'
  else
    return vim.fn['ddc#map#manual_complete']()
  end
end, { expr = true })

vim.keymap.set('i', '<S-TAB>', function()
  return vim.fn.pumvisible() == 1 and '<C-p>' or '<C-h>'
end, { expr = true })
