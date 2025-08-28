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

-- Load DDC configuration from VimScript file
local ddc_config_path = vim.fn.stdpath("config") .. "/vimscriptForPlugins/ddc.vim"
if vim.fn.filereadable(ddc_config_path) == 1 then
  vim.cmd("source " .. ddc_config_path)
else
  vim.notify("DDC config file not found: " .. ddc_config_path, vim.log.levels.WARN)
end
