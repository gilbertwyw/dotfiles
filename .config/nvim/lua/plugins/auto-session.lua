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
      vim.keymap.set("n", "<LocalLeader>sa", "<cmd>SessionSave<CR>", opts)
      vim.keymap.set("n", "<LocalLeader>sd", "<cmd>SessionDelete<CR>", opts)
      vim.keymap.set("n", "<LocalLeader>ss", "<cmd>SessionSearch<CR>", opts)
    end
  }
}
