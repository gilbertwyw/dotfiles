-- Defaults: https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua
local cmp = require 'cmp'
local lspkind = require 'lspkind'
local luasnip = require 'luasnip'

cmp.setup({
  sources = cmp.config.sources({
    -- order matters
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
    }),
  },
  -- default mapping: https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/mapping.lua
  mapping = cmp.mapping.preset.insert(),
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  experimental = {
    ghost_text = true,
  },
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

require("luasnip.loaders.from_vscode").lazy_load()
