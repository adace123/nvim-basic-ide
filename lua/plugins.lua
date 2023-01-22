local plugins = {
	{ "folke/lazy.nvim" }, -- Have lazy manage itself
	{ "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
	{ "windwp/nvim-autopairs" }, -- Autopairs, integrates with both cmp and treesitter
	{
		"numToStr/Comment.nvim",
		config = function()
			require("config.autopairs")
		end,
	},
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "kyazdani42/nvim-web-devicons" },
	{
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("config.nvim-tree")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		config = function()
			require("config.bufferline")
		end,
	},
	{ "moll/vim-bbye" },
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("config.lualine")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("config.toggleterm")
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("config.project")
		end,
	},
	{ "lewis6991/impatient.nvim" },
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("config.indentline")
		end,
	},
	{
		"goolord/alpha-nvim",
		config = function()
			require("config.alpha")
		end,
	},

	-- cmp plugins
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("config.cmp")
		end,
	}, -- The completion plugin
	{ "hrsh7th/cmp-buffer" }, -- buffer completions
	{ "hrsh7th/cmp-path" }, -- path completions
	{ "saadparwaiz1/cmp_luasnip" }, -- snippet completions
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "hrsh7th/cmp-cmdline" },

	-- snippets
	{
		"L3MON4D3/LuaSnip",
		config = function()
			require("luasnip.loaders.from_vscode").load()
		end,
	}, --snippet engine
	{ "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use

	-- LSP
	{ "neovim/nvim-lspconfig" }, -- enable LSP
	{ "williamboman/mason.nvim" },
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("config.lsp")
		end,
	},
	{ "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters
	{
		"RRethy/vim-illuminate",
		config = function()
			require("config.illuminate")
		end,
	},
	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup()
		end,
	},
	{
		"Saecki/crates.nvim",
		config = function()
			require("crates").setup()
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup()
		end,
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"zbirenbaum/neodim",
		config = function()
			require("neodim").setup({
				alpha = 0.75,
				blend_color = "#000000",
				update_in_insert = {
					enable = true,
					delay = 100,
				},
				hide = {
					virtual_text = true,
					signs = true,
					underline = true,
				},
			})
		end,
	},
	{ "towolf/vim-helm" },
	{ "NoahTheDuke/vim-just" },
	{
		"onsails/lspkind.nvim",
	},
	{ "ray-x/lsp_signature.nvim" },
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup()
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"simrat39/inlay-hints.nvim",
		config = function()
			require("inlay-hints").setup()
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup({})
		end,
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("config.telescope")
		end,
	},
	{
		"tsakirist/telescope-lazy.nvim",
	},
	{
		"nvim-telescope/telescope-live-grep-args.nvim",
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("config.treesitter")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},

	-- DAP
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("config.dap")
		end,
	},
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	{ "ravenxrz/DAPInstall.nvim" },

	-- which-key
	{
		"folke/which-key.nvim",
		config = function()
			require("config.which-key")
		end,
	},

	-- fidget
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	},

	-- surround
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	},

	-- notifications
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	},

	-- search
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("hlslens").setup()
		end,
	},

	-- sessions
	{
		"folke/persistence.nvim",
		config = function()
			require("persistence").setup()
		end,
	},

	-- motion
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	},

	-- zen mode
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup()
		end,
	},

	-- tabs
	{
		"tiagovla/scope.nvim",
		config = function()
			require("scope").setup()
		end,
	},

	-- search and replace
	{
		"nvim-pack/nvim-spectre",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("spectre").setup()
		end,
	},

	-- colorschemes
	require("config.colorschemes"),
	{
		"utilyre/barbecue.nvim",
		config = function()
			require("barbecue").setup()
		end,
		dependencies = {
			"neovim/nvim-lspconfig",
			"SmiteshP/nvim-navic",
		},
	},

	-- window separator
	{
		"nvim-zh/colorful-winsep.nvim",
		config = function()
			require("colorful-winsep").setup()
		end,
	},
}
return plugins
