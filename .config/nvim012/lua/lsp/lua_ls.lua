
---@type vim.lsp.Config
return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
        'nvim-pack-lock.json',
        '.luarc.json',
        '.luarc.jsonc',
        '.luacheckrc',
        '.stylua.toml',
        'stylua.toml',
        '.git',
    },
    ---@type lspconfig.settings.lua_ls
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            completion = {
                enable = true,
            },
            diagnostics = {
                enable = true,
                globals = { "vim" },
            },
            workspace = {
                library = { vim.env.VIMRUNTIME },
                checkThirdParty = false,
            },
        },
    },
}
