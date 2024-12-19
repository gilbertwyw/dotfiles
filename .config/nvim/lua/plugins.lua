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
      -- UI
      'onsails/lspkind-nvim',
    },
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
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
      'nvim-neotest/nvim-nio', -- required by 'nvim-dap-ui'

      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      'mfussenegger/nvim-dap-python'
    },
    config = function()
      local dap, dapui = require 'dap', require 'dapui'

      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
      vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })

      -- https://github.com/mfussenegger/nvim-dap-python#mappings
      vim.keymap.set('n', '<Leader>dn', function() require('dap-python').test_method() end)
      vim.keymap.set('n', '<Leader>df', function() require('dap-python').test_class() end)

      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>dB', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Debug: Set Breakpoint' })
      vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
      vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

      dapui.setup()

      -- https://github.com/rcarriga/nvim-dap-ui#usage
      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close

      require("mason-nvim-dap").setup({
        ensure_installed = { 'python' },
        automatic_setup = true,
        handlers = {}
      })
    end
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()

      local ls = require("luasnip")

      vim.keymap.set({ "i" }, "<C-L>", function() ls.expand() end, { silent = false })
      vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(1) end, { silent = false })
      vim.keymap.set({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = false })

      vim.keymap.set({ "i", "s" }, "<C-E>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })
    end,
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

  -- file explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
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
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
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
