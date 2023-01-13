local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

local plugins = {
	{ "folke/lazy.nvim" }, -- Have lazy manage itself
	{ "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
	{ "windwp/nvim-autopairs" }, -- Autopairs, integrates with both cmp and treesitter
	{
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.autopairs")
		end,
	},
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "kyazdani42/nvim-web-devicons" },
	{
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("plugins.nvim-tree")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		config = function()
			require("plugins.bufferline")
		end,
	},
	{ "moll/vim-bbye" },
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.lualine")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("plugins.toggleterm")
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("plugins.project")
		end,
	},
	{ "lewis6991/impatient.nvim" },
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("plugins.indentline")
		end,
	},
	{
		"goolord/alpha-nvim",
		config = function()
			require("plugins.alpha")
		end,
	},

	-- Colorschemes
	{ "folke/tokyonight.nvim" },
	{ "lunarvim/darkplus.nvim" },
	{ "rebelot/kanagawa.nvim" },
	{ "catppuccin/nvim" },
	{ "sainnhe/everforest" },
	{ "ellisonleao/gruvbox.nvim" },
	{
		"sam4llis/nvim-tundra",
		config = function()
			require("nvim-tundra").setup({
				dim_inactive_windows = {
					enabled = true,
				},
			})
		end,
	},
	{ "ray-x/aurora" },
	{ "cocopon/iceberg.vim" },
	{ "drewtempelmeyer/palenight.vim" },
	{ "olimorris/onedarkpro.nvim" },
	{ "nyoom-engineering/oxocarbon.nvim" },
	{ "sainnhe/gruvbox-material" },
	{ "arcticicestudio/nord-vim" },
	{ "LunarVim/horizon.nvim" },
	{ "Rigellute/shades-of-purple.vim" },

	-- cmp plugins
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("plugins.cmp")
		end,
	}, -- The completion plugin
	{ "hrsh7th/cmp-buffer" }, -- buffer completions
	{ "hrsh7th/cmp-path" }, -- path completions
	{ "saadparwaiz1/cmp_luasnip" }, -- snippet completions
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "hrsh7th/cmp-cmdline" },

	-- snippets
	{ "L3MON4D3/LuaSnip" }, --snippet engine
	{ "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use

	-- LSP
	{ "neovim/nvim-lspconfig" }, -- enable LSP
	{ "williamboman/mason.nvim" },
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("plugins.lsp")
		end,
	},
	{ "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters
	{
		"RRethy/vim-illuminate",
		config = function()
			require("plugins.illuminate")
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
	-- {
	-- 	"glepnir/lspsaga.nvim",
	-- 	config = function()
	-- 		require("lspsaga").setup({
	-- 			code_action_lightbulb = {
	-- 				enable = false,
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{ "towolf/vim-helm" },
	{ "NoahTheDuke/vim-just" },

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("plugins.telescope")
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.treesitter")
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
			require("plugins.dap")
		end,
	},
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	{ "ravenxrz/DAPInstall.nvim" },

	-- which-key
	{
		"folke/which-key.nvim",
		config = function()
			require("plugins.which-key")
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
}

lazy.setup(plugins)
