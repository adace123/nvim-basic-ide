local colorscheme = {
	plugin = "rebelot/kanagawa.nvim",
	selected = "kanagawa",
	fallback = "slate",
}

local colorschemes = {
	{ "folke/tokyonight.nvim" },
	{ "lunarvim/darkplus.nvim" },
	{ "rebelot/kanagawa.nvim" },
	{ "catppuccin/nvim" },
	{ "sainnhe/everforest" },
	{ "ellisonleao/gruvbox.nvim" },
	{ "sam4llis/nvim-tundra" },
	{ "ray-x/aurora" },
	{ "drewtempelmeyer/palenight.vim" },
	{ "olimorris/onedarkpro.nvim" },
	{ "nyoom-engineering/oxocarbon.nvim" },
	{ "sainnhe/gruvbox-material" },
	{ "arcticicestudio/nord-vim" },
	{ "LunarVim/horizon.nvim" },
	{ "Rigellute/shades-of-purple.vim" },
}

for _, theme in pairs(colorschemes) do
	if theme[1] == colorscheme["plugin"] then
		theme["priority"] = 1000
		theme["config"] = function()
			local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme["selected"])
			if not ok then
				vim.notify("Error loading " .. colorscheme["selected"] .. ". Falling back to default ")
				vim.cmd("colorscheme " .. colorscheme["fallback"])
			end
		end
	end
end

return colorschemes