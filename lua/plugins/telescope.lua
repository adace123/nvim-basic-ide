local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")

telescope.setup({
	defaults = {

		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		file_ignore_patterns = { ".git/", "node_modules" },

		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
			},
		},
		pickers = {
			colorscheme = {
				enable_preview = true,
			},
			find_files = {
				theme = "dropdown",
				hidden = true,
			},
		},
	},
})

local extensions = {
	"live_grep_args",
	"lazy",
}

for _, extension in pairs(extensions) do
	telescope.load_extension(extension)
end
