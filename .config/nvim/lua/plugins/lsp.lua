return {
    -- Mason for LSP server management
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = " ",
                        package_pending = " ",
                        package_uninstalled = " "
                    }
                }
            })
        end,
    },

    -- Bridge between Mason and native LSP
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim' },
    },

    -- Completion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
        },
        config = function()
            local cmp = require('cmp')

            cmp.setup({
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },
                mapping = cmp.mapping.preset.insert({
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'path' },
                }),
                window = {
                    completion = {
                        border = 'rounded',
                        winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
                    },
                    documentation = {
                        border = 'rounded',
                        winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
                    },
                },
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.menu = ({
                            nvim_lsp = '[LSP]',
                            buffer = '[Buffer]',
                            path = '[Path]',
                        })[entry.source.name]
                        return vim_item
                    end,
                },
            })
        end,
    },

    -- Native LSP Configuration
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            -- Diagnostic configuration
            vim.diagnostic.config({
                --virtual_text = true,
                virtual_text = {
                    prefix = function(diagnostic)
                        local icons = {
                            [vim.diagnostic.severity.ERROR] = '✘',
                            [vim.diagnostic.severity.WARN] = '●',
                            [vim.diagnostic.severity.HINT] = '⚑',
                            [vim.diagnostic.severity.INFO] = '»',
                        }
                        return icons[diagnostic.severity] or '●'
                    end,
                },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = "if_many",
                },
            })

            -- Diagnostic signs
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            -- Enhanced capabilities with nvim-cmp
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- On attach function
            local on_attach = function(client, bufnr)
                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
                end

                -- LSP keybindings (LazyVim style)
                map('n', 'gd', function() require('trouble').toggle('lsp_definitions') end, 'Goto Definition')
                map('n', 'gr', function() require('trouble').toggle('lsp_references') end, 'References')
                map('n', 'gI', function() require('trouble').toggle('lsp_implementations') end, 'Goto Implementation')
                map('n', 'gy', function() require('trouble').toggle('lsp_type_definitions') end, 'Goto Type Definition')
                map('n', 'gD', vim.lsp.buf.declaration, 'Goto Declaration')

                map('n', 'K', vim.lsp.buf.hover, 'Hover')
                map({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, 'Signature Help')

                -- Code actions
                map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code Action')
                map('n', '<leader>cA', function()
                    vim.lsp.buf.code_action({
                        context = {
                            only = { 'source' },
                            diagnostics = {},
                        },
                    })
                end, 'Source Action')

                -- Rename
                map('n', '<leader>cr', vim.lsp.buf.rename, 'Rename')

                -- Format
                map({ 'n', 'v' }, '<leader>cf', function()
                    vim.lsp.buf.format({ async = true })
                end, 'Format')

                -- Diagnostics with vim.diagnostic.jump
                map('n', '<leader>cd', vim.diagnostic.open_float, 'Line Diagnostics')
                map('n', '<leader>cj', function()
                    vim.diagnostic.jump({ count = 1, float = true })
                end, 'Next Diagnostic')
                map('n', '<leader>ck', function()
                    vim.diagnostic.jump({ count = -1, float = true })
                end, 'Prev Diagnostic')
                map('n', ']e', function()
                    vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
                end, 'Next Error')
                map('n', '[e', function()
                    vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
                end, 'Prev Error')
                map('n', ']w', function()
                    vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN })
                end, 'Next Warning')
                map('n', '[w', function()
                    vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN })
                end, 'Prev Warning')


                -- Highlight symbol under cursor
                if client.supports_method("textDocument/documentHighlight") then
                    local highlight_group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
                    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = highlight_group })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = bufnr,
                        group = highlight_group,
                        callback = vim.lsp.buf.document_highlight,
                    })
                    vim.api.nvim_create_autocmd("CursorMoved", {
                        buffer = bufnr,
                        group = highlight_group,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end


            -- Set default config for all servers
            vim.lsp.config('*', {
                capabilities = capabilities,
            })

            -- Load individual server configs from lsp/ directory
            local lsp_dir = vim.fn.stdpath("config") .. "/lua/lsp"

            -- Check if directory exists
            if vim.fn.isdirectory(lsp_dir) == 1 then
                local handle = vim.loop.fs_scandir(lsp_dir)
                if handle then
                    while true do
                        local name, type = vim.loop.fs_scandir_next(handle)
                        if not name then break end
                        if type == 'file' and name:match('%.lua$') then
                            local server_name = name:gsub("%.lua$", "")
                            local ok, server_config = pcall(require, "lsp." .. server_name)
                            if ok then
                                -- Get default config
                                local default_config = vim.lsp.config[server_name] or {}

                                -- get default on_attach
                                local default_on_attach = default_config.on_attach

                                -- Store server-specific on_attach separately
                                local server_on_attach = server_config.on_attach

                                -- Merge custom config with default config and capabilities
                                local merged_config = vim.tbl_deep_extend('force', {
                                    capabilities = capabilities,
                                }, default_config, server_config)

                                -- Create combined on_attach if server has one
                                if server_on_attach then
                                    merged_config.on_attach = function(client, bufnr)
                                        -- Call global on_attach first
                                        on_attach(client, bufnr)
                                        -- Call default on_attach
                                        default_on_attach(client, bufnr)
                                        -- Call server-specific on_attach
                                        server_on_attach(client, bufnr)
                                    end
                                else
                                    merged_config.on_attach = on_attach
                                end

                                -- Set the merged config
                                vim.lsp.config[server_name] = merged_config
                            end
                        end
                    end
                end
            end


            -- Mason LSPConfig setup
            local mason_lspconfig = require('mason-lspconfig')

            -- Ensure these servers are installed
            mason_lspconfig.setup({
                ensure_installed = {
                    'lua_ls',
                    'pyright',
                    'ts_ls',
                    --'codelldb', -- only via mason
                    --'html',
                    --'cssls',
                },
            })


            -- Enable LSP servers (all from ensure_installed)
            vim.lsp.enable({
                'lua_ls',
                'clangd', --mason = false
                'pyright',
                'ts_ls',
            })
        end,
    },

    -- Trouble for better diagnostics UI
    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        cmd = 'Trouble',
        opts = {
            auto_close = true,
            auto_open = false,
            auto_preview = true,
            auto_fold = false,
            use_diagnostic_signs = true,
        },
        keys = {
            {
                '<leader>xx',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            },
            {
                '<leader>xX',
                '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                desc = 'Buffer Diagnostics (Trouble)',
            },
            {
                '<leader>cs',
                '<cmd>Trouble symbols toggle focus=false<cr>',
                desc = 'Symbols (Trouble)',
            },
            {
                '<leader>cS',
                '<cmd>Trouble lsp_document_symbols toggle focus=false<cr>',
                desc = 'Document Symbols (Trouble)',
            },
            {
                '<leader>cl',
                '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
                desc = 'LSP Definitions / references / ... (Trouble)',
            },
            {
                '<leader>xL',
                '<cmd>Trouble loclist toggle<cr>',
                desc = 'Location List (Trouble)',
            },

            {
                '<leader>xQ',
                '<cmd>Trouble qflist toggle<cr>',
                desc = 'Quickfix List (Trouble)',
            },
        },
    },
}



