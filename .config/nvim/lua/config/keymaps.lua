



-- commom write/quit
vim.keymap.set( {'n','v'},     '<leader>q',  '<cmd>q<CR>',  { desc = 'Quit Buffer'   } )
vim.keymap.set( {'n','v'},     '<leader>qq', '<cmd>q!<CR>', { desc = 'Force Quit'    } )
-- TODO: why does cursor fliker?
vim.keymap.set( {'n','v','i'}, '<C-s>', function ()
        if vim.bo.modified then
            vim.cmd("write")        -- probably cause of this
        end
    end,
    { desc = 'Write Changes' }
)


-- split
-- C-w v vertical
-- C-w s horizontal
-- C-w = equalize

-- split navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")


-- clear search highlight
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')



-- Stay in visual mode after indenting
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })


-- image show
vim.keymap.set("n", "<leader>bi", function()
    require("snacks").image.hover()
end, { desc = "Show image under cursor" })
