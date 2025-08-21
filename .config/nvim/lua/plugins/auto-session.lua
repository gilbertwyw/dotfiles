return {
  {
    'rmagatti/auto-session',
    lazy = false,
    config = function()
      require("auto-session").setup {
        suppressed_dirs = { '~/', '~/Downloads', '/' },
      }

      -- couldn't use lazy's "key" because of lazy loading
      vim.keymap.set("n", "<LocalLeader>s", "<cmd>SessionSearch<CR>", {
        noremap = true,
      })
    end
  }
}
