-- Colorscheme configuration
local default_colorscheme = "iceberg"
local reading_colorscheme = "lackluster"
local current_colorscheme = default_colorscheme

local function override_colorscheme()
  -- visual highlight override
  vim.cmd[[highlight Visual  ctermfg=158 ctermbg=29 guifg=#c0c5b9 guibg=#45493e]]
  vim.cmd[[hi PmenuSel blend=0 ]]
end

-- default
pcall(vim.cmd, "colorscheme " .. default_colorscheme)
override_colorscheme()

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
