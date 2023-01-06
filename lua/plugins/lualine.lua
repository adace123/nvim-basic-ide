local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local theme = require("lualine.themes.palenight")

local function mode_with_icon(mode)
	local icons = {
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

-- source: https://github.com/iamverysimp1e/dots/blob/main/.config/nvim/lua/simp1e/lualine.lua
local function lsp_progess(msg)
	msg = msg or "LS Inactive"
	local buf_clients = vim.lsp.buf_get_clients()
	if next(buf_clients) == nil then
		-- TODO: clean up this if statement
		if type(msg) == "boolean" or #msg == 0 then
			return "LS Inactive"
		end
		return msg
	end
	local buf_ft = vim.bo.filetype
	local buf_client_names = {}
	local copilot_active = false
	local null_ls = require("null-ls")
	local alternative_methods = {
		null_ls.methods.DIAGNOSTICS,
		null_ls.methods.DIAGNOSTICS_ON_OPEN,
		null_ls.methods.DIAGNOSTICS_ON_SAVE,
	}

	-- add client
	for _, client in pairs(buf_clients) do
		if client.name ~= "null-ls" then
			table.insert(buf_client_names, client.name)
		end
	end

	local function list_registered_providers_names(filetype)
		local s = require("null-ls.sources")
		local available_sources = s.get_available(filetype)
		local registered = {}
		for _, source in ipairs(available_sources) do
			for method in pairs(source.methods) do
				registered[method] = registered[method] or {}
				table.insert(registered[method], source.name)
			end
		end
		return registered
	end
	local function list_registered(filetype)
		local registered_providers = list_registered_providers_names(filetype)
		local providers_for_methods = vim.tbl_flatten(vim.tbl_map(function(m)
			return registered_providers[m] or {}
		end, alternative_methods))
		return providers_for_methods
	end

	local function formatters_list_registered(filetype)
		local registered_providers = list_registered_providers_names(filetype)
		return registered_providers[null_ls.methods.FORMATTING] or {}
	end
	-- formatters
	local supported_formatters = formatters_list_registered(buf_ft)
	vim.list_extend(buf_client_names, supported_formatters)

	-- linters
	local supported_linters = list_registered(buf_ft)
	vim.list_extend(buf_client_names, supported_linters)
	local unique_client_names = vim.fn.uniq(buf_client_names)

	return " " .. table.concat(unique_client_names, ", ")
end

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = theme,
		disabled_filetypes = { "alpha", "dashboard" },
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = mode_with_icon,
			},
		},
		lualine_b = { "branch" },
		lualine_c = {
			{
				"filetype",
				icon_only = true,
				colored = true,
			},
			{
				"filename",
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
			},
			{
				"diagnostics",
				sources = { "nvim_lsp" },
			},
			{
				lsp_progess,
				color = { fg = "#9F86C0" },
			},
		},
		lualine_x = {
			{
				require("lazy.status").updates,
				cond = require("lazy.status").has_updates,
				color = { fg = "#ff9e64" },
			},
		},
	},
})
