-- Colorscheme configuration
local default_colorscheme = "lackluster"
local reading_colorscheme = "iceberg"
local current_colorscheme = default_colorscheme

local function override_colorscheme()
  -- visual mode highlight override (yellow color)
  vim.cmd[[highlight Visual  ctermfg=158 ctermbg=29 guifg=#c0c5b9 guibg=#45493e ]]
end

-- コメント中の特定の単語を強調表示する関数
local function setup_todo_highlights()
  local augroup = vim.api.nvim_create_augroup("HilightsForce", { clear = true })
  
  -- 各キーワード用のハイライトグループを定義
  vim.cmd[[highlight TodoKeyword guibg=#FF6B6B guifg=White]]  -- 赤系 (TODO用)
  vim.cmd[[highlight InfoKeyword guibg=#40BA8D guifg=White]]  -- 緑系 (INFO用)
  vim.cmd[[highlight NoteKeyword guibg=NONE guifg=#45B7D1]]  -- 青系 (NOTE用)
  vim.cmd[[highlight TempKeyword guibg=#FFA726 guifg=White]]  -- オレンジ系 (TEMP用)
  vim.cmd[[highlight FIXMEKeyword guibg=NONE guifg=#FFC800]]   -- 黄色系(FIXME用)
  
  vim.api.nvim_create_autocmd(
    { "WinEnter", "BufRead", "BufNew", "Syntax" },
    {
      group = augroup,
      callback = function()
        -- 各キーワードを個別にハイライト
        pcall(vim.fn.matchadd, 'TodoKeyword', 'TODO')
        pcall(vim.fn.matchadd, 'InfoKeyword', 'INFO')
        pcall(vim.fn.matchadd, 'NoteKeyword', 'NOTE')
        pcall(vim.fn.matchadd, 'TempKeyword', 'TEMP')
        pcall(vim.fn.matchadd, 'FIXMEKeyword', 'FIXME')
      end,
    }
  )
end

-- default
pcall(vim.cmd, "colorscheme " .. default_colorscheme)
override_colorscheme()

-- TODO/NOTE/INFO ハイライトを設定
setup_todo_highlights()

-- Toggle between default and reading colorschemes
vim.api.nvim_create_user_command(
  "ToggleCol",
  function()
    if current_colorscheme == default_colorscheme then
      local success, _ = pcall(vim.cmd, "colorscheme " .. reading_colorscheme)
      if success then
        current_colorscheme = reading_colorscheme
        print("Switched to reading colorscheme: " .. reading_colorscheme)
      else
        print("Error: '" .. reading_colorscheme .. "' colorscheme not found")
      end
    else
      local success, _ = pcall(vim.cmd, "colorscheme " .. default_colorscheme)
      if success then
        current_colorscheme = default_colorscheme
        print("Restored default colorscheme: " .. default_colorscheme)
      else
        print("Error: '" .. default_colorscheme .. "' colorscheme not found")
      end
    end
    override_colorscheme()
    -- カラースキーム変更後もTODOハイライトを再適用
    setup_todo_highlights()
  end,
  { desc = "Toggle between " .. default_colorscheme .. " and " .. reading_colorscheme .. " colorschemes" }
)

-- wip
--vim.api.nvim_create_user_command(
--  "ToggleVimOpacity",
--  function()
--    vim.cmd[[highlight Normal ctermbg=NONE guibg=NONE ]]
--    vim.cmd[[highlight NonText ctermbg=NONE guibg=NONE ]]
--    vim.cmd[[highlight LineNr ctermbg=NONE guibg=NONE ]]
--    vim.cmd[[highlight Folded ctermbg=NONE guibg=NONE ]]
--    vim.cmd[[highlight EndOfBuffer ctermbg=none guibg=NONE ]]
--  end,
--  { desc = "Toggle vim opacity" }
--)
