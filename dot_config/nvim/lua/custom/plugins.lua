return function(use)
	use {
		'phaazon/hop.nvim',
		branch = 'v2', -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require('hop').setup { keys = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' }
		end
	}
	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	}
	use {
		"windwp/nvim-ts-autotag",
		config = function() require("nvim-ts-autotag").setup {} end
	}
	use {'akinsho/bufferline.nvim', 
		tag = "v3.*", 
		requires = 'nvim-tree/nvim-web-devicons',
		config = function() 
			require('bufferline').setup{ options = { show_tab_indicators = true }} end }
	use { 'shaunsingh/nord.nvim' }

	use { "ellisonleao/gruvbox.nvim" }

	use { 'tpope/vim-surround' }
	-- use { 'Hoffs/omnisharp-extended-lsp.nvim'}
	use 'Decodetalkers/csharpls-extended-lsp.nvim'
	use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional, for file icons
		},
		tag = 'nightly', -- optional, updated every week. (see issue #1193)
		config = function() 
			require('nvim-tree').setup{
				respect_buf_cwd = true,
				open_on_setup = true,
				disable_netrw = true,
				view = {
					float = {
						enable = true,
						quit_on_focus_loss = true
					},
				}
			}
		end
	}
	-- replace this with possession.nvim when they implement autorestore 
	use {
		'rmagatti/auto-session',
		config = function()
			require("auto-session").setup {
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
			}
		end
	}

	use { 'mbbill/undotree' }
end

