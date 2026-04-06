return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    opts = { latex = { enabled = false } },
    keys = {
      {
        "<LocalLeader>tm",
        "<cmd>RenderMarkdown toggle<CR>",
        desc = "Toggle markdown rendering",
      },
      {
        "<LocalLeader>tp",
        "<cmd>RenderMarkdown preview<CR>",
        desc = "Toggle markdown preview",
      },
    },
  },
}
