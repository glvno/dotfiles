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
	use {'sainnhe/gruvbox-material'}
	use { "ellisonleao/gruvbox.nvim" }

	require("gruvbox").setup({
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
		contrast = "soft", -- can be "hard", "soft" or empty string
		palette_overrides = {},
		overrides = {},
		dim_inactive = false,
		transparent_mode = false,
	})
	vim.cmd("colorscheme gruvbox")

	use { 'tpope/vim-surround' }
	use { 'Hoffs/omnisharp-extended-lsp.nvim'}
	use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

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
	use {
		'j-hui/fidget.nvim',
		config = require('fidget').setup{}
	}

use {
 'nvim-treesitter/nvim-treesitter-context',
		config = function()
			require('auto-session').setup{}
		end
	}
end
