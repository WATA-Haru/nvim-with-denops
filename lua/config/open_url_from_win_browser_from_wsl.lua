-- 事前準備
-- 1. .gitignoreに`.env*`を追加
-- 2. .env.win_browserを作成
-- 3. 中身を BROWSER_PATH_ON_WINDOWS=/mnt/c/Users/your-browser-path.exe に設定

-- .envファイルを読み込む関数
local function load_env_file()
  -- Info: nvimのconfigの直下に/.env.win_browserを作っておく必要がある
  local config_dir = vim.fn.stdpath('config')
  
  -- .env.win_browserの読み込み
  local env_file = config_dir .. '/.env.win_browser'
  
  if vim.fn.filereadable(env_file) == 1 then
    for line in io.lines(env_file) do
      -- コメント行と空行をスキップ
      if line:match('^%s*[^#]') then
        local key, value = line:match('^([^=]+)=(.*)$')
        if key and value then
          -- 前後の空白を削除
          key = key:gsub('^%s*(.-)%s*$', '%1')
          value = value:gsub('^%s*(.-)%s*$', '%1')
          
          -- BROWSER_PATH_ON_WINDOWSのみを読み込む
          if key == 'BROWSER_PATH_ON_WINDOWS' then
            vim.env[key] = value
          end
        end
      end
    end
  end
end

-- .envファイルを読み込み
load_env_file()

-- WSL環境でWindows側のBraveブラウザを使用する設定
if vim.fn.has('wsl') == 1 then
  -- vim.ui.openのデフォルト動作をオーバーライド
  local original_open = vim.ui.open
  vim.ui.open = function(path, opts)
    opts = opts or {}
    
    -- http or httpsの場合はWindows側のBraveで開く
    if path:match('^https?://') then
      local browser_path = vim.env.BROWSER_PATH_ON_WINDOWS
      if browser_path and vim.fn.executable(browser_path) == 1 then
        opts.cmd = { browser_path }
      else
        vim.notify('Browser path not found or not executable: ' .. (browser_path or 'nil'), vim.log.levels.WARN)
      end
    end
    
    return original_open(path, opts)
  end
end

-- gxキーマップの設定（URLをBraveで開く）
vim.keymap.set('n', 'gx', function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  
  -- カーソル位置からhttp or httpsのURLを抽出
  local url = line:match('https?://[%w%.%-_~:/?#%[%]@!$&\'%(%)%*%+,;=]+')
  
  if url then
    vim.ui.open(url)
  else
    -- URLが見つからない場合は元のgxの動作
    -- gxはローカルのファイルや他のプロトコルも開くので、そのままにしておく
    vim.cmd('normal! gx')
  end
end, { desc = 'Open URL under cursor with Brave browser' })
