local cache_path = vim.fn.stdpath("cache") .. "/dpp/repos/github.com"
local dppSrc = cache_path .. "/Shougo/dpp.vim"
local denopsSrc = cache_path .. "/vim-denops/denops.vim"

-- Add path to runtimepath
vim.opt.runtimepath:prepend(dppSrc)

-- check repository exists.
local function ensure_repo_exists(repo_url, dest_path)
    if not vim.loop.fs_stat(dest_path) then
        vim.fn.system({ "git", "clone", "https://github.com/" .. repo_url, dest_path })
    end
end

ensure_repo_exists("vim-denops/denops.vim.git", denopsSrc)
ensure_repo_exists("Shougo/dpp.vim.git", dppSrc)

local dpp = require("dpp")

local dppBase = vim.fn.stdpath("cache") .. "/dpp"
local dppConfig = "$HOME/.config/nvim-with-denops/dpp.ts"


-- option.
local extension_urls = {
    "Shougo/dpp-ext-installer.git",
    "Shougo/dpp-ext-toml.git",
    "Shougo/dpp-protocol-git.git",
    "Shougo/dpp-ext-lazy.git",
    "Shougo/dpp-ext-local.git",
}

-- Ensure each extension is installed and add to runtimepath
for _, url in ipairs(extension_urls) do
    local ext_path = cache_path .. "/" .. string.gsub(url, ".git", "")
    ensure_repo_exists(url, ext_path)
    vim.opt.runtimepath:append(ext_path)
end

-- vim.g.denops_server_addr = "127.0.0.1:41979"
-- vim.g["denops#debug"] = 1

if dpp.load_state(dppBase) then
    vim.opt.runtimepath:prepend(denopsSrc)
    vim.api.nvim_create_augroup("ddp", {})

    vim.api.nvim_create_autocmd("User", {
        pattern = "DenopsReady",
        callback = function()
            dpp.make_state(dppBase, dppConfig)
        end,
    })
end

vim.api.nvim_create_autocmd("User", {
    pattern = "Dpp:makeStatePost",
    callback = function()
        vim.notify("dpp make_state() is done")
    end,
})

--  多分これ追加したら動くようになった
if vim.fn["dpp#min#load_state"](dppBase) then
    vim.opt.runtimepath:prepend(denopsSrc)

    vim.api.nvim_create_autocmd("User", {
        pattern = "DenopsReady",
        callback = function()
            dpp.make_state(dppBase, dppConfig)
        end,
    })
end

vim.opt.termguicolors = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.syntax = on
vim.opt.number = true
vim.opt.encoding = "utf-8"
vim.opt.mouse = 'a'
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.list = true
vim.opt.listchars = {
    tab='-»',
    -- eol='↲',
    space = '·'
    --trail='-',
    --extends='»', 
    --precedes='«', 
    --nbsp='%',
}
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"

-- treesitter parser directory
-- local parser_dir = vim.fn.stdpath("data") .. "/treesitter-parsers"
-- vim.opt.runtimepath:append(parser_dir)

-- install
vim.api.nvim_create_user_command("DppInstall", "call dpp#async_ext_action('installer', 'install')", {})

-- update
vim.api.nvim_create_user_command("DppUpdate", function(opts)
    local args = opts.fargs
    vim.fn["dpp#async_ext_action"]("installer", "update", { names = args })
end, { nargs = "*" })


--fetch keyvim.api.nvim_set_keymap
local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

-- update leader key to space
vim.g.mapleader = " "
vim.cmd("filetype plugin indent on")

-- map('n', '<leader>f', '1z=', opts)
-- map('n', '<leader>s', ':set spell!<CR>', opts)
-- window resize
map('n', '<leader><', '5<c-w><', opts)
map('n', '<leader>>', '5<c-w>>', opts)

-- ESC to jk
map("i", "jk", "<ESC>", opts)

-- \C を付けた状態で検索開始
map('n', '<Leader>/', '/\\C', opts)
map('n', '<Leader>?', '?\\C', opts)

-- 最後の検索に \C を付け加えた状態で検索し直す
map('n', '<Leader>n', '/<Up>\\C<CR>', opts)
map('n', '<Leader>N', '?<Up>\\C<CR>', opts)


-- colorscheme
vim.cmd("set termguicolors")
vim.cmd("colorscheme tender")
vim.cmd("set cursorline")
vim.cmd("set cursorcolumn")
vim.opt.clipboard = 'unnamedplus' --クリップボードとレジスタを共有

-- clipboard
if vim.fn.has("wsl") == 1 then
    vim.g.clipboard = {
        name = "myClipboard",
        copy = {
            ["+"] = "win32yank.exe -i",
            ["*"] = "win32yank.exe -i",
        },
        paste = {
            ["+"] = "win32yank.exe -o",
            ["*"] = "win32yank.exe -o",
        },
        cache_enabled = 1,
    }
end

local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

-- telescope
map('n', 'gd', '<cmd>lua require"telescope.builtin".lsp_definitions()<CR>', opts)
-- or map('n', 'gd', '<cmd>lua vim.lsp.buf.definition() <CR>', opts)
map('n', 'gb', '<C-t>', opts)
map('n', 'gr', '<cmd>lua require"telescope.builtin".lsp_references()<CR>', opts)
map('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
map('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

-- fuzzy-finder
map('n', '<leader>ff', '<cmd>lua require"telescope.builtin".find_files()<CR>', { desc = 'Telescope find files' })
map('n', '<leader>fg', '<cmd>lua require"telescope.builtin".live_grep()<CR>', { desc = 'Telescope live grep' })
map('n', '<leader>fb', '<cmd>lua require"telescope.builtin".buffers()<CR>', { desc = 'Telescope buffers' })
map('n', '<leader>fh', '<cmd>lua require"telescope.builtin".help_tags()<CR>', { desc = 'Telescope help tags' })

-- https://gpanders.com/blog/whats-new-in-neovim-0-11/
vim.diagnostic.config({ virtual_text = true })

vim.lsp.enable('lua_ls')
vim.lsp.enable('marksman')
vim.lsp.enable({'vtsls', 'vue_ls'}) -- If using `ts_ls` replace `vtsls` to `ts_ls`

-- auto path rename
vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(event)
      if event.data.actions.type == "move" then
          Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
      end
  end,
})
