require("auto-session").setup {
  suppressed_dirs = { '~/', '~/Downloads', '/' },

  -- ⚠️ This will only work if Telescope.nvim is installed
  -- The following are already the default values, no need to provide them if these are already the settings you want.
  session_lens = {
    -- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
    load_on_setup = true,
    theme_conf = { border = true },
    previewer = false,
  },
}

-- couldn't use lazy's "key" because of lazy loading
vim.keymap.set("n", "<C-s>", require("auto-session.session-lens").search_session, {
  noremap = true,
})
