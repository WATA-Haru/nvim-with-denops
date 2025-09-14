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
  {
    src = 'https://github.com/matsui54/denops-popup-preview.vim',
    version = 'main'
  },
  --{
  --  src = 'https://github.com/uga-rosa/ddc-previewer-floating',
  --  version = 'main'
  --},
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


-- pum completetion setting
vim.cmd[[highlight POPUP_NORMAL guibg=#595e50 guifg=White]]
vim.fn['pum#set_option']({
  border = "none",
  preview = false, -- pum help preview off
  blend = 40,
  horizontal_menu = "POPUP_NORMAL",
})
-- Configure signature help
vim.g.signature_help_config = {
  contentsStyle = "labels",
  viewStyle = "floating"
}

-- puopup preview setting
vim.g.popup_preview_config = {
  winblend = 40,
}

-- enable
-- ddc_previewer_floating.enable()
vim.fn['signature_help#enable']()
vim.fn['popup_preview#enable']()
vim.fn['ddc#enable']()

-- https://github.com/matsui54/denops-popup-preview.vim/issues/35
local key_map_opts = {
    noremap = true,
    expr = true,
    silent = true,
    buffer = true,
    -- the `popup_preview#scroll` returns the internal codes already, it results
    -- in unexpected behavior when this option is true.
    -- this option is true on default when `expr` is true.
    replace_keycodes = false
}
-- Create the scroll keymap only for attached buffer.
vim.api.nvim_create_autocmd(
    "LspAttach",
    {
        callback = function()
            vim.keymap.set("i", "<C-f>",
                function()
                    return vim.fn['popup_preview#scroll'](4)
                end,
                key_map_opts
            )
            vim.keymap.set("i", "<C-b>",
                function()
                    return vim.fn['popup_preview#scroll'](-4)
                end,
                key_map_opts
            )
            -- popup_previewの内容を別バッファで開く
            vim.keymap.set("i", "<C-t>",
                function()
                    -- timer_startで遅延実行してE565エラー回避
                    vim.fn.timer_start(0, function()
                        local ok, winid = pcall(vim.fn['popup_preview#doc#get_winid'])
                        if ok and vim.api.nvim_win_is_valid(winid) then
                            -- popup_previewの内容を取得
                            local bufnr = vim.api.nvim_win_get_buf(winid)
                            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
                            -- 新しい分割ウィンドウを作成
                            vim.cmd('split')
                            -- 新しいバッファを作成
                            local new_bufnr = vim.api.nvim_create_buf(false, true)
                            vim.api.nvim_buf_set_lines(new_bufnr, 0, -1, false, lines)
                            -- 新しいウィンドウでバッファを表示
                            vim.api.nvim_win_set_buf(0, new_bufnr)
                        else
                            vim.notify("No popup preview window found", vim.log.levels.WARN)
                        end
                    end)
                end,
                key_map_opts
            )
        end
    }
)

-- Key mappings for completion using pum.vim
-- Use Cmd mode to avoid E565 error with text changes
-- vim.keymap.set('i', '<TAB>', function()
--   local pum_visible = vim.fn['pum#visible']()
--   if pum_visible then
--     return '<Cmd>call pum#map#insert_relative(1)<CR>'
--   elseif vim.fn.col('.') <= 1 or vim.fn.getline('.'):sub(vim.fn.col('.') - 2, vim.fn.col('.') - 2):match('%s') then
--     return '<TAB>'
--   else
--     return vim.fn['ddc#map#manual_complete']()
--   end
-- end, { expr = true, desc = 'DDC completion or tab' })
-- 
-- vim.keymap.set('i', '<S-TAB>', function()
--   local pum_visible = vim.fn['pum#visible']()
--   if pum_visible then
--     return '<Cmd>call pum#map#insert_relative(-1)<CR>'
--   else
--     return '<C-h>'
--   end
-- end, { expr = true, desc = 'DDC completion back' })
--

-- Additional pum.vim keymaps for enhanced completion navigation
vim.keymap.set('i', '<C-n>', '<Cmd>call pum#map#insert_relative(+1)<CR>', { desc = 'Next completion item' })
vim.keymap.set('i', '<C-p>', '<Cmd>call pum#map#insert_relative(-1)<CR>', { desc = 'Previous completion item' })
vim.keymap.set('i', '<C-y>', '<Cmd>call pum#map#confirm()<CR>', { desc = 'Confirm completion' })
vim.keymap.set('i', '<C-e>', '<Cmd>call pum#map#cancel()<CR>', { desc = 'Cancel completion' })
vim.keymap.set('i', '<PageDown>', '<Cmd>call pum#map#insert_relative_page(+1)<CR>', { desc = 'Next completion page' })
vim.keymap.set('i', '<PageUp>', '<Cmd>call pum#map#insert_relative_page(-1)<CR>', { desc = 'Previous completion page' })

