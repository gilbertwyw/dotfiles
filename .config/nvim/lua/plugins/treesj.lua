return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesj').setup({
      use_default_keymaps = false,
    })
    vim.keymap.set('n', '<localLeader>ts', require('treesj').toggle, {
      desc = "Toggle between split and join",
    })
    vim.keymap.set('n', 'gJ', require('treesj').join, { desc = "Join" })
    vim.keymap.set('n', 'gS', require('treesj').split, { desc = "Split" })
  end,
}
