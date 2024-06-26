local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
-- this only works inside a git repo:
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
-- this requires ripgrep to be installed:
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ph', builtin.grep_string, {})
