-- default
vim.cmd[[ colorscheme tender ]]

-- Colorscheme configuration
local default_colorscheme = "tender"
local reading_colorscheme = "lackluster"
local current_colorscheme = default_colorscheme

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
  end,
  { desc = "Toggle between " .. default_colorscheme .. " and " .. reading_colorscheme .. " colorschemes" }
)
