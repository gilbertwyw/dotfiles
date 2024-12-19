-- vim.lsp.set_log_level("debug")
local servers = {
  ansiblels = {},
  bashls = {},
  gopls = {
    -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
    settings = {
      gopls = {
        -- https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
        analyses = {
          fieldalignment = true,
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  },
  helm_ls = {},
  lua_ls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        }
      }
    }
  },
  pyright = {
    -- https://docs.astral.sh/ruff/editors/setup/#neovim
    settings = {
      pyright = {
        -- Using Ruff's import organizer
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          -- Ignore all files for analysis to exclusively use Ruff for linting
          ignore = { '*' },
        },
      },
    },
  },
  ruff = {},
  terraformls = {},
  tflint = {},
  ts_ls = {},
  yamlls = {},
}

for server, config in pairs(servers) do
  config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
  require('lspconfig')[server].setup(config)
end

-- Add buffer diagnostics to the location list
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

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
    vim.keymap.set({ 'n', 'v' }, '<LocalLeader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<LocalLeader>gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<LocalLeader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
    vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, opts)

    vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<Leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
      opts)
    vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<Leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
      { desc = '[W]orkspace [S]ymbols', noremap = true, silent = true, buffer = args.buf })

    vim.keymap.set('n', 'g0', require('telescope.builtin').lsp_document_symbols, opts)
  end
})
