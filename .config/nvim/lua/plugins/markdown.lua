return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    opts = {},
    lazy = false,
    keys = { { "<leader>tm", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle markdown rendering" } },
  },
}
