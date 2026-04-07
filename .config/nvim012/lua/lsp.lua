
-- blink.cmp merges its own + neovim's default capabilities internally
local capabilities = require("blink.cmp").get_lsp_capabilities()


-- LspAttach fires every time ANY language server attaches to a buffer.
vim.api.nvim_create_autocmd("LspAttach", {

    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
    callback = function(ev)
        -- ev.buf  = the buffer the server attached to
        -- ev.data.client_id = the server that just attached
        -- local client = vim.lsp.get_client_by_id(ev.data.client_id)

        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
        end

        -- Navigation
        map("gd", vim.lsp.buf.definition, "Go to Definition")
        map("gD", vim.lsp.buf.declaration, "Go to Declaration")
        map("gr", vim.lsp.buf.references, "Go to References")
        map("gi", vim.lsp.buf.implementation, "Go to Implementation")
        map("gy", vim.lsp.buf.type_definition, "Go to Type Definition")

        -- Docs
        map("K", vim.lsp.buf.hover, "Hover Docs")

        -- Refactor
        map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("<leader>cf", vim.lsp.buf.format, "Format Buffer")

        -- disable formatting for servers you don't want formatting from.
        -- if client and client.name == "lua_ls" then
        --     client.server_capabilities.documentFormattingProvider = false
        -- end
    end,
})



local servers = {
    "lua_ls",
    -- "pyright",
    -- "ts_ls",
    -- "clangd",
}


for _, name in ipairs(servers) do
    -- reads your lsp/<name>.lua and merges capabilities into it
    local ok, user_config = pcall(require, "lsp." .. name)
    local config = ok and user_config or {}
    config.capabilities = capabilities

    vim.lsp.config(name, config)
    vim.lsp.enable(name)
end


-- Diagnostic display config.
vim.diagnostic.config({
    virtual_text = true,      -- inline error messages at end of line
    signs = true,             -- gutter icons (E/W/I/H)
    underline = true,         -- squiggly underline on the problem range
    update_in_insert = false, -- false means diagnostics don't update while you're typing,
    severity_sort = true,     -- errors shown above warnings in the gutter/float
})


