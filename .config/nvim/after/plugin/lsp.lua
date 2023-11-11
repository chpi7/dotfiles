local lsp_zero = require('lsp-zero')

-- remove the errors related to the vim global not being defined
local lua_opts = lsp_zero.nvim_lua_ls()
require('lspconfig').lua_ls.setup(lua_opts)

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
      "clangd",
      "lua_ls",
      "neocmake",
      "rust_analyzer"
  },
  handlers = {
    lsp_zero.default_setup,
  },
})

-- Autocomplete setup
local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping.confirm({select = false}),
		['<C-Space>'] = cmp.mapping.complete(),
		['<Tab>'] = cmp_action.luasnip_supertab(),
		['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
	})
})
