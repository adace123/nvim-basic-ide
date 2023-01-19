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

local function get_lsp_clients()
	local clients = vim.lsp.get_active_clients({ bufnr = 0 })
	if next(clients) == nil then
		return ""
	end

	local client_names = {}
	for _, client in pairs(clients) do
		if client.name ~= "null-ls" then
			table.insert(client_names, client.name)
		end
	end

	return " " .. table.concat(client_names, ", ")
end
lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = require("lualine.themes." .. theme),
		component_separators = "|",
		disabled_filetypes = { "alpha" },
		section_separators = { left = "", right = "" },
	},
	-- tabline = {
	-- 	lualine_a = {
	-- 		{
	-- 			"buffers",
	-- 			right_padding = 2,
	-- 			symbols = { alternate_file = "" },
	-- 			buffers_color = {
	-- 				active = { bg = "#7C77B9", fg = "#FEEAFA" },
	-- 				inactive = { bg = "#000000", fg = "#95969D" },
	-- 			},
	-- 		},
	-- 	},
	-- 	lualine_b = {
	-- 		{
	-- 			"diagnostics",
	-- 		},
	-- 	},
	-- },
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = mode_with_icon,
			},
		},
		lualine_b = {
			{ "branch" },
			{
				"diff",
				colored = true,
				symbols = {
					added = " ",
					modified = " ",
					removed = " ",
				},
				color = { bg = "#242735" },
			},
			{
				"filetype",
				icon_only = true,
				colored = true,
			},
			{
				"filename",
			},
		},
		lualine_c = {
			{
				get_lsp_clients,
			},
			{
				"diagnostics",
				sources = { "nvim_lsp" },
			},
		},
		lualine_x = {
			{
				require("lazy.status").updates,
				cond = require("lazy.status").has_updates,
				color = { fg = "#ff9e64" },
			},
			{
				"progress",
			},
		},
		lualine_y = {
			{
				"location",
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
