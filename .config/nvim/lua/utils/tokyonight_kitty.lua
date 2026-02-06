
-- set the extracted kitty colors to tokyonight


local kitty = require("kitty_colors")

require("tokyonight").setup({
  style = "moon",

  on_colors = function(c)
    local k = kitty.read()
    if not k.background then return end

    -- Core backgrounds
    c.bg        = k.background
    c.bg_dark   = k.color0
    c.bg_float  = k.color0
    c.bg_popup  = k.color0
    c.bg_sidebar= k.background
    c.bg_statusline = k.background

    -- Foregrounds
    c.fg        = k.foreground
    c.fg_dark   = k.color7
    c.fg_gutter = k.color8

    -- Cursor / selection
    c.cursor    = k.cursor or k.color4
    c.selection = k.selection_background or k.color4

    -- Accents (Tokyo Night semantic roles)
    c.red       = k.color1
    c.orange    = k.color3
    c.yellow    = k.color3
    c.green     = k.color2
    c.cyan      = k.color6
    c.blue      = k.color4
    c.magenta   = k.color5

    -- Diagnostics
    c.error     = k.color1
    c.warning   = k.color3
    c.info      = k.color4
    c.hint      = k.color6

    -- Git
    c.git.add    = k.color2
    c.git.change = k.color4
    c.git.delete = k.color1

    -- Borders
    c.border    = k.inactive_border_color or k.color8
  end,
})

vim.cmd("colorscheme tokyonight")


