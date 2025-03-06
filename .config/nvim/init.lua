-- WE WANT THIS LSP CONFIG TO RUN BEFORE ANY LSPS ARE SETUP ---
-- (which happens once we load plugins) ---
--
--
-- Reserve a space in the gutter
vim.opt.signcolumn = 'yes'

--[[
-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
'force',
lspconfig_defaults.capabilities,
require('cmp_nvim_lsp').default_capabilities()
)]]

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local opts = {buffer = event.buf}

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
	end,
})


require("config.lazy")



-- ------------- KEYMAP ALL -----------------
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>q", vim.cmd.Ex)

-- vim.keymap.set("n", "<leader>tn", ":tabnew<cr>")
vim.keymap.set("n", "<C-t>", ":tabnew<cr>")
vim.keymap.set("n", "<C-w>", ":tabclose<cr>")
vim.keymap.set("n", "<C-k>", ":tabnext<cr>")
vim.keymap.set("n", "<C-j>", ":tabNext<cr>")

vim.keymap.set("n", "<leader>h", ":wincmd h<cr>")
vim.keymap.set("n", "<leader>j", ":wincmd j<cr>")
vim.keymap.set("n", "<leader>k", ":wincmd k<cr>")
vim.keymap.set("n", "<leader>l", ":wincmd l<cr>")

-- non disorienting jumping
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<S-h>", ":nohl<cr>");
--------------------------------------------





local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
-- this only works inside a git repo:
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
-- this requires ripgrep to be installed:
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ph', builtin.grep_string, {})

