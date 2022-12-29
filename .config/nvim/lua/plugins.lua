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
    use {
      'nvim-telescope/telescope.nvim',

      requires = { {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
        'nvim-telescope/telescope-project.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      } },
      config = function()
        local telescope = require('telescope')
        telescope.load_extension('file_browser')
        telescope.load_extension('fzf')
        telescope.load_extension('project')

        vim.keymap.set('n', '<C-p>', ":lua require'telescope'.extensions.project.project{display_type = 'full'}<cr>")
        vim.keymap.set('n', '<localleader>,', ':Telescope builtin<cr>')
        vim.keymap.set('n', '<leader>fb', ':Telescope file_browser<cr>')
        vim.keymap.set('n', '<leader>ff', ':Telescope file_browser path=%:p:h <cr>')
        vim.keymap.set('n', '<leader>.', ':Telescope resume<cr>')
        vim.keymap.set('n', '<leader>/', ':Telescope search_history<cr>')
        vim.keymap.set('n', '<leader><space>',
          ':Telescope find_files find_command=fd,--color,never,--type,f,--hidden,--follow,--exclude,.git<cr>')
        vim.keymap.set('n', '<leader>bb', ':Telescope buffers<cr>')
        vim.keymap.set('n', '<leader>bc', ':Telescope git_bcommits<cr>')
        vim.keymap.set('n', '<leader>bl', ':Telescope current_buffer_fuzzy_find<cr>')
        vim.keymap.set('n', '<leader>bt', ':Telescope current_buffer_tags<cr>')
        vim.keymap.set('n', '<leader>cl', ':Telescope colorscheme<cr>')
        vim.keymap.set('n', '<leader>cm', ':Telescope commands<cr>')
        vim.keymap.set('n', '<leader>fr', ':Telescope oldfiles<cr>')
        vim.keymap.set('n', '<leader>ft', ':Telescope filetypes<cr>')
        vim.keymap.set('n', '<leader>gf', ':Telescope git_files<cr>')
        vim.keymap.set('n', '<leader>gs', ':Telescope git_status<cr>')
        vim.keymap.set('n', '<leader>km', ':Telescope keymaps<cr>')
        vim.keymap.set('n', '<leader>m', ':Telescope marks<cr>')
        vim.keymap.set('n', '<leader>sp', ':Telescope live_grep<cr>')
        vim.keymap.set('n', '<localleader>ht', ':Telescope help_tags<cr>')
        vim.keymap.set('n', '<localleader>tt', ':Telescope tags<cr>')
        vim.keymap.set('n', 'gs', ':Telescope grep_string<cr>')
      end
    }

    -- cmp
    use {
      'hrsh7th/nvim-cmp', requires = {
        {
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-cmdline',
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-nvim-lsp-signature-help',
          'hrsh7th/cmp-nvim-lua',
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-vsnip',
          'hrsh7th/vim-vsnip',
          'hrsh7th/vim-vsnip-integ',
          'onsails/lspkind-nvim',
          'quangnguyen30192/cmp-nvim-ultisnips',
          'j-hui/fidget.nvim',
        }
      },
      config = function()
        -- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua
        local cmp = require 'cmp'
        local lspkind = require('lspkind')

        cmp.setup({
          sources = cmp.config.sources({
            -- order matters
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lua' },
            { name = 'ultisnips' },
            { name = 'vsnip' },
            { name = 'path' },
            -- TODO keyword_length option
            { name = 'buffer' },
          }),
          formatting = {
            format = lspkind.cmp_format({
              with_text = true,
            }),
          },
          mapping = cmp.mapping.preset.insert({
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
          }),
          snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
              vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
              vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end,
          },
          experimental = {
            ghost_text = true,
          },
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' }
          }, {
            { name = 'cmdline' }
          })
        })

        -- Expand or jump: https://github.com/hrsh7th/vim-vsnip#2-setting
        vim.cmd([[
          imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
          smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
        ]])

        require('fidget').setup {}
      end
    }

    -- LSP
    use { 'neovim/nvim-lspconfig',
      -- after = 'nvim-cmp',
      config = function()
        vim.lsp.set_log_level("debug")

        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', '<space>e', 'vim.diagnostic.open_float()', opts)
        vim.keymap.set('n', '[d', 'vim.diagnostic.goto_prev()', opts)
        vim.keymap.set('n', ']d', 'vim.diagnostic.goto_next()', opts)
        vim.keymap.set('n', '<space>q', 'vim.diagnostic.setloclist()', opts)

        local on_attach = function(client, bufnr)
          -- See `:help omnifunc` and `:help ins-completion` for more information.
          -- Enable completion triggered by <c-x><c-o>
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

          -- Mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local bufopts = { noremap = true, silent = true, buffer = bufnr }

          vim.keymap.set('n', '<LocalLeader>ca', vim.lsp.buf.code_action, bufopts)
          vim.keymap.set('n', '<LocalLeader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
          vim.keymap.set('n', '<LocalLeader>gt', vim.lsp.buf.type_definition, bufopts)
          vim.keymap.set('n', '<LocalLeader>rn', vim.lsp.buf.rename, bufopts)
          vim.keymap.set('n', '<LocalLeader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
          vim.keymap.set('n', '<LocalLeader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
          vim.keymap.set('n', '<LocalLeader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, bufopts)
          vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, bufopts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
          vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, bufopts)

          -- TODO assess
          vim.keymap.set('n', '<LocalLeader>ws', vim.lsp.buf.workspace_symbol, bufopts)
          vim.keymap.set('n', 'g0', vim.lsp.buf.document_symbol, bufopts)
        end

        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local servers = { "ansiblels", "bashls", "terraformls", "tsserver" }

        for _, lsp in ipairs(servers) do
          lspconfig[lsp].setup {
            capabilities = capabilities,
            on_attach = on_attach,
          }
        end

        lspconfig.sumneko_lua.setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' }
              }
            }
          }
        }

        -- https://github.com/neovim/nvim-lspconfig#gopls
        -- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#custom-configuration
        lspconfig.gopls.setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
            gopls = {
              -- https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
              analyses = {
                fieldalignment = true,
                unusedparams = true,
              },
              staticcheck = true,
            },
          },
        }
      end
    }
    use {
      'simrat39/symbols-outline.nvim',
      after = 'nvim-lspconfig',
      config = function()
        vim.keymap.set('n', '<leader>ts', ':SymbolsOutline<cr>')
      end
    }

    -- treesitter
    use {
      'nvim-treesitter/nvim-treesitter', -- TODO this fails sometimes
      run = ':TSUpdate',
      config = function()

        require 'nvim-treesitter.configs'.setup {
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
            "typescript",
            "vim",
            "yaml",
          },
          highlight = {
            enable = true,
          },
        }
      end
    }
    use {
      'nvim-treesitter/playground',
      after = 'nvim-treesitter',
      config = function()
        vim.keymap.set('n', '<leader>ph', ':TSHighlightCapturesUnderCursor<cr>')
        vim.keymap.set('n', '<leader>tp', ':TSPlaygroundToggle<cr>')
      end
    }
    use { 'romgrk/nvim-treesitter-context', after = 'nvim-treesitter' }

    -- snippets
    -- use 'rafamadriz/friendly-snippets'
    use {
      'SirVer/ultisnips',
      config = function()
        vim.opt.rtp:append('~/dotfiles/vim/')

        vim.g.UltiSnipsExpandTrigger      = "<C-e>"
        vim.g.UltiSnipsEditSplit          = 'vertical'
        vim.g.UltiSnipsSnippetsDir        = '~/dotfiles/vim/snips/'
        vim.g.UltiSnipsSnippetDirectories = { 'UltiSnips', 'snips' }
      end
    }
    use 'honza/vim-snippets'

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
        require("nvim-tree").setup()

        vim.keymap.set('n', '<leader>fd', ':NvimTreeFindFileToggle<cr>')
        vim.keymap.set("n", "<localleader>bn", require("nvim-tree.marks.navigation").next)
        vim.keymap.set("n", "<localleader>bp", require("nvim-tree.marks.navigation").prev)
        vim.keymap.set("n", "<localleader>bs", require("nvim-tree.marks.navigation").select)
      end
    }

    -- git
    use { 'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup {
          on_attach = function(bufnr)
            local function map(mode, lhs, rhs, opts)
              opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
              vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
            end

            -- Navigation
            map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
            map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

            -- Actions
            map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
            map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
            map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
            map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
            map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
            map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
            map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
            map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
            map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
            map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
            map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
            map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
            map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

            -- Text object
            map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
          end
        }
      end
    }
    use { 'rhysd/git-messenger.vim' } -- TOOD layz load, https://github.com/rhysd/git-messenger.vim#installation
    use {
      'tpope/vim-fugitive',
      config = function()
        vim.keymap.set('n', '<leader>gb', ':Git blame<cr>')
        vim.keymap.set('n', '<leader>gl', ':Glog %<cr>')
        vim.keymap.set('n', '<leader>gg', ':Git<cr>')
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
    use { 'bluz71/vim-nightfly-guicolors' }
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
      config = function ()
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
    use {
      'machakann/vim-swap',
      config = function()
        vim.g.swap_no_default_key_mappings = 1

        vim.keymap.set('n', 'g<', '<Plug>(swap-prev)')
        vim.keymap.set('n', 'g>', '<Plug>(swap-next)')
        vim.keymap.set('n', '<localleader>gs', '<Plug>(swap-interactive)')
        vim.keymap.set('x', '<localleader>gs', '<Plug>(swap-interactive)')
      end
    }
    use { 'mattn/emmet-vim', ft = { 'html', 'css' } }
    use {
      'mbbill/undotree',
      config = function()
        vim.keymap.set('n', '<leader>tu', ':UndotreeToggle<cr>')
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
    use 'tpope/vim-sensible'
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

    -- keep?
    use 'Raimondi/delimitMate'
    use {
      'Yggdroot/indentLine', config = function()
        vim.g.indentLine_faster     = 1
        vim.g.indentLine_setConceal = 0
      end
    }
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
