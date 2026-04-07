
local keymap = vim.keymap.set;
local s = { silent = true }
local opts = { noremap = true, silent = true }


-- leader key
vim.g.mapleader = " "



-- save with C-s
keymap( {'n','v','i'}, '<C-s>', function ()
        if vim.bo.modified then
            vim.cmd("write")
        end
    end,
    { desc = 'Write Changes' }
)

-- Change directory to the current file's directory
keymap("n", "<leader>cd", '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>')



-- split navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")


-- clear search highlight
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')


-- Stay in visual mode after indenting
keymap('v', '<', '<gv', { desc = 'Indent left and reselect' })
keymap('v', '>', '>gv', { desc = 'Indent right and reselect' })

keymap("v", "<leader>p", '"_dP') -- Paste without overwriting the default register


-- TODO: add global formating, lsp, goto def etc
keymap("n", "<leader>cf", ":lua vim.lsp.buf.format()<CR>", s) -- Format the current buffer using LSP

keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts) -- Go to definition

-- TODO: add vim.pack stuff
keymap("n", "<leader>ps", '<cmd>lua vim.pack.update()<CR>')
