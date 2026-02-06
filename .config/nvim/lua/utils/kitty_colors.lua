
-- extract kitty colors from kitty/theme.conf (dynamically set)
-- and return a table of foreground -> color


local M = {}

local theme_file = vim.fn.expand("~/.config/kitty/theme.conf")

function M.read()

  local colors = {}
  local f = io.open(theme_file, "r")
  if not f then return colors end

  for line in f:lines() do
    local key, hex = line:match("^(%S+)%s+(#%x%x%x%x%x%x)")
    if key and hex then
      colors[key] = hex
    end
  end

  f:close()
  return colors
end


return M
