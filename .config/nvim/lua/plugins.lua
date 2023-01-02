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
          -- snippet
          'L3MON4D3/LuaSnip',
          'saadparwaiz1/cmp_luasnip',
          'onsails/lspkind-nvim',
        }
      },
      config = function()
        -- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua
        local cmp = require 'cmp'
        local lspkind = require 'lspkind'
        local luasnip = require 'luasnip'

        cmp.setup({
          sources = cmp.config.sources({
            -- order matters
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'luasnip' },
            { name = 'nvim_lua' },
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
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { 'i', 's' }),
          }),
          snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
              luasnip.lsp_expand(args.body)
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

        require("luasnip.loaders.from_vscode").lazy_load()
      end
    }

    -- LSP
    use { 'neovim/nvim-lspconfig',
      -- after = 'nvim-cmp',
      config = function()
        vim.lsp.set_log_level("debug")

        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        -- Add buffer diagnostics to the location list
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

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
          vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, bufopts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
          vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, bufopts)
          vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, bufopts)

          vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
          vim.keymap.set('n', '<Leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
            bufopts)
          vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
          vim.keymap.set('n', '<Leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
            { desc = '[W]orkspace [S]ymbol', noremap = true, silent = true, buffer = bufnr })

          vim.keymap.set('n', 'g0', require('telescope.builtin').lsp_document_symbols, bufopts)
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
      'j-hui/fidget.nvim',
      after = 'nvim-lspconfig',
      config = function()
        require('fidget').setup {}
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
    use { 'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup {
          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
              if vim.wo.diff then return ']c' end
              vim.schedule(function() gs.next_hunk() end)
              return '<Ignore>'
            end, { expr = true })

            map('n', '[c', function()
              if vim.wo.diff then return '[c' end
              vim.schedule(function() gs.prev_hunk() end)
              return '<Ignore>'
            end, { expr = true })

            -- Actions
            map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
            map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
            map('n', '<leader>hS', gs.stage_buffer)
            map('n', '<leader>hu', gs.undo_stage_hunk)
            map('n', '<leader>hR', gs.reset_buffer)
            map('n', '<leader>hp', gs.preview_hunk)
            map('n', '<leader>hb', function() gs.blame_line { full = true } end)
            map('n', '<leader>tb', gs.toggle_current_line_blame)
            map('n', '<leader>hd', gs.diffthis)
            map('n', '<leader>hD', function() gs.diffthis('~') end)
            map('n', '<leader>td', gs.toggle_deleted)

            -- Text object
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
          end
        }
      end
    }
    use { 'rhysd/git-messenger.vim' } -- TOOD layz load, https://github.com/rhysd/git-messenger.vim#installation
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
