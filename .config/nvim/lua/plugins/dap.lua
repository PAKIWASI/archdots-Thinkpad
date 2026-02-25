return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
        },

        keys = {
            { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
            { "<leader>dc", function() require("dap").continue() end,                                             desc = "Run/Continue" },
            { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
            { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
            { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
            { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
            { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
            { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
            { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
            { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
            { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
            { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
            { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
            { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
            { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
        },

        config = function()
            local dap = require("dap")

            -- Virtual Text
            require("nvim-dap-virtual-text").setup({
                virt_text_pos = 'eol',
            })

            -- Breakpoint Signs
            vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
            vim.fn.sign_define('DapStopped',
                { text = '▶', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = 'DapStopped' })

            vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#e51400' })
            vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#98c379' })
            vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#2e3440' })

            -- C/C++ Adapter
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
                    args = { "--port", "${port}" },
                },
            }

            local function get_path()
                local path = vim.fn.input("Path to exe: (root)/")
                if path == "" then
                    path = "build/main"
                end
                return vim.fn.getcwd() .. "/" .. path
            end

            -- C/C++ Configuration with ASan support
            dap.configurations.cpp = {
                {
                    name = "Launch",
                    type = "codelldb",
                    request = "launch",
                    program = get_path,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    -- ASan environment variables
                    env = {
                        -- Allow debugger to work with ASan
                        ASAN_OPTIONS = "detect_leaks=1:halt_on_error=0:abort_on_error=0",
                        LSAN_OPTIONS = "suppressions=" .. vim.fn.getcwd() .. "/lsan.supp",
                    },
                    -- Important for ASan debugging
                    initCommands = {
                        -- Handle ASan signals gracefully
                        "settings set target.process.stop-on-exec false",
                    },
                },
                {
                    name = "Launch (ASan - no halt)",
                    type = "codelldb",
                    request = "launch",
                    program = get_path,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    env = {
                        -- Continue execution after ASan error
                        ASAN_OPTIONS = "detect_leaks=1:halt_on_error=0:abort_on_error=0:log_path=" ..
                            vim.fn.getcwd() .. "/asan.log",
                        LSAN_OPTIONS = "suppressions=" .. vim.fn.getcwd() .. "/lsan.supp",
                    },
                    initCommands = {
                        "settings set target.process.stop-on-exec false",
                    },
                },
                {
                    name = "Launch (ASan - halt on error)",
                    type = "codelldb",
                    request = "launch",
                    program = get_path,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    env = {
                        -- Stop on ASan error for debugging
                        ASAN_OPTIONS = "detect_leaks=1:halt_on_error=1:abort_on_error=1",
                        LSAN_OPTIONS = "suppressions=" .. vim.fn.getcwd() .. "/lsan.supp",
                    },
                },
            }

            dap.configurations.c = dap.configurations.cpp


            dap.adapters.lldb = {
                type = "executable",
                command = "lldb-dap",
            }

            dap.configurations.rust = {
                {
                    name = "Launch",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        local path = vim.fn.input("Path to exe: (root)/")
                        if path == "" then
                            path = "target/debug/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
                        end
                        return vim.fn.getcwd() .. "/" .. path
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }
        end,
    },

    -- DAP UI
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        keys = {
            { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
            { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "x" } },
        },
        opts = {},
        config = function(_, opts)
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup(opts)

            -- Auto open/close
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open({})
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close({})
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close({})
            end
        end,
    },
}
