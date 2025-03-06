return {
	-- the colorscheme should be available when starting Neovim
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		"hrsh7th/nvim-cmp",
		-- load cmp on InsertEnter
		-- event = "InsertEnter",
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		opts = function()
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
			local cmp = require("cmp")
			local defaults = require("cmp.config.default")()
			local auto_select = true

			return {
				completion = {
					completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
				},
				preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
				mapping = cmp.mapping.preset.insert({
					['<CR>'] = cmp.mapping.confirm({select = auto_select}),
					['<C-Space>'] = cmp.mapping.complete(),
				})
			}
		end,
	},
	{ 
		"neovim/nvim-lspconfig", 
		tag = "v1.7.0",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			-- import lspconfig plugin
			local lspconfig = require("lspconfig")

			-- import cmp-nvim-lsp plugin
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			local keymap = vim.keymap -- for conciseness

			local opts = { noremap = true, silent = true }

			lspconfig.clangd.setup({})
		end,
	},
	{'nvim-treesitter/nvim-treesitter',
		build = ":TSUpdate",
		-- cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		-- opts_extend = { "ensure_installed" },
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			-- auto_install = true,
			sync_install = true,
			ensure_installed = { "c", "cpp", "lua" },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end
  	},
}
