
local ensure_installed = {
    "c", "cpp", "lua", "jsx",
    "python", "bash", "typescript", "tsx",
    "html", "css", "javascript", "json",
    "yaml", "toml", "markdown", "regex",
}

-- install only missing parsers
local already_installed = require("nvim-treesitter.config").get_installed()
local to_install = vim.iter(ensure_installed)
    :filter(function(parser)
        return not vim.tbl_contains(already_installed, parser)
    end)
    :totable()

require("nvim-treesitter").install(to_install)

-- enable highlighting, indentation per filetype
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

-- incremental selection
vim.keymap.set("n", "<C-space>", function()
    require("nvim-treesitter.incremental_selection").init_selection()
end, { desc = "TS: Init selection" })

vim.keymap.set("x", "<C-space>", function()
    require("nvim-treesitter.incremental_selection").node_incremental()
end, { desc = "TS: Increment node" })

vim.keymap.set("x", "<bs>", function()
    require("nvim-treesitter.incremental_selection").node_decremental()
end, { desc = "TS: Decrement node" })
