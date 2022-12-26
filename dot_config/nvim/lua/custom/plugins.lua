return function(use)
	use {
		'phaazon/hop.nvim',
		branch = 'v2', -- optional but strongly recommended
		config = function()
			-- you can configure hop the way you like here; see :h hop-config
			require('hop').setup { keys = 'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz' }
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

	-- use { 'tpope/vim-surround' }
	use({
		"kylechui/nvim-surround",
		tag = "*", -- use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- configuration here, or leave empty to use defaults
			})
		end
	})
	use { 'hoffs/omnisharp-extended-lsp.nvim'}
	use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }


	use { 'mbbill/undotree' }
	use {
		'j-hui/fidget.nvim',
		config = require('fidget').setup{}
	}

	use {
		'nvim-treesitter/nvim-treesitter-context',
	}
	use { 'nvim-telescope/telescope-file-browser.nvim'}
	use 'f-person/git-blame.nvim'
	use 'mfussenegger/nvim-dap'
	use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
	use 'simrat39/rust-tools.nvim'
	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}
	use({
		"maan2003/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
		end,
	})
end
