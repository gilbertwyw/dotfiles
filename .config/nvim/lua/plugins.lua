local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

-- required for bootstrapping when packer. repo and compiled file do not exist
vim.cmd [[packadd packer.nvim]]

return require('packer').startup({
  config = { max_jobs = 16 },
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- fix
    use { 'antoinemadec/FixCursorHold.nvim', config = function()
      -- in millisecond, used for both CursorHold and CursorHoldI,
      -- use updatetime instead if not defined
      vim.g.cursorhold_updatetime = 100
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
        vim.keymap.set('n', '<localleader>', ':Telescope builtin<cr>')
        vim.keymap.set('n', '<localleader>fb', ':Telescope file_browser<cr>')
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
      end
    }

    -- cmp
    use {
      'hrsh7th/nvim-cmp', requires = {
        {
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-cmdline',
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-nvim-lua',
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-vsnip',
          'hrsh7th/vim-vsnip',
          'hrsh7th/vim-vsnip-integ',
          'onsails/lspkind-nvim',
          'quangnguyen30192/cmp-nvim-ultisnips',
        }
      },
      config = function()
        -- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua
        local cmp = require 'cmp'
        local lspkind = require('lspkind')

        cmp.setup({
          sources = {
            -- order matters
            { name = 'nvim_lsp' },
            { name = 'nvim_lua' },
            { name = 'ultisnips' },
            { name = 'vsnip' },
            { name = 'path' },
            -- TODO keyword_length option
            { name = 'buffer' },
          },
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

        -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline('/', {
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
      end
    }

    -- LSP
    use { 'neovim/nvim-lspconfig',
      -- after = 'nvim-cmp',
      config = function()
        vim.lsp.set_log_level("debug")

        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
        vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
        vim.keymap.set('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

        local on_attach = function(client, bufnr)
          -- See `:help omnifunc` and `:help ins-completion` for more information.
          -- Enable completion triggered by <c-x><c-o>
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

          local bufopts = { noremap = true, silent = true, buffer = bufnr }

          -- Mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          vim.keymap.set('n', '<LocalLeader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', bufopts)
          vim.keymap.set('n', '<LocalLeader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', bufopts)
          vim.keymap.set('n', '<LocalLeader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', bufopts)
          vim.keymap.set('n', '<LocalLeader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', bufopts)
          vim.keymap.set('n', '<LocalLeader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', bufopts)
          vim.keymap.set('n', '<LocalLeader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>'
            ,
            bufopts)
          vim.keymap.set('n', '<LocalLeader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', bufopts)
          vim.keymap.set('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', bufopts)
          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', bufopts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', bufopts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', bufopts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', bufopts)
          vim.keymap.set('n', 'gK', '<cmd>lua vim.lsp.buf.signature_help()<CR>', bufopts)

          -- TODO assess
          vim.keymap.set('n', '<LocalLeader>ws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', bufopts)
          vim.keymap.set('n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', bufopts)
        end

        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
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

    -- fzf
    use {
      'junegunn/fzf.vim',
      requires = {
        { 'junegunn/fzf', run = ':call fzf#install()' },
      },
      config = function()
        vim.keymap.set('n', '<leader><tab>', '<plug>(fzf-maps-n)', { noremap = false })
        vim.keymap.set('x', '<leader><tab>', '<plug>(fzf-maps-x)', { noremap = false })
        vim.keymap.set('o', '<leader><tab>', '<plug>(fzf-maps-o)', { noremap = false })

        vim.keymap.set('n', '<localleader>s', ':Snippets<cr>')

        -- Insert mode completion
        vim.keymap.set('i', '<c-x><c-k>', '<plug>(fzf-complete-word)', { noremap = false })
        vim.keymap.set('i', '<c-x><c-l>', '<plug>(fzf-complete-line)', { noremap = false })
      end
    }

    -- comment
    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }

    -- file explorer
    use {
      'lambdalisue/fern.vim',
      config = function()
        vim.keymap.set('n', '<leader>fd', ':Fern . -drawer -reveal=% -toggle<cr>')
      end
    }
    use { 'lambdalisue/fern-bookmark.vim',
      config = function()
        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', '<leader>fb', ':Fern bookmark:///<CR>', opts)
      end,
      after = 'fern.vim' }
    use {
      'lambdalisue/fern-renderer-nerdfont.vim',
      requires = { 'lambdalisue/nerdfont.vim' },
      config = function()
        vim.g['fern#renderer'] = "nerdfont"
      end,
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
      ft = { 'markdown' }
    }

    -- search
    use {
      'mhinz/vim-grepper',
      cmd = { 'Grepper' },
      config = function()
        if vim.fn.executable('rg') == 1 then
          -- -highlight does not work when passing extra option(s)
          -- https://github.com/mhinz/vim-grepper/wiki/Using-the-commands
          vim.keymap.set('n', '<leader>sb', ':Grepper -tool rg -buffers -highlight<cr>')
          vim.keymap.set('n', '<leader>ss', ':Grepper -tool rg -highlight<cr>')

          -- Search for the word under the cursor
          vim.keymap.set('n', '<leader>sw', ':Grepper -tool rg -cword -noprompt<cr>')
        end

        vim.keymap.set({ 'n', 'x' }, 'gs', '<Plug>(GrepperOperator)')
      end
    }
    use {
      'junegunn/vim-slash',
      config = function()
        vim.keymap.set('n', 'zz', '<Plug>(slash-after)')
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
      vim.g.airline_powerline_fonts               = 1
      vim.g['airline#extensions#tabline#enabled'] = 1
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
    if packer_bootstrap then
      require('packer').sync()
    end
  end
})
