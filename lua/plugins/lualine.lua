local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local theme = "material"

local function mode_with_icon(mode)
	local icons = {
		["NORMAL"] = "",
		["INSERT"] = "",
		["VISUAL"] = "",
		["V-BLOCK"] = "",
		["V-LINE"] = "",
		["REPLACE"] = "",
		["V-REPLACE"] = "",
		["COMMAND"] = "",
		["TERMINAL"] = "",
	}

	local icon = icons[mode] or ""
	return icon .. " " .. mode
end

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = require("lualine.themes." .. theme),
		component_separators = {},
		section_separators = {},
		disabled_filetypes = { "alpha", "dashboard" },
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = mode_with_icon,
			},
		},
		lualine_b = { { "branch", separator = { left = "", right = "" } } },
		lualine_c = {
			{
				"filetype",
				icon_only = true,
				colored = true,
				separator = { left = "", right = "" },
			},
			{
				"filename",
				separator = { left = "", right = "" },
			},
			{
				"diff",
				colored = true,
				symbols = {
					added = " ",
					modified = " ",
					removed = " ",
				},
				color = { bg = "#242735" },
				separator = { left = "", right = "" },
			},
			{
				"diagnostics",
				sources = { "nvim_lsp" },
				separator = { left = "", right = "" },
			},
		},
		lualine_x = {
			{
				require("lazy.status").updates,
				cond = require("lazy.status").has_updates,
				color = { fg = "#ff9e64" },
				separator = { left = "", right = "" },
			},
			{
				"progress",
				separator = { left = "", right = "" },
			},
		},
		lualine_y = {
			{
				"location",
				separator = { left = "", right = "" },
			},
		},
		lualine_z = {
			{
				function()
					return " " .. os.date("%I:%M")
				end,
			},
		},
	},
})
