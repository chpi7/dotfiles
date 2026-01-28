return {
	-- the colorscheme should be available when starting Neovim
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme tokyonight-night")
		end,
	},
	--[[{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme nightfox")
		end,
	},]]
	{
		-- Save sessions to ~/.local/state/nvim/sessions
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {
			options = { "buffers", "curdir", "winsize" },
		},
		-- stylua: ignore
		keys = {
			{ "<leader>ss", function() require("persistence").load() end, desc = "Restore Session" },
			{ "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
		},
		--[[ config = function(_, opts)
			require("persistence").setup(opts)

			-- Close Neo-tree before session is saved
			vim.api.nvim_create_autocmd("User", {
				pattern = "PersistenceSavePre",
				callback = function()
					vim.cmd("Neotree close")
				end,
			})
		end ]]
	},
	{
		'akinsho/bufferline.nvim', 
		version = "v4", 
		dependencies = 'nvim-tree/nvim-web-devicons',
		opts = {
			options = {
				always_show_bufferline = false,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
					{
						filetype = "snacks_layout_box",
					},
				},
				custom_filter = function(buf, _)
					-- Get the name of the buffer
					local buf_name = vim.api.nvim_buf_get_name(buf)

					-- Exclude empty buffers or special buffers
					if buf_name == "" or vim.bo[buf].buftype ~= "" then
						return false
					end

					-- Check if the buffer points to a real file on disk
					local stat = vim.loop.fs_stat(buf_name)
					if not stat or stat.type ~= "file" then
						return false
					end

					return true
				end,
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
			vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
				callback = function()
					vim.schedule(function()
						pcall(nvim_bufferline)
					end)
				end,
			})
			vim.keymap.set("n", "<C-j>", "<cmd>BufferLineCyclePrev<cr>")
			vim.keymap.set("n", "<C-k>", "<cmd>BufferLineCycleNext<cr>")
		end,
	},
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		keys = {
			{"<leader>pf", "<cmd>Telescope find_files<cr>", desc=""},
			-- this only works inside a git repo:
			{'<leader>gf', "<cmd>Telescope git_files<cr>", desc=""},
			-- this requires ripgrep to be installed:
			{'<leader>ps', "<cmd>Telescope live_grep<cr>", desc=""},
			{'<leader>ph', "<cmd>Telescope grep_string<cr>", desc=""},
			{'<leader>pr', "<cmd>Telescope lsp_references<cr>", desc=""},
		},
		opts = {
			defaults = {
				layout_strategy = 'vertical',
				layout_config = { height = 0.95, preview_height = 0.5 },
			},
		},
	},

	{
		"L3MON4D3/LuaSnip",
		-- version = false,
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
	},


	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
		},
		-- Not all LSP servers add brackets when completing a function.
		-- To better deal with this, LazyVim adds a custom option to cmp,
		-- that you can configure. For example:
		--
		-- ```lua
		-- opts = {
		--   auto_brackets = { "python" }
		-- }
		-- ```
		opts = function()

			local luasnip = require("luasnip")

			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
			local cmp = require("cmp")
			local defaults = require("cmp.config.default")()
			local auto_select = true
			return {
				auto_brackets = {}, -- configure any filetype to auto add brackets
				completion = {
					completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
				},
				preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,

				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
						-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

						-- For `mini.snippets` users:
						-- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
						-- insert({ body = args.body }) -- Insert at cursor
						-- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
						-- require("cmp.config").set_onetime({ sources = {} })
					end,
				},

				mapping = cmp.mapping.preset.insert({
					-- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
					-- ["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<C-CR>"] = function(fallback)
						cmp.abort()
						fallback()
					end,


					['<CR>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({
									select = true,
								})
							end
						else
							fallback()
						end
					end),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),


				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
				}, {
						{ name = "buffer" },
					}),
				formatting = {
					format = function(entry, item)
						--[[
						local icons = LazyVim.config.icons.kinds
						if icons[item.kind] then
							item.kind = icons[item.kind] .. item.kind
						end
						]]

						local widths = {
							abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
							menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
						}

						for key, width in pairs(widths) do
							if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
								item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
							end
						end

						return item
					end,
				},
				experimental = {
					-- only show ghost text when we show ai completions
					ghost_text = vim.g.ai_cmp and {
						hl_group = "CmpGhostText",
					} or false,
				},
				sorting = defaults.sorting,
			}
		end,
		-- main = "lazyvim.util.cmp",
	},
	{ 
		"neovim/nvim-lspconfig", 
		tag = "v2.5.0",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },

		opts = function ()
			local ret = {
				diagnostics = {
					underline = true,
					update_in_insert = false,
					virtual_text = {
						spacing = 4,
						source = "if_many",
						prefix = "●",
						-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
						-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
						-- prefix = "icons",
					},
					severity_sort = true,
					signs = {
						text = {
							[vim.diagnostic.severity.ERROR] = "E",
							[vim.diagnostic.severity.WARN] = "W",
							[vim.diagnostic.severity.HINT] = "H",
							[vim.diagnostic.severity.INFO] = "I",
						},
					},
				},
				-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
				-- Be aware that you also will need to properly configure your LSP server to
				-- provide the inlay hints.
				inlay_hints = {
					enabled = true,
					exclude = { }, -- filetypes for which you don't want to enable inlay hints
				},
				-- add any global capabilities here
				capabilities = {
					workspace = {
						fileOperations = {
							didRename = true,
							willRename = true,
						},
					},
				},
				format = {
					formatting_options = nil,
					timeout_ms = nil,
				},
				servers = {
					clangd = {
						settings = {
							clangd = {
								InlayHints = {
									Enabled = true,
									Designators = true,
									ParameterNames = true,
									DeducedTypes = true,
								},
							},
						},
						on_attach = function(client, bufnr)
							if client.server_capabilities.inlayHintProvider then
								vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
							end
						end,
					},
					zls = {},
					pyright = {},
					ocamllsp = {},
					rust_analyzer = {},
				},
				setup = { },
			}
			return ret
		end,

		config = function(_, opts)
			-- Add capabilities settings to lspconfig
			-- This should be executed before you configure any language server
			local servers = opts.servers

			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			local has_blink, blink = pcall(require, "blink.cmp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				has_cmp and cmp_nvim_lsp.default_capabilities() or {},
				has_blink and blink.get_lsp_capabilities() or {},
				opts.capabilities or {}
			)

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, servers[server] or {})
				if server_opts.enabled == false then
					return
				end

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end

			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					if server_opts.enabled ~= false then
						-- no mason, install stuff manually :)
						setup(server)
						--[[
						if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
							setup(server)
						else
							ensure_installed[#ensure_installed + 1] = server
						end]]
					end
				end
			end



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
	{
		'lewis6991/gitsigns.nvim',
		-- events = 'LazyFile',
		lazy = false,
		opts = {
			current_line_blame = true,
		},
		keys = {
			{"<leader>ggs", "<cmd>Gitsigns stage_hunk<CR>", desc=""},
			{"<leader>ggr", "<cmd>Gitsigns reset_hunk<CR>", desc=""},
			{"<leader>ggl", "<cmd>Gitsigns blame_line<CR>", desc=""},
		}
	},
	--[[{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		---@module 'neo-tree'
		---@type neotree.Config
		opts = {
			close_if_last_window = true,
			-- auto_clean_after_session_restore = true,
			hide_root_node = true,
			filesystem = {
				follow_current_file = {
					enabled = true,
				},
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = true,
				},
			},
		},
		keys = {
			{"<leader>e", "<Cmd>Neotree toggle<CR>"}
		},
	},]]
}
