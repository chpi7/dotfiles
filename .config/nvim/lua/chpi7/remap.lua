vim.g.mapleader = " "
vim.keymap.set("n", "<leader>q", vim.cmd.Ex)

-- vim.keymap.set("n", "<leader>tn", ":tabnew<cr>")
vim.keymap.set("n", "<C-t>", ":tabnew<cr>")
vim.keymap.set("n", "<C-w>", ":tabclose<cr>")
vim.keymap.set("n", "<C-k>", ":tabnext<cr>")
vim.keymap.set("n", "<C-j>", ":tabNext<cr>")

-- non disorienting jumping
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

