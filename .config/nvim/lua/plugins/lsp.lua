return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls" },
      }

      -- Add buffer diagnostics to the location list
      -- vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          -- https://docs.astral.sh/ruff/editors/setup/#neovim
          if client == nil then
            return
          end
          if client.name == 'ruff' then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end

          if client:supports_method('textDocument/formatting') then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = args.buf }
          vim.keymap.set('n', 'g0', require('telescope.builtin').lsp_document_symbols, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'grr', require('telescope.builtin').lsp_references, opts)

          vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<Leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
            opts)
          vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<Leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
            { desc = '[W]orkspace [S]ymbols', noremap = true, silent = true, buffer = args.buf })
        end
      })
    end
  },
  { 'j-hui/fidget.nvim', opts = {} },
}
