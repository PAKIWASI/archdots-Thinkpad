return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd([[colorscheme tokyonight-moon]])
    end,
}

-- return {
--     "Mofiqul/dracula.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function ()
--         vim.cmd([[colorscheme dracula]])
--     end
-- }


-- TODO: make the util loading work.
-- currently copy-pasted everything here

-- return {
--     "folke/tokyonight.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         local theme_file = vim.fn.expand("~/.config/kitty/theme.conf")
--
--         local colors = {}
--         local f = io.open(theme_file, "r")
--         if not f then return colors end
--
--         for line in f:lines() do
--             local key, hex = line:match("^(%S+)%s+(#%x%x%x%x%x%x)")
--             if key and hex then
--                 colors[key] = hex
--             end
--         end
--
--         f:close()
--
--
--
--         require("tokyonight").setup({
--             style = "moon",
--
--             on_colors = function(c)
--                 local k = colors;
--                 if not k.background then return end
--
--                 -- Backgrounds
--                 c.bg        = k.background
--                 c.bg_dark   = k.color0
--                 c.bg_float  = k.color0
--                 c.bg_popup  = k.color0
--
--                 -- Foregrounds
--                 c.fg        = k.foreground
--                 c.fg_dark   = k.color7
--                 c.fg_gutter = k.color8
--
--                 -- Accents
--                 c.red       = k.color1
--                 c.orange    = k.color3
--                 c.yellow    = k.color3
--                 c.green     = k.color2
--                 c.cyan      = k.color6
--                 c.blue      = k.color4
--                 c.magenta   = k.color5
--
--                 -- Diagnostics
--                 c.error     = k.color1
--                 c.warning   = k.color3
--                 c.info      = k.color4
--                 c.hint      = k.color6
--
--                 -- Git
--                 c.git       = {
--                     add    = k.color2,
--                     change = k.color4,
--                     delete = k.color1,
--                 }
--
--                 -- Borders
--                 c.border    = k.inactive_border_color or k.color8
--             end,
--
--             -- on_highlights = function(hl, c)
--             --     -- Make floating window borders more visible
--             --     hl.FloatBorder = { fg = c.blue, bg = c.bg_float }
--             --     hl.WhichKeyBorder = { fg = c.blue }
--             --     hl.LazyGitBorder = { fg = c.cyan }
--             -- end
--         })
--
--         vim.cmd("colorscheme tokyonight")
--     end,
-- }
