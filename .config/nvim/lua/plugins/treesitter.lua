return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    main = "nvim-treesitter",
    init = function()
        -- Install parsers that aren't already installed
        local ensureInstalled = {
            "c", "cpp", "lua", "jsx",
            "python", "bash", "typescript", "tsx",
            "html", "css", "javascript", "json",
            "yaml", "toml", "markdown", "regex",
        }
        local alreadyInstalled = require("nvim-treesitter.config").get_installed()
        local parsersToInstall = vim.iter(ensureInstalled)
            :filter(function(parser)
                return not vim.tbl_contains(alreadyInstalled, parser)
            end)
            :totable()
        require("nvim-treesitter").install(parsersToInstall)

        -- Enable highlighting, indentation, and incremental selection per filetype
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                -- Highlighting (and disable slow regex syntax)
                pcall(vim.treesitter.start)
                -- Indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })

        -- Incremental selection keymaps
        vim.keymap.set("n", "<C-space>", function()
            require("nvim-treesitter.incremental_selection").init_selection()
        end, { desc = "TS: Init selection" })
        vim.keymap.set("x", "<C-space>", function()
            require("nvim-treesitter.incremental_selection").node_incremental()
        end, { desc = "TS: Increment node" })
        vim.keymap.set("x", "<bs>", function()
            require("nvim-treesitter.incremental_selection").node_decremental()
        end, { desc = "TS: Decrement node" })
    end,
}


