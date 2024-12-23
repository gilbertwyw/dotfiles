return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.tokyonight_style = "night"
      vim.g.tokyonight_sidebars = { "qf", "terminal" }

      vim.cmd [[colorscheme tokyonight]]
    end
  },
}
