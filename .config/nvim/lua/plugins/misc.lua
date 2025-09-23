return {
  -- comment
  { 'numToStr/Comment.nvim',     opts = {} },

  -- filetypes
  'hashivim/vim-terraform',
  'pearofducks/ansible-vim',

  -- statusline
  { 'nvim-lualine/lualine.nvim', opts = {} },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {},
  },

  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').create_default_mappings()
    end
  },

  {
    'Valloric/ListToggle',
    init = function()
      vim.g.lt_location_list_toggle_map = '<leader>tl'
      vim.g.lt_quickfix_list_toggle_map = '<leader>tq'
    end
  },

  {
    'andymass/vim-matchup',
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  },

  {
    'embear/vim-localvimrc',
    init = function()
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
    init = function()
      vim.g.slime_target = 'tmux'
      vim.g.slime_default_config = {
        socket_name = "default",
        target_pane = "{last}",
      }
      vim.g.slime_dont_ask_default = 1
    end
  },

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

  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  {
    'rmagatti/auto-session',
    lazy = false,
  },

  'AndrewRadev/splitjoin.vim',
  'Raimondi/delimitMate', -- keep?
  'chrisbra/unicode.vim',
  'kshenoy/vim-signature',
  'psliwka/vim-smoothie',
  'tommcdo/vim-exchange',
  'tpope/vim-abolish',
  'tpope/vim-characterize',
  'tpope/vim-repeat',
  'tpope/vim-rsi',
  'tpope/vim-unimpaired',
  'wellle/targets.vim',
}
