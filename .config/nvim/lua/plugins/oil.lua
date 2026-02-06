return {

    {
        "stevearc/oil.nvim",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            default_file_explorer = true,
            columns = { "git_status", "icon" },
            view_options = {
                show_hidden = true,
            },
            win_options = {
                signcolumn = "yes:2",
            },
            keymaps = {
                ["<CR>"] = {
                    callback = function()
                        local oil = require("oil")
                        local entry = oil.get_cursor_entry()
                        if entry and entry.type == "file" then
                            local dir = oil.get_current_dir()
                            local filepath = dir .. entry.name

                            for _, win in ipairs(vim.api.nvim_list_wins()) do
                                local buf = vim.api.nvim_win_get_buf(win)
                                local ft = vim.bo[buf].filetype
                                if ft ~= "oil" and ft ~= "image" then
                                    vim.api.nvim_set_current_win(win)
                                    vim.cmd("edit " .. vim.fn.fnameescape(filepath))
                                    return
                                end
                            end

                            vim.cmd("wincmd l")
                            if vim.bo.filetype == "oil" then
                                vim.cmd("vsplit")
                            end
                            vim.cmd("edit " .. vim.fn.fnameescape(filepath))
                        else
                            oil.select()
                        end
                    end,
                    desc = "Open file",
                },
            },
        },
        keys = {
            {
                "<leader>oo",
                function()
                    require("oil").open()
                end,
                desc = "Open cwd"
            },
            {
                "<leader>oO",
                function()
                    local root = require("utils.root").get()
                    require("oil").open(root)
                end,
                desc = "Open parent directory"
            },
            { "<leader>of", "<cmd>Oil --float<cr>", desc = "Oil (float) (cwd)" },
            {
                "<leader>oF",
                function()      -- TODO: how to fix ?
                    local root = require("utils.root").get()
                    require("oil").open(root .. "float")
                end,
                desc = "Oil (float) (Root)"
            },
            { "<leader>oq", "<cmd>bd<cr>",          desc = "Close Oil" },
            { "<leader>ow", "<cmd>w<cr>",           desc = "Write Changes" },
            {
                "<leader>E",
                function()
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        if vim.bo[buf].filetype == "oil" then
                            vim.api.nvim_win_close(win, false)
                            return
                        end
                    end
                    local root = require("utils.root").get()
                    vim.cmd("topleft vsplit")
                    vim.cmd("vertical resize 32")
                    vim.cmd("Oil " .. root)
                    vim.cmd("wincmd p")
                end,
                desc = "Toggle Oil sidebar (Parent Dir)",
            },
            {
                "<leader>e",
                function()
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        if vim.bo[buf].filetype == "oil" then
                            vim.api.nvim_win_close(win, false)
                            return
                        end
                    end
                    vim.cmd("topleft vsplit")
                    vim.cmd("vertical resize 32")
                    vim.cmd("Oil")
                    vim.cmd("wincmd p")
                end,
                desc = "Oil sidebar (cwd)",
            },
        },
    },
    -- TODO: how to modify symbols?
    {
        "FerretDetective/oil-git-signs.nvim",
        ft = "oil", -- lazy-load for oil buffers
        dependencies = { "stevearc/oil.nvim" },
        opts = {
            git_shell_cmd = {
                "git",
                "-c",
                "status.relativePaths=false",
                "status",
                "--short",
                "--untracked-files=all",
                "--ignored", -- Enable showing ignored files
            },
        },
    },
}
