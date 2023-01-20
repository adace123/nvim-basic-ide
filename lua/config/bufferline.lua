local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

bufferline.setup({
	highlights = {
		buffer_selected = {
			bg = {
				attribute = "bg",
				highlight = "StatusLine",
			},
			fg = "#BC96E6",
			sp = {
				attribute = "fg",
				highlight = "BlueFg",
			},
		},
	},
	options = {
		left_trunc_marker = "",
		right_trunc_marker = "",
		buffer_close_icon = "",
		close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
		right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
		offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(_, _, diagnostics_dict, _)
			local s = ""
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and " " or (e == "warning" and " " or " ")
				s = s .. n .. sym
			end
			return s
		end,
	},
})
