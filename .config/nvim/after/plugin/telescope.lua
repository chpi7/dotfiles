local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
-- this only works inside a git repo:
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
-- this requires ripgrep to be installed:
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
