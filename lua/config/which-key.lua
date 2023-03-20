local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["a"] = { "<cmd>Alpha<cr>", "Alpha" },
	["b"] = {
		"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		"Buffers",
	},
	["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	["w"] = { "<cmd>w!<CR>", "Save" },
	["q"] = { "<cmd>q!<CR>", "Quit" },
	["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	["L"] = { "<cmd>Lazy<CR>", "Lazy" },
	["D"] = { "<cmd>lua require('notify').dismiss()<CR>", "Dismiss Notifications" },
	["r"] = { "*:%s//", "Replace Under Cursor" },
	["R"] = { "<cmd>Spectre<CR>", "Spectre" },
	["<Leader>"] = {
		r = { "<cmd>luafile %<CR>", "Source File" },
	},
	f = {
		name = "Find",
		B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		b = { "<cmd>Telescope buffers<CR>", "Find Buffer" },
		d = { "<cmd>Telescope diagnostics bufnr=0<CR>", "Document Diagnostics" },
		D = { "<cmd>Telescope diagnostics<CR>", "Workspace Diagnostics" },
		m = { "<cmd>Telescope marks<CR>", "Find Mark" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		f = { "<cmd>Telescope find_files hidden=true<CR>", "Find File" },
		h = { "<cmd>Telescope command_history<CR>", "Command History" },
		H = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		c = { "<cmd>Telescope colorscheme<CR>", "Colorscheme" },
		w = { "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", "Find Text" },
		s = { "<cmd>Telescope grep_string<CR>", "Find String" },
		p = { "<cmd>Telescope projects<CR>", "Projects" },
		P = { "<cmd>Telescope lazy<CR>", "Plugins" },
		r = { "<cmd>Telescope oldfiles<CR>", "Recent File" },
		R = { "<cmd>Telescope registers<CR>", "Registers" },
		t = { "<cmd>TodoTelescope<CR>", "Todos" },
		k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
		C = { "<cmd>Telescope commands<CR>", "Commands" },
		z = { "<cmd>Telescope zoxide list<CR>", "Zoxide" },
	},
	g = {
		name = "Git",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk_inline()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
	},
	d = {
		name = "Debugger",
		d = { "<cmd>lua require('dap').clear_breakpoints()<cr>", "Clear Breakpoints" },
		b = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle Breakpoint" },
		c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
		o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
		O = { "<cmd>lua require'dap'.step_over()<cr>", "Step Out" },
		r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
		l = { "<cmd>lua require'dap'.run_last()<cr>", "Run Last" },
		L = { "<cmd>lua require('dap').list_breakpoints(true)<cr>", "List Breakpoints" },
		s = { "<cmd>lua require('dap').status()<cr>", "Status" },
		t = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
		u = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
	},
	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = {
			"<cmd>TroubleToggle document<cr>",
			"Document Diagnostics",
		},
		w = {
			"<cmd>Telescope diagnostics<cr>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		L = { "<cmd>LspLog<cr>", "Logs" },
		j = {
			"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
		r = { "<cmd>Telescope lsp_references<cr>", "References" },
		R = { "<cmd>LspRestart<cr>", "Restart" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
		t = { "<cmd>TroubleToggle<cr>", "Trouble Toggle" },
		["@"] = { "<cmd>lua require('neogen').generate()<cr>", "Generate Annotation" },
	},
	["O"] = { "<cmd>SymbolsOutline<CR>", "Symbols Outline" },
	S = {
		name = "Session",
		s = { "<cmd>lua require('persistence').load()<cr>", "Load Session for Current Directory" },
		l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Load Last Session" },
	},
	s = {
		name = "Split",
		h = { "<cmd>split %<cr>", "Horizontal" },
		v = { "<cmd>vsplit %<cr>", "Vertical" },
	},
	["<tab>"] = {
		name = "Tab",
		["<tab>"] = { "<cmd>tabnew<CR>", "New Tab" },
		n = { "<cmd>tabnext<CR>", "Next Tab" },
		p = { "<cmd>tabprev<CR>", "Prev Tab" },
		x = { "<cmd>tabclose<CR>", "Close Tab" },
		c = { "<cmd>tabnew<CR>:e $MYVIMRC<CR>", "Open Config in New Tab" },
	},
	t = {
		name = "Terminal",
		k = { "<cmd>lua _K9S_TOGGLE()<CR>", "k9s" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		b = { "<cmd>lua _BOTTOM_TOGGLE()<cr>", "bottom" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	},
}

local non_leader_opts = {
	mode = "n", -- NORMAL mode
	prefix = nil,
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local non_leader_mappings = {
	["["] = {
		d = { "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", "Previous Diagnostic" },
		h = { "<cmd>lua require('gitsigns').prev_hunk()<cr>", "Previous Hunk" },
	},
	["]"] = {
		d = { "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", "Next Diagnostic" },
		h = { "<cmd>lua require('gitsigns').next_hunk()<cr>", "Next Hunk" },
	},
	g = {
		d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto definition" },
		D = { "<cmd>Telescope lsp_definition<CR>", "Find definitions" },
		I = { "<cmd>Telescope lsp_implementations<CR>", "Find implementations" },
		l = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Open Diagnostic Float" },
		r = { "<cmd>Telescope lsp_references<CR>", "Find references" },
	},
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(non_leader_mappings, non_leader_opts)
