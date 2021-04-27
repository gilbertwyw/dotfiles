require'nvim-treesitter.configs'.setup {
  -- https://github.com/nvim-treesitter/nvim-treesitter#modules
  ensure_installed = {
    "dart",
    "go",
    "javascript",
    "json",
    "typescript",
    "yaml",
  },
  highlight = {
    enable = true,
  },
}
