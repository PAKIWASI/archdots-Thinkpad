return {
    --[[
    -- fzf-lua : snacks picker backend
    {
        "ibhagwan/fzf-lua",
        event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            winopts = {
                border = "rounded",
                preview = {
                    layout = "vertical",
                    vertical = "up:60%",
                },
            },
        },
    },
    --]]

    -- grug-far : search and replace (uses ripgrep)
    {
        "MagicDuck/grug-far.nvim",
        event = "VeryLazy",
        opts = { headerMaxWidth = 80 },
        cmd = "GrugFar",
        keys = {
            {
                "<leader>sr",
                function()
                    local grug = require("grug-far")
                    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                    grug.open({
                        transient = true,
                        prefills = {
                            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                        },
                    })
                end,
                mode = { "n", "x" },
                desc = "Search and Replace",
            },
        },
    },


    -- color picker
    {
        "uga-rosa/ccc.nvim",
        event = "VeryLazy",
        config = function()
            require("ccc").setup({
                highlighter = {
                    auto_enable = true,
                    lsp = true,
                },
            })
            vim.keymap.set("n", "<leader>cp", "<cmd>CccPick<cr>", { desc = "Open Color Picker" })
        end,
    },

    -- mini pairs
    {
        "nvim-mini/mini.pairs",
        event = "VeryLazy",
        opts = {
            modes = { insert = true, command = true, terminal = false },
            -- skip autopair when next character is one of these
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            -- skip autopair when the cursor is inside these treesitter nodes
            skip_ts = { "string" },
            -- skip autopair when next character is closing pair
            -- and there are more closing pairs than opening pairs
            skip_unbalanced = true,
            -- better deal with markdown code blocks
            markdown = true,
        },
    },

    -- mini.move: Move lines/selections with Alt+hjkl
    {
        "nvim-mini/mini.move",
        event = "VeryLazy",
        version = "*",
        opts = {},
    },

    -- flash.nvim: Move like flash
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        vscode = true,
        opts = {},
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
            -- Simulate nvim-treesitter incremental selection
            {
                "<c-space>",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter({
                        actions = {
                            ["<c-space>"] = "next",
                            ["<BS>"] = "prev"
                        }
                    })
                end,
                desc = "Treesitter Incremental Selection"
            },
        },
    },

}
