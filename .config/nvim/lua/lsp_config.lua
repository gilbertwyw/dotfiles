vim.lsp.set_log_level(1) -- debug

local custom_lsp_attach = function(client)
  -- See `:help nvim_buf_set_keymap()` for more information
  vim.api.nvim_buf_set_keymap(0, 'n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<LocalLeader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<LocalLeader>gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<LocalLeader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<LocalLeader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<LocalLeader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', {noremap = true})

  -- Use LSP as the handler for omnifunc.
  --    See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- For plugins with an `on_attach` callback, call them here. For example:
  require('completion').on_attach(client)
end

-- https://github.com/neovim/nvim-lspconfig#gopls
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#custom-configuration
local lspconfig = require'lspconfig'
lspconfig.gopls.setup {
  on_attach = custom_lsp_attach,
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

lspconfig.dartls.setup{
  on_attach = custom_lsp_attach,
}

lspconfig.tsserver.setup{
  on_attach = custom_lsp_attach,
}

