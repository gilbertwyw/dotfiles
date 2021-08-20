require'nvim-treesitter.configs'.setup {
  -- https://github.com/nvim-treesitter/nvim-treesitter#modules
  ensure_installed = {
    "bash",
    "css",
    "go",
    "hcl",
    "html",
    "javascript",
    "json",
    "python",
    "typescript",
    "vim",
    "yaml",
  },
  highlight = {
    enable = true,
  },
}
