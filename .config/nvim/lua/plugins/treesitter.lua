
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        auto_install = true,
        ensure_installed = {
            "c", "cpp", "lua",
            "python", "bash",
            "html", "css", "javascript", "json",
            "yaml", "toml", "markdown",
        },
        highlight = { enable = true, },
        indent = { enable = true, },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                node_decremental = "<bs>",
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
