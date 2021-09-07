-- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua
local cmp = require'cmp'
cmp.setup({
  sources = {
    { name = 'buffer' }, 
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'ultisnips' },
    { name = 'vsnip' },
  }
})

