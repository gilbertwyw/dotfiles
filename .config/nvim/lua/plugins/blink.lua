return {
  {
    'saghen/blink.cmp',

    dependencies = 'rafamadriz/friendly-snippets',

    version = '1.*',

    -- https://cmp.saghen.dev/configuration/reference
    opts = {
      keymap = {
        preset = 'default',
        ['<c-m>'] = { 'show', 'show_documentation', 'hide_documentation' },
      },
    },

    opts_extend = { "sources.default" }
  },
}
