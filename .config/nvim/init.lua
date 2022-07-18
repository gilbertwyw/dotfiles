local o = vim.opt

o.colorcolumn:append('80')
o.cursorline = true

-- search
o.ignorecase = true
o.smartcase = true

-- do not redraw screen in the middle of a macro
o.lazyredraw = true

-- line number
o.number = true
o.relativenumber = true

--more intuitive split
o.splitbelow = true
o.splitright = true

o.swapfile = false

-- change the terminal's title
o.title = true

-- enable mouse in n,v,i,c modes
o.mouse = 'a'

o.clipboard:append('unnamed')

-- flashing instead of beeping
o.visualbell = true

-- indentation
-- use soft tab
o.expandtab = true
-- number of space to use for autoindenting
o.shiftwidth = 2
-- number of visual spaces per TAB
o.tabstop = 2

o.termguicolors = true

o.undofile = true

-- leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Autocommands
local grpopts = { clear = true }
local hlgroup = vim.api.nvim_create_augroup("highlight_on_yank", grpopts)
vim.api.nvim_create_autocmd('TextYankPost', {
  group = hlgroup,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 150, on_visual = true }
  end
})

local autosaveandreadgroup = vim.api.nvim_create_augroup("auto_save_and_read", grpopts)
vim.api.nvim_create_autocmd({ 'CursorHold' }, {
  group = autosaveandreadgroup,
  pattern = '*',
  callback = function()
    vim.cmd 'silent! checktime'
  end
})
vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave', 'FocusLost' }, {
  group = autosaveandreadgroup,
  pattern = '*',
  callback = function()
    vim.cmd 'silent! wall'
  end
})

require('mappings')
require('plugins')
