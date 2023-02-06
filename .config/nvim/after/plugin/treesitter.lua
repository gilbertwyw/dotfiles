require('nvim-treesitter.configs').setup {
  -- https://github.com/nvim-treesitter/nvim-treesitter#modules
  ensure_installed = {
    "bash",
    "css",
    "go",
    "hcl",
    "html",
    "help",
    "javascript",
    "json",
    "lua",
    "python",
    "terraform",
    "typescript",
    "vim",
    "yaml",
  },
  sync_install = false,
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<space>]',
      node_incremental = '<space>]',
      scope_incremental = '<c-s>',
      node_decremental = '<space>[',
    },
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

vim.keymap.set('n', '<leader>ph', ':TSHighlightCapturesUnderCursor<cr>')
vim.keymap.set('n', '<leader>tp', ':TSPlaygroundToggle<cr>')
