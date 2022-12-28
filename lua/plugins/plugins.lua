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
	{ "numToStr/Comment.nvim" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "kyazdani42/nvim-web-devicons" },
	{ "kyazdani42/nvim-tree.lua" },
	{ "akinsho/bufferline.nvim" },
	{ "moll/vim-bbye" },
	{ "nvim-lualine/lualine.nvim" },
	{ "akinsho/toggleterm.nvim" },
	{ "ahmedkhalf/project.nvim" },
	{ "lewis6991/impatient.nvim" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "goolord/alpha-nvim" },

	-- Colorschemes
	{ "folke/tokyonight.nvim" },
	{ "lunarvim/darkplus.nvim" },

	-- cmp plugins
	{ "hrsh7th/nvim-cmp" }, -- The completion plugin
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
	-- use { "williamboman/nvim-lsp-installer" } -- simple to use language server installer
	{ "neovim/nvim-lspconfig" }, -- enable LSP
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters
	{ "RRethy/vim-illuminate" },
	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup()
		end,
	},
	{ "Saecki/crates.nvim" },

	-- Telescope
	{ "nvim-telescope/telescope.nvim" },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
	},

	-- Git
	{ "lewis6991/gitsigns.nvim" },

	-- DAP
	{ "mfussenegger/nvim-dap" },
	{ "rcarriga/nvim-dap-ui" },
	{ "ravenxrz/DAPInstall.nvim" },

	-- which-key
	{ "folke/which-key.nvim" },

	-- fidget
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	},

	-- themes
	{ "rebelot/kanagawa.nvim" },
	{ "catppuccin/nvim" },
	{ "sainnhe/everforest" },
	{ "ellisonleao/gruvbox.nvim" },

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
			require("notify").setup()
		end,
	},
}

lazy.setup(plugins)
