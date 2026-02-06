
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true    -- show line highlight at curr line

vim.o.termguicolors = true -- Better colors in terminal
--vim.api.nvim_set_hl(0, "LineNr", { fg = "#4CE471"})


vim.o.clipboard = "unnamedplus"

vim.o.wrap = false

vim.o.swapfile = false

vim.o.mouse = "nv" -- for nvim-dap

vim.o.winborder = "rounded"

vim.o.ignorecase = true -- while greping
vim.o.smartcase = true  -- unless I type upper case


vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.smarttab = true
vim.o.autoindent = true
vim.o.smartindent = true


vim.o.splitbelow = true
vim.o.splitright = true


vim.o.signcolumn = "yes" -- Always show sign column (prevents text shift)
vim.o.scrolloff = 8      -- Keep 8 lines visible above/below cursor
vim.o.sidescrolloff = 8  -- Same for horizontal scrolling
vim.o.updatetime = 250   -- Faster CursorHold events (for LSP)
vim.o.timeoutlen = 300   -- Faster key sequence completion

vim.o.hlsearch = true    -- Highlight search results
vim.o.incsearch = true   -- Show matches as you type

vim.o.undofile = true    -- Persistent undo history
vim.o.backup = false
vim.o.writebackup = false

vim.o.completeopt = "menu,menuone,noselect" -- Better completion experience
-- Enable native command-line completion
vim.o.wildmenu = true
vim.o.wildmode = 'longest:full,full' -- Complete longest common, then full
vim.o.wildoptions = 'pum'            -- Use popup menu for completion
vim.o.pumheight = 10                 -- Max 10 items in popup menu


vim.o.cmdheight = 0     -- in favor of lualine (autocmd sets this when I press :)


vim.filetype.add({ extension = { h = 'c' } })
