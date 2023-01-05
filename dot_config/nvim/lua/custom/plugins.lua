local xplatform_fzf = {'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
if vim.g.is_osx then
	xplatform_fzf = { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

end 
return {

	{'folke/neodev.nvim'},
	{ -- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',

			-- Useful status updates for LSP
			'j-hui/fidget.nvim',
		},
	},

	{ -- Autocompletion
		'hrsh7th/nvim-cmp',
		dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
	},

	{ -- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		dependencies = { 'p00f/nvim-ts-rainbow' },
		build = function()
			pcall(require('nvim-treesitter.install').update { with_sync = true })
		end,
	},

	{ -- Additional text objects via treesitter
		'nvim-treesitter/nvim-treesitter-textobjects',
		dependencies = 'nvim-treesitter',
	},

	-- Git related plugins
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup {
				signs = {
					add = { text = '+' },
					change = { text = '~' },
					delete = { text = '_' },
					topdelete = { text = '‾' },
					changedelete = { text = '~' },
				},
			}
		end

	},

	{
		'nvim-lualine/lualine.nvim', -- Fancier statusline
		config = function()
			require('lualine').setup {
				options = {
					theme = 'gruvbox',
				},
			}
		end
	},
	{
		'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
		config = function()
			require('indent_blankline').setup {
				char = '┊',
				show_trailing_blankline_indent = false,
			}
		end
	},
	{
		'numToStr/Comment.nvim', -- 'gc' to comment visual regions/lines
		config = function()
			require('Comment').setup()
		end

	},
	'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

	-- Fuzzy Finder (files, lsp, etc)
	{ 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('telescope').setup {
				extensions = {
					file_browser = {
						hijack_netrw = true
					}
				},
				defaults = {
					mappings = {
						i = {
							['<C-u>'] = false,
							['<C-d>'] = false,
						},
					},
						path_display = {"truncate"}
				},
			}
		end
	},

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	xplatform_fzf,
	{'nvim-orgmode/orgmode',
		config = function()
			local orgmode = require('orgmode')
			local default_notes = [[C:\Users\michael.glaviano\.local\share\notes\refile.org]]
			local agenda_files = { [[C:\Users\michael.glaviano\.local\share\notes\*]] }
			orgmode.setup({
				org_agenda_files = agenda_files,
				org_default_notes_file = default_notes
			})
		end },
	{ 'akinsho/org-bullets.nvim', config = function()
		require('org-bullets').setup()
	end },


	{
		'phaazon/hop.nvim',
		branch = 'v2', -- optional but strongly recommended
		config = function()
			-- you can configure hop the way you like here; see :h hop-config
			require('hop').setup { keys = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' }
		end
	},

	{	'windwp/nvim-autopairs',
		config = function() require('nvim-autopairs').setup {} end
	},

	{	'windwp/nvim-ts-autotag',
		config = function() require('nvim-ts-autotag').setup {} end
	},
	{
		'akinsho/bufferline.nvim',
		version = 'v3.*',
		config = function()
			require('bufferline').setup{ options = { show_tab_indicators = true }} end },
	{'sainnhe/gruvbox-material'},
	{'ellisonleao/gruvbox.nvim',
		config = function()

			require('gruvbox').setup({
				undercurl = true,
				underline = true,
				bold = true,
				italic = true,
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = 'soft', -- can be 'hard', 'soft' or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = true,
			})
			vim.cmd('colorscheme gruvbox')
		end },

	{
		'kylechui/nvim-surround',
		version = '*', -- use for stability; omit to use `main` branch for the latest features
		config = function()
			require('nvim-surround').setup({
				keymaps = {
					delete = "dS",
					change = "cS"
				}
				-- configuration here, or leave empty to use defaults
			})
		end
	},
	{ 'hoffs/omnisharp-extended-lsp.nvim'},
	{'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },


	{ 'mbbill/undotree' },

	{'j-hui/fidget.nvim',
		config = function()
			require('fidget').setup()
		end
	},


	{'nvim-treesitter/nvim-treesitter-context'},
	{'nvim-telescope/telescope-file-browser.nvim'},
	'f-person/git-blame.nvim',
	'mfussenegger/nvim-dap',
	{ 'rcarriga/nvim-dap-ui', dependencies = {'mfussenegger/nvim-dap'} },
	{
		'simrat39/rust-tools.nvim',
	},
	'kyazdani42/nvim-web-devicons',

	{'folke/trouble.nvim',
		config = function()
			require('trouble').setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	},
	{
		'maan2003/lsp_lines.nvim',
		config = function()
			require('lsp_lines').setup()
		end,
	},
	'dstein64/vim-startuptime',
	{
		'akinsho/toggleterm.nvim', config = function()
			require('toggleterm').setup({
				open_mapping = '<C-\\>',
				direction = 'float'
			})
		end
	},
	{ 'shortcuts/no-neck-pain.nvim', version = '*'},
	{ 'xiyaowong/nvim-transparent', config = function()
		require("transparent").setup({
			enable = true, -- boolean: enable transparent
			extra_groups = { -- table/string: additional groups that should be cleared
				-- In particular, when you set it to 'all', that means all available groups

				-- example of akinsho/nvim-bufferline.lua
				"BufferLineTabClose",
				"BufferlineBufferSelected",
				"BufferLineFill", -- clear this
				"BufferLineBackground",
				"BufferLineSeparator", -- clear
				"BufferLineIndicatorSelected",
			}
		})
	end}
}
