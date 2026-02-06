-- Clangd LSP config
return {
    mason = false, -- we handle clangd manually
    cmd = {
        "clangd",
        "--enable-config",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--fallback-style=llvm",
        "--query-driver=/usr/bin/clang",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    capabilities = {
        offsetEncoding = { "utf-8", "utf-16" },
    },
    single_file_support = true,


    -- Use on_attach instead of keys
    on_attach = function(_, bufnr)
        local Win = {
            style = "terminal",
            position = "float",
            backdrop = 60,
            border = "rounded",
            width = 0.5,
            height = 0.7,
        }

        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end

        map('n', '<leader>ch', '<cmd>LspClangdSwitchSourceHeader<CR>', 'Switch Source/Header')

        map('n', '<leader>cc', function()
            local ft = vim.bo.filetype
            vim.ui.input({ prompt = "File Name/Class Name: " }, function(input)
                if input and input ~= "" then
                    if ft == "c" or ft == "h" then
                        Snacks.terminal("Cpair " .. input, { win = Win })
                    else
                        Snacks.terminal("CPPpair " .. input, { win = Win })
                    end
                end
            end)
        end, 'Create Source/Header File Pair')

        map('n', '<leader>cb', function()
            Snacks.terminal("ninja -C build; exec $SHELL", { win = Win })
        end, 'Build Project (Ninja)')

        map('n', '<leader>cx', function()
            Snacks.terminal("./build/main; exec $SHELL", { win = Win })
        end, 'Run Project')

        map('n', '<leader>cX', function()
            Snacks.terminal("ninja -C build && ./build/main; exec $SHELL", { win = Win })
        end, 'Build and Run')
    end,
}


