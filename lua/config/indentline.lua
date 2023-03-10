local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	return
end

vim.cmd([[ highlight IndentBlanklineContextChar guifg=#C9C9EE gui=nocombine ]])
indent_blankline.setup({
	char = "▏",
	show_trailing_blankline_indent = false,
	show_first_indent_level = true,
	use_treesitter = true,
	use_treesitter_scope = true,
	show_current_context = true,
	buftype_exclude = { "terminal", "nofile" },
	filetype_exclude = {
		"help",
		"NvimTree",
	},
})
