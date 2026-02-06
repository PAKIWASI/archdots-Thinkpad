return {
    "folke/snacks.nvim",
    event = "VimEnter",

    keys = {
        -- Top Pickers & Explorer
        { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
        { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
        { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
        -- find
        { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
        { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        { "<leader>ff",      function() Snacks.picker.files({ cwd = require("utils.root").get()})end,desc = "Find Files (Root)" },
        { "<leader>fF",      function() Snacks.picker.files({ cwd = "~"})end,                        desc = "Find Files (Home)" },
        { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
        { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
        { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },
        -- git
        { "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
        { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
        { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
        { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
        { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
        { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
        { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
        -- gh
        { "<leader>gi",      function() Snacks.picker.gh_issue() end,                                desc = "GitHub Issues (open)" },
        { "<leader>gI",      function() Snacks.picker.gh_issue({ state = "all" }) end,               desc = "GitHub Issues (all)" },
        { "<leader>gp",      function() Snacks.picker.gh_pr() end,                                   desc = "GitHub Pull Requests (open)" },
        { "<leader>gP",      function() Snacks.picker.gh_pr({ state = "all" }) end,                  desc = "GitHub Pull Requests (all)" },
        -- Grep
        { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
        { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
        { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
        { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word",   mode = { "n", "x" } },
        -- search
        { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
        { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
        { "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
        { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
        { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
        { "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "Commands" },
        { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
        { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
        { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
        { "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
        { "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "Icons" },
        { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
        { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
        { "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "Location List" },
        { "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },
        { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
        { "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
        { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
        { "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "Resume" },
        { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
        { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
        -- LSP
        { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
        { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
        { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true, desc = "References" },
        { "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
        { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
        { "gai",             function() Snacks.picker.lsp_incoming_calls() end,                      desc = "C[a]lls Incoming" },
        { "gao",             function() Snacks.picker.lsp_outgoing_calls() end,                      desc = "C[a]lls Outgoing" },
        { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
        { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
        -- Other
        { "<leader>uz",      function() Snacks.zen() end,                                            desc = "Toggle Zen Mode" },
        { "<leader>uZ",      function() Snacks.zen.zoom() end,                                       desc = "Toggle Zoom" },
        --{ "<leader>u.",      function() Snacks.scratch() end,                                                      desc = "Toggle Scratch Buffer" },
        --{ "<leader>uS",      function() Snacks.scratch.select() end,                                               desc = "Select Scratch Buffer" },
        { "<leader>un",      function() Snacks.picker.notifications() end,                           desc = "Notification History" },
        { "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
        { "<leader>bR",      function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
        { "<leader>gB",      function() Snacks.gitbrowse() end,                                      desc = "Git Browse",                 mode = { "n", "v" } },
        { "<leader>gg",      function() Snacks.lazygit() end,                                        desc = "Lazygit" },
        { "<leader>uN",      function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
        { "]]",              function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",             mode = { "n", "t" } },
        { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",             mode = { "n", "t" } },
        {
            "<leader>bt",
            function()
                Snacks.terminal(nil, {
                    cwd = vim.fn.expand('%:p:h'),  -- Directory of current file
                    win = { position = "bottom", height = 0.5 } })
            end,
            desc = "Terminal (bottom) cwd"
        },
        {
            "<leader>bT",
            function()
                Snacks.terminal(nil, {
                    cwd = require("utils.root").get(),
                    win = { position = "bottom", height = 0.5 }
            })
            end,
            desc = "Terminal (bottom) root"
        },
        {
            "<leader>ft",
            function()
                Snacks.terminal(nil, {
                    cwd = vim.fn.expand('%:p:h'),  -- Directory of current file
                    win = { style = "terminal", position = "float", backdrop = 60, border = "rounded", width = 0.5, height = 0.7 }
                })
            end,
            desc = "Toggle Floating Terminal (cwd)"
        },
        {
            "<leader>fT",
            function()
                Snacks.terminal(nil, {
                    cwd = require("utils.root").get(),
                    win = { style = "terminal", position = "float", backdrop = 60, border = "rounded", width = 0.5, height = 0.7 }
                })
            end,
            desc = "Toggle Floating Terminal (Root)"
        }
    },


    config = function(_, opts)
        require("snacks").setup(opts)
        vim.notify = Snacks.notifier
    end,


    opts = {
        picker = {
            enabled = true,
            --TODO: what is default backend?
            --backend = "fzfLua",
        },
        image = {
            enabled = true,
        },
        notifier = { enabled = true },
        words = { enabled = true },
        bigfile = { enabled = true },
        indent = { enabled = true },
        scroll = { enabled = true },
        input = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        statuscolumn = { enabled = true },
        lazygit = { enabled = true },
        dashboard = {
            preset = {
                keys = {
                    {
                        key = "f",
                        desc = "Find File",
                        icon = " ",
                        action = function() Snacks.picker.smart() end
                    },
                    {
                        key = "n",
                        desc = "New File",
                        icon = " ",
                        action = function() vim.cmd("ene | startinsert") end
                    },
                    {
                        key = "g",
                        desc = "Find Text",
                        icon = " ",
                        action = function() Snacks.picker.grep() end
                    },
                    {
                        key = "r",
                        desc = "Recent Files",
                        icon = " ",
                        action = function() Snacks.picker.recent() end
                    },
                    {
                        key = "p",
                        desc = "Projects",
                        icon = " ",
                        action = function() Snacks.picker.projects() end
                    },
                    {
                        key = "c",
                        desc = "Config",
                        icon = " ",
                        action = function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end
                    },
                    {
                        key = "l",
                        desc = "Lazy",
                        icon = "󰒲 ",
                        action = function() vim.cmd("Lazy") end
                    },
                    {
                        key = "m",
                        desc = "Mason",
                        icon = " ",
                        action = function() vim.cmd("Mason") end
                    },
                    {
                        key = "q",
                        desc = "Quit",
                        icon = " ",
                        action = function() vim.cmd("qa") end
                    },
                },
                header = [[
        █     █░ ▄▄▄        ██████  ██▓ ██▒   █▓ ██▓ ███▄ ▄███▓
        ▓█░ █ ░█░▒████▄    ▒██    ▒ ▓██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
        ▒█░ █ ░█ ▒██  ▀█▄  ░ ▓██▄   ▒██▒ ▓██  █▒░▒██▒▓██    ▓██░
        ░█░ █ ░█ ░██▄▄▄▄██   ▒   ██▒░██░  ▒██ █░░░██░▒██    ▒██
        ░░██▒██▓  ▓█   ▓██▒▒██████▒▒░██░   ▒▀█░  ░██░▒██▒   ░██▒
        ░ ▓░▒ ▒   ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░░▓     ░ ▐░  ░▓  ░ ▒░   ░  ░
        ▒ ░ ░    ▒   ▒▒ ░░ ░▒  ░ ░ ▒ ░   ░ ░░   ▒ ░░  ░      ░
        ░   ░    ░   ▒   ░  ░  ░   ▒ ░     ░░   ▒ ░░      ░
            ░          ░  ░      ░   ░        ░   ░         ░
                                            ░
                ]],
            },
            sections = {
                { section = "header" },
                --[[{
                    section = "terminal",
                    cmd = "rand_img",
                    height = 10,
                    padding = 1,
                },--]]
                { section = "keys",   gap = 1, padding = 1 },
                { section = "startup" },
            }
        }
    }
}


