-- https://github.com/folke/lazy.nvim#-installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  { 'nvim-telescope/telescope-fzf-native.nvim',  build = 'make' },
  { 'nvim-telescope/telescope-project.nvim' },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      -- snippet
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      -- UI
      'onsails/lspkind-nvim',
    },
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      { 'j-hui/fidget.nvim',       opts = {} },
      { "williamboman/mason.nvim", opts = {} },
    },
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate', -- TODO this fails sometimes
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',
    },
  },

  -- snippets
  'honza/vim-snippets',
  'rafamadriz/friendly-snippets',

  -- comment
  { 'numToStr/Comment.nvim',         opts = {} },

  -- file explorer
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    keys = {
      { '<leader>fd', vim.cmd.NvimTreeFindFileToggle, desc = 'Toggle nvim-tree' },
    },
    config = function()
      require("nvim-tree").setup({
        hijack_netrw = false,
      })
      -- TODO fix: module 'nvim-tree.api' not found
      vim.keymap.set('n', '<localleader>bn', require('nvim-tree.api').marks.navigate.next)
      vim.keymap.set('n', '<localleader>bp', require('nvim-tree.api').marks.navigate.prev)
      vim.keymap.set('n', '<localleader>bs', require('nvim-tree.api').marks.navigate.select)
    end
  },

  -- git
  'lewis6991/gitsigns.nvim',
  {
    'tpope/vim-fugitive',
    dependencies = {
      'tpope/vim-git',
      'tpope/vim-rhubarb',
    },
    keys = {
      { '<leader>gb', function() vim.cmd.Git 'blame' end, desc = ':Git blame' },
      { '<leader>gl', function() vim.cmd.Gclog '%' end,   desc = ':Gclog %' },
      { '<leader>gg', vim.cmd.Git,                        desc = ':Git' },
    },
  },

  -- tmux
  'tmux-plugins/vim-tmux',
  {
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end
  },

  -- color scheme
  { 'bluz71/vim-nightfly-guicolors', name = 'nightfly', priority = 1000 },
  { 'fenetikm/falcon',               priority = 1000 },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      vim.g.tokyonight_style = "night"
      vim.g.tokyonight_sidebars = { "qf", "terminal" }

      vim.cmd.colorscheme 'tokyonight'
    end
  },
  { 'haishanh/night-owl.vim',   priority = 1000 },
  { 'joshdick/onedark.vim',     priority = 1000 },
  { 'mhartington/oceanic-next', priority = 1000 },

  -- ctags
  'ludovicchabant/vim-gutentags',
  {
    'majutsushi/tagbar', -- `ctags --list-languages`
    keys = {
      { '<leader>tt', vim.cmd.TagbarToggle, desc = 'Toggle tagbar' }
    },
  },

  -- markdown
  {
    'ellisonleao/glow.nvim',
    opts = {},
    lazy = true,
    ft = { 'markdown' },
    keys = {
      { '<leader>p', vim.cmd.Glow, desc = ':Glow' }
    },
  },

  -- filetypes
  'hashivim/vim-terraform',
  'pearofducks/ansible-vim',

  -- statusline
  { 'nvim-lualine/lualine.nvim', opts = {} },

  -- misc.
  {
    'RRethy/vim-hexokinase',
    build = 'make hexokinase',
    keys = {
      { '<leader>tc', vim.cmd.HexokinaseToggle, desc = 'Toggle hexokinase' },
    }
  },

  {
    'Valloric/MatchTagAlways',
    ft = { 'xml', 'html' },
  },

  {
    'Valloric/ListToggle',
    config = function()
      vim.g.lt_location_list_toggle_map = '<leader>tl'
      vim.g.lt_quickfix_list_toggle_map = '<leader>tq'
    end
  },

  { 'andymass/vim-matchup',      event = 'VimEnter' },


  {
    'editorconfig/editorconfig-vim',
    config = function()
      vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*', 'scp://.*' }
    end
  },

  {
    'embear/vim-localvimrc',
    config = function()
      -- https://github.com/embear/vim-localvimrc#the-glocalvimrc_persistent-setting
      vim.g.localvimrc_persistent = 1
    end
  },

  {
    'junegunn/vim-easy-align',
    keys = {
      -- Start interactive EasyAlign in visual mode (e.g. vipga) and motion/text object (e.g. gaip)
      { 'gaa', '<Plug>(EasyAlign)', mode = { 'n', 'x' }, desc = 'easy align' },
    },
  },

  {
    'jpalardy/vim-slime',
    config = function()
      vim.g.slime_target = 'tmux'
      vim.g.slime_default_config = {
        socket_name = "default",
        target_pane = "{last}",
      }
      vim.g.slime_dont_ask_default = 1
    end
  },

  {
    'justinmk/vim-sneak',
    keys = {
      -- These mappings do not invoke label-mode, even if you have it enabled.
      { 'f', '<Plug>Sneak_f', mode = { 'n', 'v', 'o' }, desc = 'sneak: f' },
      { 'F', '<Plug>Sneak_F', mode = { 'n', 'v', 'o' }, desc = 'sneak: F' },
      { 't', '<Plug>Sneak_t', mode = { 'n', 'v', 'o' }, desc = 'sneak: t' },
      { 'T', '<Plug>Sneak_T', mode = { 'n', 'v', 'o' }, desc = 'sneak: T' },
    },
    config = function()
      vim.g['sneak#s_next'] = 1
      vim.g['sneak#label']  = 1
    end
  },

  { 'mattn/emmet-vim', ft = { 'html', 'css' }, },

  {
    'mbbill/undotree',
    keys = {
      { '<leader>tu', vim.cmd.UndotreeToggle, desc = 'Toggle undotree' }
    },
  },

  {
    'tpope/vim-dispatch',
    lazy = true,
    cmd = { 'Dispatch', 'Make', 'Focus', 'Start' },
  },

  {
    'tyru/open-browser.vim',
    keys = {
      { 'gx', '<Plug>(openbrowser-smart-search)', mode = { 'n', 'v' }, desc = 'Search in browser' }
    },
    config = function()
      -- disable netrw's gx mapping
      vim.g.netrw_nogx = 1
    end
  },

  {
    'w0rp/ale',
    cmd = 'ALEEnable',
    config = function()
      vim.g.ale_disable_lsp          = 1
      -- https://github.com/w0rp/ale#5ii-how-can-i-keep-the-sign-gutter-open
      vim.g.ale_sign_column_always   = 1
      -- https://github.com/w0rp/ale#5vii-how-can-i-change-the-format-for-echo-messages
      vim.g.ale_echo_msg_error_str   = 'E'
      vim.g.ale_echo_msg_warning_str = 'W'
      vim.g.ale_echo_msg_format      = '[%linter%] %s [%severity%]'

      -- https://github.com/w0rp/ale#5ix-how-can-i-navigate-between-errors-quickly
      vim.keymap.set('n', '[W', '<Plug>(ale_first)')
      vim.keymap.set('n', '[w', '<Plug>(ale_previous_wrap)')
      vim.keymap.set('n', ']w', '<Plug>(ale_next_wrap)')
      vim.keymap.set('n', ']W', '<Plug>(ale_last)')
    end
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  {
    'heavenshell/vim-jsdoc',
    ft = { 'javascript', 'javascript.jsx', 'typescript' },
    build = 'make install'
  },

  'AndrewRadev/splitjoin.vim',
  'Raimondi/delimitMate', -- keep?
  'airblade/vim-rooter',
  'chrisbra/unicode.vim',
  'justinmk/vim-dirvish',
  'kshenoy/vim-signature',
  'psliwka/vim-smoothie',
  'tommcdo/vim-exchange',
  'tpope/vim-abolish',
  'tpope/vim-characterize',
  'tpope/vim-obsession',
  'tpope/vim-repeat',
  'tpope/vim-rsi',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'vim-scripts/ReplaceWithRegister',
  'wellle/targets.vim',
})
