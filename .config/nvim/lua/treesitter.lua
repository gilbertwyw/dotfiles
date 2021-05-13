require'nvim-treesitter.configs'.setup {
  -- https://github.com/nvim-treesitter/nvim-treesitter#modules
  ensure_installed = {
    "css",
    "dart",
    "go",
    "html",
    "javascript",
    "json",
    "typescript",
    "yaml",
  },
  highlight = {
    enable = true,
  },
}
