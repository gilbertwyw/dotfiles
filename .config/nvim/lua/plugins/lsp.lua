return {
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-jdtls',
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls" },
      }

      vim.diagnostic.config({ virtual_text = true })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

          if not client:supports_method('textDocument/willSaveWaitUntil') and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
              end,
            })
          end

          if client.server_capabilities.inlayHintProvider then
            -- https://neovim.io/doc/user/lsp.html#vim.lsp.inlay_hint.enable()
            vim.keymap.set('n', '<leader>ti', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end)
          end

          local opts = { buffer = args.buf }
          -- override defaults
          -- https://neovim.io/doc/user/lsp.html#lsp-defaults
          vim.keymap.set('n', 'g0', require('telescope.builtin').lsp_document_symbols, opts)
          vim.keymap.set('n', 'grr', require('telescope.builtin').lsp_references, opts)

          -- workspace
          vim.keymap.set('n', 'gwa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', 'gwl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            opts)
          vim.keymap.set('n', 'gwr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', 'gws', require('telescope.builtin').lsp_dynamic_workspace_symbols, opts)
        end
      })
    end
  },
  { 'j-hui/fidget.nvim', opts = {} },
}
