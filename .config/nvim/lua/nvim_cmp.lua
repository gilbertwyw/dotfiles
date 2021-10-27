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

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
