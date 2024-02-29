local lsp_zero = require('lsp-zero')
local lspconfig = require('lspconfig')

-- Use mason to install some language servers
require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {
		"lua_ls",
		"neocmake",
		"pyright",
	},
	handlers = {
		lsp_zero.default_setup,
	},
})

lsp_zero.on_attach(function(client, bufnum)
	-- see :help lsp-zero-keybindings
	-- lsp_zero.default_keymaps({buffer = bufnum})

	local opts = {buffer = bufnum, remap = false}
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)

	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "=", function() vim.lsp.buf.format() end, opts)
	-- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- remove the errors related to the vim global not being defined
local lua_opts = lsp_zero.nvim_lua_ls()
lspconfig.lua_ls.setup(lua_opts)

-- Configure language servers installed without mason
lspconfig.clangd.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.ocamllsp.setup({}) -- opam install ocaml-lsp-server

vim.lsp.set_log_level("error")

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
