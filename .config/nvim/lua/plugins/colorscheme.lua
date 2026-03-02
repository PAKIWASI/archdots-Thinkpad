-- return {
--     "folke/tokyonight.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         vim.cmd([[colorscheme tokyonight-moon]])
--     end,
-- }

-- return {
--     "Mofiqul/dracula.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function ()
--         vim.cmd([[colorscheme dracula]])
--     end
-- }


return {
    url = "https://codeberg.org/jthvai/lavender.nvim",
    branch = "stable", -- versioned tags + docs updates from main

    lazy = false,
    priority = 1000,

    config = function()
        vim.cmd([[colorscheme lavender]])
    end,
}
