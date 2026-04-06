return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- https://github.com/folke/which-key.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  -- comment
  { 'numToStr/Comment.nvim',     opts = {} },

  -- filetypes
  'hashivim/vim-terraform',
  'pearofducks/ansible-vim',

  -- statusline
  { 'nvim-lualine/lualine.nvim', opts = {} },

  {
    "kylechui/nvim-surround",
    version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
  },

  {
    'Valloric/ListToggle',
    init = function()
      vim.g.lt_location_list_toggle_map = '<LocalLeader>tl'
      vim.g.lt_quickfix_list_toggle_map = '<LocalLeader>tq'
    end
  },

  {
    'andymass/vim-matchup',
    opts = {
      treesitter = {
        stopline = 500,
      }
    }
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
      { '<LocalLeader>tu', vim.cmd.UndotreeToggle, desc = 'Toggle undotree' }
    },
  },

  {
    'tpope/vim-dispatch',
    lazy = true,
    cmd = { 'Dispatch', 'Make', 'Focus', 'Start' },
  },

  'AndrewRadev/splitjoin.vim',
  'Raimondi/delimitMate', -- keep?
  'chrisbra/unicode.vim',
  'kshenoy/vim-signature',
  'tommcdo/vim-exchange',
  'tpope/vim-abolish',
  'tpope/vim-characterize',
  'tpope/vim-repeat',
  'tpope/vim-rsi',
  'tpope/vim-unimpaired',
  'wellle/targets.vim',
}
