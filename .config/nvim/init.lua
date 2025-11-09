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

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
		vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "=", vim.lsp.buf.format, opts)

		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gI",  vim.lsp.buf.implementation, opts)
		-- vim.keymap.set("n", "gy",  vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "gD",  vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "<leader>ih", function()
			local e = vim.lsp.inlay_hint.is_enabled()
			vim.lsp.inlay_hint.enable(not e)
		end, opts)
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
vim.keymap.set("n", "<PageUp>", "<C-u>zz")
vim.keymap.set("n", "<PageDown>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<S-h>", "<cmd>nohl<cr>");
--------------------------------------------

