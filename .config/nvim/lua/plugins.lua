local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if fn.empty(fn.glob(install_path)) > 0 then
  is_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })

  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup({
  config = { max_jobs = 16 },
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use { 'lewis6991/impatient.nvim',
      config = function()
        require('impatient').enable_profile()
      end
    }

    -- telescope
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'nvim-telescope/telescope-file-browser.nvim', after = 'telescope.nvim' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', after = 'telescope.nvim' }
    use { 'nvim-telescope/telescope-project.nvim', after = 'telescope.nvim' }

    -- Autocompletion
    use {
      'hrsh7th/nvim-cmp', requires = {
        {
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
        }
      },
    }

    -- LSP
    use { 'neovim/nvim-lspconfig',
      after = 'telescope.nvim',
      requires = { 'hrsh7th/cmp-nvim-lsp' },
    }

    use {
      'j-hui/fidget.nvim',
      after = 'nvim-lspconfig',
      config = function()
        require('fidget').setup {}
      end
    }

    use {
      "williamboman/mason.nvim",
      config = function ()
        require("mason").setup()
      end
    }

    -- treesitter
    use {
      'nvim-treesitter/nvim-treesitter', -- TODO this fails sometimes
      run = ':TSUpdate',
    }
    use { 'nvim-treesitter/nvim-treesitter-context', after = 'nvim-treesitter' }
    use { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' }
    use { 'nvim-treesitter/playground', after = 'nvim-treesitter' }

    -- snippets
    use 'honza/vim-snippets'
    use 'rafamadriz/friendly-snippets'

    -- comment
    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }

    -- file explorer
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icons
      },
      config = function()
        require("nvim-tree").setup({
          hijack_netrw = false,
        })
        vim.keymap.set('n', '<leader>fd', ':NvimTreeFindFileToggle<cr>')
        vim.keymap.set("n", "<localleader>bn", require("nvim-tree.marks.navigation").next)
        vim.keymap.set("n", "<localleader>bp", require("nvim-tree.marks.navigation").prev)
        vim.keymap.set("n", "<localleader>bs", require("nvim-tree.marks.navigation").select)
      end
    }

    -- git
    use { 'lewis6991/gitsigns.nvim' }
    use {
      'tpope/vim-fugitive',
      config = function()
        vim.keymap.set('n', '<leader>gb', function() vim.cmd.Git 'blame' end)
        vim.keymap.set('n', '<leader>gl', function() vim.cmd.Gclog '%' end)
        vim.keymap.set('n', '<leader>gg', vim.cmd.Git)
      end
    }
    use { 'tpope/vim-git' }
    use { 'tpope/vim-rhubarb', after = 'vim-fugitive' }

    -- tmux
    use {
      'christoomey/vim-tmux-navigator',
      config = function()
        vim.g.tmux_navigator_disable_when_zoomed = 1
      end
    }
    use { 'edkolev/tmuxline.vim' }
    use { 'tmux-plugins/vim-tmux' }

    -- color scheme
    use { 'bluz71/vim-nightfly-guicolors', as = 'nightfly' }
    use { 'fenetikm/falcon' }
    use { 'folke/tokyonight.nvim',
      config = function()
        vim.cmd [[colorscheme tokyonight]]

        vim.g.tokyonight_style = "night"
        vim.g.tokyonight_sidebars = { "qf", "terminal" }
      end
    }
    use { 'haishanh/night-owl.vim' }
    use { 'joshdick/onedark.vim' }
    use { 'mhartington/oceanic-next' }

    -- ctags
    use { 'ludovicchabant/vim-gutentags' }
    use {
      'majutsushi/tagbar', -- ctags --list-languages
      config = function()
        vim.keymap.set('n', '<leader>tt', ':TagbarToggle<CR>')
      end
    }

    -- markdown
    use {
      'ellisonleao/glow.nvim',
      opt = true,
      ft = { 'markdown' },
      config = function()
        vim.keymap.set('n', '<leader>p', ':Glow<cr>')
      end
    }

    -- filetypes
    use 'hashivim/vim-terraform'
    use 'pearofducks/ansible-vim'

    -- misc.
    use 'AndrewRadev/splitjoin.vim'
    use {
      'RRethy/vim-hexokinase',
      run = 'make hexokinase',
      config = function()
        vim.keymap.set('n', '<leader>ct', ':HexokinaseToggle<cr>)')
      end
    }

    use {
      'Valloric/MatchTagAlways',
      ft = { 'xml', 'html' },
    }

    use {
      'Valloric/ListToggle',
      config = function()
        vim.g.lt_location_list_toggle_map = '<leader>tl'
        vim.g.lt_quickfix_list_toggle_map = '<leader>tq'
      end
    }
    use 'airblade/vim-rooter'
    use { 'andymass/vim-matchup', event = 'VimEnter' }
    use { 'bling/vim-airline', config = function()
      -- make symbols look okay
      vim.g.airline_powerline_fonts = 1
    end
    }
    use 'chrisbra/unicode.vim'
    use { 'editorconfig/editorconfig-vim',
      config = function()
        vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*', 'scp://.*' }
      end
    }
    use {
      'embear/vim-localvimrc',
      config = function()
        -- https://github.com/embear/vim-localvimrc#the-glocalvimrc_persistent-setting
        vim.g.localvimrc_persistent = 1
      end
    }
    use {
      'junegunn/vim-easy-align',
      config = function()
        -- Start interactive EasyAlign in visual mode (e.g. vipga) and motion/text object (e.g. gaip)
        vim.keymap.set({ 'n', 'x' }, 'gaa', '<Plug>(EasyAlign)')
      end
    }
    use 'justinmk/vim-dirvish'
    use {
      'jpalardy/vim-slime',
      config = function()
        vim.g.slime_target = 'tmux'
        vim.g.slime_default_config = {
          socket_name = "default",
          target_pane = "{last}",
        }
        vim.g.slime_dont_ask_default = 1
      end
    }
    use {
      'justinmk/vim-sneak',
      config = function()
        vim.g['sneak#s_next'] = 1
        vim.g['sneak#label']  = 1

        -- These mappings do not invoke label-mode
        vim.keymap.set({ 'n', 'v', 'o' }, 'f', '<Plug>Sneak_f')
        vim.keymap.set({ 'n', 'v', 'o' }, 'F', '<Plug>Sneak_F')
        vim.keymap.set({ 'n', 'v', 'o' }, 't', '<Plug>Sneak_t')
        vim.keymap.set({ 'n', 'v', 'o' }, 'T', '<Plug>Sneak_T')
      end
    }
    use 'kshenoy/vim-signature'
    use { 'mattn/emmet-vim', ft = { 'html', 'css' } }
    use {
      'mbbill/undotree',
      config = function()
        vim.keymap.set('n', '<leader>tu', vim.cmd.UndotreeToggle)
      end
    }
    use 'psliwka/vim-smoothie'
    use 'ryanoasis/vim-devicons'
    use 'tommcdo/vim-exchange'
    use 'tpope/vim-abolish'
    use 'tpope/vim-characterize'
    use { 'tpope/vim-dispatch', opt = true, cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } }
    use 'tpope/vim-obsession'
    use 'tpope/vim-repeat'
    use 'tpope/vim-rsi'
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'
    use {
      'tyru/open-browser.vim',
      config = function()
        -- disable netrw's gx mapping
        vim.g.netrw_nogx = 1
        vim.keymap.set({ 'n', 'v' }, 'gx', '<Plug>(openbrowser-smart-search)')
      end
    }
    use 'vim-scripts/ReplaceWithRegister'
    use 'wellle/targets.vim'
    use {
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
    }

    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('indent_blankline').setup {
          char = '┊',
          show_trailing_blankline_indent = false,
        }
      end
    }

    -- keep?
    use 'Raimondi/delimitMate'
    use {
      'heavenshell/vim-jsdoc',
      ft = { 'javascript', 'javascript.jsx', 'typescript' },
      run = 'make install'
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if is_bootstrap then
      require('packer').sync()
    end
  end
})

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
