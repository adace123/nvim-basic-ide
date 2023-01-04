local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local theme = require("lualine.themes.palenight")

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = theme,
		disabled_filetypes = { "alpha", "dashboard" },
		always_divide_middle = true,
	},
	sections = {
		lualine_x = {
			{
				require("lazy.status").updates,
				cond = require("lazy.status").has_updates,
				color = { fg = "#ff9e64" },
			},
		},
	},
})
