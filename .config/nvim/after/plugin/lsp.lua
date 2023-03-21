-- vim.lsp.set_log_level("debug")

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = {
  "ansiblels",
  "bashls",
  "terraformls",
  "tsserver",
  "yamlls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
  }
end

lspconfig.lua_ls.setup {
  capabilities = capabilities,
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

vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- Add buffer diagnostics to the location list
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<LocalLeader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<LocalLeader>f', function() vim.lsp.buf.format { async = true } end, opts)
    vim.keymap.set('n', '<LocalLeader>gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<LocalLeader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
    vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, opts)

    vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<Leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
      opts)
    vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<Leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
      { desc = '[W]orkspace [S]ymbols', noremap = true, silent = true, buffer = ev.buf })

    vim.keymap.set('n', 'g0', require('telescope.builtin').lsp_document_symbols, opts)
  end
})
