-- WE WANT THIS LSP CONFIG TO RUN BEFORE ANY LSPS ARE SETUP ---
-- (which happens once we load plugins) ---
-- (this could be in lspconfig config function though) ---
--
-- Reserve a space in the gutter
vim.opt.signcolumn = 'yes'

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

		vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
		vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end, opts)
		-- vim.keymap.set("n", "gy", function() vim.lsp.buf.type_definition() end, opts)
		vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
		--[[
		{ "gr", vim.lsp.buf.references, desc = "References", nowait = true },
		{ "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
		{ "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
		{ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
		]]
	end,
})


require("config.lazy")

---------------- KEYMAP ALL ----------------
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>q", vim.cmd.Ex)

--[[
vim.keymap.set("n", "<C-t>", ":tabnew<cr>")
vim.keymap.set("n", "<C-w>", ":tabclose<cr>")
vim.keymap.set("n", "<C-k>", ":tabnext<cr>")
vim.keymap.set("n", "<C-j>", ":tabNext<cr>")
]]

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

vim.keymap.set("n", "<S-h>", "<cmd>nohl<cr>");
--------------------------------------------

