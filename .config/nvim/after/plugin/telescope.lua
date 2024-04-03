local telescope = require('telescope')
local lga_actions = require("telescope-live-grep-args.actions")

telescope.setup {
  extensions = {
    -- https://github.com/nvim-telescope/telescope-live-grep-args.nvim#configuration
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = {
        -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          ["<C-h>"] = lga_actions.quote_prompt({ postfix = " --hidden " }),
        },
      },
    }
  }
}

-- extensions
telescope.load_extension('file_browser')
telescope.load_extension('fzf')
telescope.load_extension("live_grep_args")
telescope.load_extension('project') -- https://github.com/nvim-telescope/telescope-project.nvim#project

-- for :Telescope session-lens commands
-- see: https://github.com/rmagatti/auto-session?tab=readme-ov-file#-session-lens
telescope.load_extension "session-lens"

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', function() telescope.extensions.project.project { display_type = 'full' } end,
  { desc = 'Projects' })
vim.keymap.set('n', '<localleader>,', builtin.builtin, { desc = 'Built-in pickers' })
vim.keymap.set('n', '<leader>.', builtin.resume, { desc = 'Previous picker' })
vim.keymap.set('n', '<leader>/', builtin.search_history, { desc = 'Search history' })

vim.keymap.set('n', '<leader><space>', builtin.find_files, { desc = 'Find files' })
-- --unrestricted: an alias for '--hidden --no-ignore'
vim.keymap.set('n', '<leader>F',
  function() builtin.find_files({ find_command = { 'fd', '--unrestricted', '--color', 'never', '--type', 'f' } }) end
  , { desc = 'Files (All)' })
vim.keymap.set('n', '<leader>f.',
  function() telescope.extensions.file_browser.file_browser { path = '%:p:h' } end,
  { desc = 'Files in current directory' })
vim.keymap.set('n', '<leader>fb', telescope.extensions.file_browser.file_browser, { desc = 'File browser' })
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recently opened files' })
vim.keymap.set('n', '<leader>ft', builtin.filetypes, { desc = 'Filetypes' })

vim.keymap.set('n', '<leader>bb', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>bc', builtin.git_bcommits, { desc = 'Commits for current buffer' })
vim.keymap.set('n', '<leader>bl', builtin.current_buffer_fuzzy_find,
  { desc = 'Live fuzzy search inside of the currently open buffer' })
vim.keymap.set('n', '<leader>bt', builtin.current_buffer_tags, { desc = 'Tags for the currently open buffer' })

vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Files tracked by Git' })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Git status' })

vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[D]iagnostics' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[H]elp tags' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[K]ey mappings' })
vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = '[M]arks' })
vim.keymap.set('n', '<leader>sg', telescope.extensions.live_grep_args.live_grep_args, { desc = '[G]rep' })
vim.keymap.set('n', '<leader>st', builtin.tags, { desc = '[T]ags' })
vim.keymap.set('n', 'gW', builtin.grep_string, { desc = 'Search current word' })
