-- Options configuration file
-- Define Neovim options and behavior

local opt       = vim.opt
local g         = vim.g
local o         = vim.o

-----------------
-- General
-----------------
opt.mouse       = 'a'           -- Enable mouse support
o.mouse         = 'a'           -- Enable mouse support
opt.clipboard   = 'unnamedplus' -- Copy/paste to system clipboard

opt.lazyredraw  = true          --
opt.redrawtime  = 1500          --
opt.timeoutlen  = 500           -- -- Performance Improvements
opt.updatetime  = 250           --
opt.synmaxcol   = 240           --
opt.tabstop     = 4             -- insert 4 spaces for a tab
opt.expandtab   = true
opt.shiftwidth  = 4             -- the number of spaces inserted for each indentation
opt.softtabstop = 4             -- number of spaces to use for each step of (auto)indent
opt.scrolloff   = 8
opt.splitbelow  = true          -- Setup split behavior
opt.splitright  = true          -- Setup split behavior

o.hlsearch      = false         -- Set highlight on search
o.number        = true          -- Make line numbers default
o.breakindent   = true          -- Enable break indent
o.undofile      = true          -- Save undo history
o.ignorecase    = true          -- Case insensitive searching UNLESS /C or capital in search
o.smartcase     = true          -- Case insensitive searching UNLESS /C or capital in search
o.updatetime    = 250           -- Decrease update time
o.signcolumn    = 'yes'         -- Decrease update time


-- opt.swapfile = false          -- Don't use swapfile
-- opt.completeopt = 'menuone,noselect'  -- Autocomplete options
--
-- -----------------
-- -- Neovim UI
-- -----------------
-- opt.number = true             -- Show line numbers
-- opt.relativenumber = true     -- Relative line numbers
-- opt.showmatch = true         -- Highlight matching parenthesis
-- opt.foldmethod = 'marker'     -- Enable folding (default 'foldmarker')
-- opt.colorcolumn = '80'        -- Line length marker at 80 columns
-- opt.splitright = true         -- Vertical split to the right
-- opt.splitbelow = true         -- Horizontal split to the bottom
-- opt.ignorecase = true         -- Ignore case letters when search
-- opt.smartcase = true          -- Ignore lowercase for the whole pattern
-- opt.linebreak = true          -- Wrap on word boundary
-- opt.termguicolors = true      -- Enable 24-bit RGB colors
-- opt.laststatus = 3            -- Set global statusline
--
-- -----------------
-- -- Tabs, indent
-- -----------------
-- opt.expandtab = true          -- Use spaces instead of tabs
-- opt.shiftwidth = 4            -- Shift 4 spaces when tab
-- opt.tabstop = 4               -- 1 tab == 4 spaces
-- opt.smartindent = true        -- Autoindent new lines
--
-- -----------------
-- -- Memory, CPU
-- -----------------
-- opt.hidden = true             -- Enable background buffers
-- opt.history = 100             -- Remember N lines in history
-- opt.lazyredraw = true         -- Faster scrolling
-- opt.synmaxcol = 240          -- Max column for syntax highlight
-- opt.updatetime = 250         -- ms to wait for trigger an event
--
-- -----------------
-- -- Startup
-- -----------------
-- -- Disable nvim intro
-- opt.shortmess:append "sI"
--
-- -- -- Disable builtin plugins
-- local disabled_built_ins = {
--     "2html_plugin",
--     "getscript",
--     "getscriptPlugin",
--     "gzip",
--     "logipat",
--     "netrw",
--     "netrwPlugin",
--     "netrwSettings",
--     "netrwFileHandlers",
--     "matchit",
--     "tar",
--     "tarPlugin",
--     "rrhelper",
--     "spellfile_plugin",
--     "vimball",
--     "vimballPlugin",
--     "zip",
--     "zipPlugin",
--     "tutor",
--     "rplugin",
--     "syntax",
--     "synmenu",
--     "optwin",
--     "compiler",
--     "bugreport",
--     "ftplugin",
-- }
--
-- for _, plugin in pairs(disabled_built_ins) do
--     g["loaded_" .. plugin] = 1
-- end
--
