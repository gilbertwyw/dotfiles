-- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua
local cmp = require'cmp'
local lspkind = require('lspkind')

cmp.setup({
  sources = {
    -- order matters
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'ultisnips' },
    { name = 'vsnip' },
    { name = 'path' },
    -- TODO keyword_length option
    { name = 'buffer' },
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
    }),
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  experimental = {
    ghost_text = true,
  },
})



-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

