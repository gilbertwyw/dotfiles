return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
  },
  {
    "benfowler/telescope-luasnip.nvim",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "nvim-telescope/telescope.nvim",
    },
  },
}
