local telescope = require('telescope')
-- extensions
telescope.load_extension('file_browser')
telescope.load_extension('fzf')
telescope.load_extension('project')

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
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[G]rep' })
vim.keymap.set('n', '<leader>st', builtin.tags, { desc = '[T]ags' })
vim.keymap.set('n', 'gs', builtin.grep_string, { desc = 'Search current word' })
