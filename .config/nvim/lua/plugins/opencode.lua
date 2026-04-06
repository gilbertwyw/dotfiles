return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  dependencies = {
    {
      ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
      "folke/snacks.nvim",
    },
  },
  config = function()
    vim.keymap.set({ "n", "x" }, "<Leader><C-a>", function() require("opencode").ask("@this: ", { submit = true }) end,
      { desc = "Ask opencode…" })
    vim.keymap.set({ "n", "x" }, "<Leader><C-x>", function() require("opencode").select() end,
      { desc = "Execute opencode action…" })
    vim.keymap.set({ "n", "t" }, "<localLeader>to", function() require("opencode").toggle() end,
      { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
      { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
      { desc = "Add line to opencode", expr = true })

    vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,
      { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end,
      { desc = "Scroll opencode down" })
  end,
}
