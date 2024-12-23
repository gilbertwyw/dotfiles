-- https://github.com/folke/lazy.nvim#-installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-telescope/telescope-project.nvim',
      { 'nvim-telescope/telescope-live-grep-args.nvim', version = "^1.0.0" },
      { 'nvim-telescope/telescope-fzf-native.nvim',     build = 'make' },
    },
  },

  -- Autocompletion
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',

    version = '*',

    opts = {
      keymap = { preset = 'default' },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      -- experimental signature help support
      signature = { enabled = true }
    },
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'j-hui/fidget.nvim', event = "LspAttach", opts = {} },
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
          require("mason").setup()
          require("mason-lspconfig").setup {
            ensure_installed = { "lua_ls" },
            automatic_installation = true,
          }
        end
      },
    },
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate', -- TODO this fails sometimes
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
  },

  -- DAP
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'mfussenegger/nvim-dap-python',
    },
    keys = {
      {
        '<F5>',
        function()
          require('dap').continue()
        end,
        desc = 'Debug: Start/Continue',
      },
      {
        '<F1>',
        function()
          require('dap').step_into()
        end,
        desc = 'Debug: Step Into',
      },
      {
        '<F2>',
        function()
          require('dap').step_over()
        end,
        desc = 'Debug: Step Over',
      },
      {
        '<F3>',
        function()
          require('dap').step_out()
        end,
        desc = 'Debug: Step Out',
      },
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Debug: Toggle Breakpoint',
      },
      {
        '<leader>dB',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set Breakpoint',
      },
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      {
        '<F7>',
        function()
          require('dapui').toggle()
        end,
        desc = 'Debug: See last session result.',
      },
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- Dap UI setup
      dapui.setup()

      -- https://github.com/mfussenegger/nvim-dap-python?tab=readme-ov-file#usage
      require("dap-python").setup("uv")
    end,
  },

  -- snippets
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

  -- comment
  { 'numToStr/Comment.nvim',     opts = {} },

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
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.tokyonight_style = "night"
      vim.g.tokyonight_sidebars = { "qf", "terminal" }

      vim.cmd [[colorscheme tokyonight]]
    end
  },

  -- markdown
  {
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow",
    keys = {
      { "<leader>p", vim.cmd.Glow, desc = ":Glow" },
    },
  },

  -- filetypes
  'hashivim/vim-terraform',
  'pearofducks/ansible-vim',

  -- statusline
  { 'nvim-lualine/lualine.nvim', opts = {} },

  -- misc.
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    }
  },

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
    config = function()
      vim.g.lt_location_list_toggle_map = '<leader>tl'
      vim.g.lt_quickfix_list_toggle_map = '<leader>tq'
    end
  },

  {
    'andymass/vim-matchup',
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
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

  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
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
  'vim-scripts/ReplaceWithRegister',
  'wellle/targets.vim',
})
