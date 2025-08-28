local home_dir = os.getenv("HOME")
local win32yank_exe_path = home_dir .. "/.local/bin/win32yank.exe"

-- clipboard
if vim.fn.has('wsl') == 1 then
    vim.g.clipboard = {
        name = 'myClipboard',
        copy = {
            ['+'] = win32yank_exe_path .. ' -i',
            ['*'] = win32yank_exe_path .. ' -i',
        },
        paste = {
            ['+'] = win32yank_exe_path .. ' -o',
            ['*'] = win32yank_exe_path .. ' -o',
        },
        cache_enabled = 1,
    }
end
vim.opt.clipboard = 'unnamedplus'
