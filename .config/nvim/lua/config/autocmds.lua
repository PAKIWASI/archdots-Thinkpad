
-- indent width 2 for html, css
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "css" },
    callback = function()
        vim.bo.tabstop = 2
        vim.bo.shiftwidth = 2
        vim.bo.softtabstop = 2
    end,
    desc = "Indent 2 for HTML, CSS",
})


-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    desc = "Highlight on Yank",
})


-- Show cmdline when entering command mode
vim.api.nvim_create_autocmd("CmdlineEnter", {
    callback = function()
        vim.o.cmdheight = 1
    end,
    desc = "Show command line on command mode",
})
-- Hide cmdline when leaving command mode
vim.api.nvim_create_autocmd("CmdlineLeave", {
    callback = function()
        vim.o.cmdheight = 0
    end,
    desc = "Hide command line after command mode",
})


-- TODO: doesnot work ?
vim.api.nvim_create_autocmd("FileType", {
    pattern = 'h',
    callback = function()
        vim.cmd("setfiletype c")
        vim.bo.filetype = 'c'
    end,
    desc = "Treat .h as C files",
})

