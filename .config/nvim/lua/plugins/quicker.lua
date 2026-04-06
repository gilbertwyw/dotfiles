return {
  'stevearc/quicker.nvim',
  ft = "qf",
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {},
  keys = {
    {
      "<LocalLeader>tq",
      function()
        require("quicker").toggle()
      end,
      desc = "Toggle quickfix",

    },
    {
      "<LocalLeader>tl",
      function()
        require("quicker").toggle({ loclist = true })
      end,
      desc = "Toggle quickfix",

    },
  },
  config = function()
    require("quicker").setup({
      keys = {
        {
          ">",
          function()
            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
          end,
          desc = "Expand quickfix context",
        },
        {
          "<",
          function()
            require("quicker").collapse()
          end,
          desc = "Collapse quickfix context",
        },
      }
    })
  end
}
