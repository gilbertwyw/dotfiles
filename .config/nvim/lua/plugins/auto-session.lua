return {
  {
    'rmagatti/auto-session',
    lazy = false,
    config = function()
      require("auto-session").setup {
        suppressed_dirs = { '~/', '~/Downloads', '/' },
      }

      local opts = {
        noremap = true,
      }
      -- couldn't use lazy's "key" because of lazy loading
      vim.keymap.set("n", "<LocalLeader>sa", "<cmd>AutoSession save<CR>", opts)
      vim.keymap.set("n", "<LocalLeader>sd", "<cmd>AutoSession delete<CR>", opts)
      vim.keymap.set("n", "<LocalLeader>ss", "<cmd>AutoSession search<CR>", opts)
    end
  }
}
