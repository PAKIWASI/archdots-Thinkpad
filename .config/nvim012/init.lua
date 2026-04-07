

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.signcolumn = "yes:1"    -- Always show sign column
opt.termguicolors = true    -- Enable true colors
opt.ignorecase = true       -- Ignore case in search
opt.smartcase = true

opt.swapfile = false        -- Disable swap files
opt.backup = false
opt.writebackup = false

opt.clipboard = "unnamedplus"
opt.mouse = ""

opt.autoindent = true       -- Enable auto indentation
-- opt.smartindent = true
opt.expandtab = true        -- Use spaces instead of tabs
opt.smarttab = true
opt.tabstop = 4             -- Number of spaces for a tab
opt.softtabstop = 4         -- Number of spaces for a tab when editing

opt.shiftwidth = 4          -- Number of spaces for autoindent
opt.shiftround = true       -- Round indent to multiple of shiftwidth

opt.list = true             -- Show whitespace characters
opt.number = true           -- Show line numbers
opt.relativenumber = true   -- Show relative line numbers
opt.numberwidth = 2         -- Width of the line number column

opt.wrap = false            -- Disable line wrapping
opt.cursorline = true       -- Highlight the current line
opt.scrolloff = 8           -- Keep 8 lines above and below the cursor

opt.inccommand = "nosplit"  -- Shows the effects of a command incrementally in the buffer

opt.undodir = os.getenv('HOME') .. '/.nvim012/undodir'  -- Directory for undo files
opt.undofile = true         -- Enable persistent undo

opt.completeopt = { "menu", "menuone", "popup", "noinsert" }    -- Options for completion menu
opt.winborder = "rounded"   -- Use rounded borders for windows
opt.hlsearch = true        -- Disable highlighting of search results
vim.o.incsearch = true   -- Show matches as you type

opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildoptions = "pum"
opt.pumheight = 10


vim.cmd.filetype("plugin indent on") -- Enable filetype detection, plugins, and indentation


