require('gitsigns').setup({
    signcolumn = true,
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text_pos = 'right_align'
    },
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
		  opts = opts or {}
		  opts.buffer = bufnr
		  vim.keymap.set(mode, l, r, opts)
		end

		map('n', '<leader>hr', gs.reset_hunk)
	end
})
