local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
	},
})

local Terminal = require("toggleterm.terminal").Terminal
function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
	vim.keymap.set("t", "<C-x>", function()
		local t = require("toggleterm.terminal")
		for _, term in pairs(t.get_all()) do
			if term.window == vim.api.nvim_get_current_win() then
				term:shutdown()
			end
		end
	end, opts)
	vim.keymap.set("t", "<C-s>", function()
		Terminal:new({ direction = "horizontal" }):open()
	end)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- TODO: Add ability to shut these down
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
local k9s = Terminal:new({ cmd = "k9s", hidden = true })
local python = Terminal:new({ cmd = "ipython", hidden = true })
local bottom = Terminal:new({ cmd = "btm", hidden = true })

local path = vim.fn.getcwd()
function _LAZYGIT_TOGGLE()
	-- reload laygit when switching to buffer from different repo
	if path ~= vim.fn.getcwd() then
		path = vim.fn.getcwd()
		lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
	end
	lazygit:toggle()
end

function _K9S_TOGGLE()
	k9s:toggle()
end

function _PYTHON_TOGGLE()
	python:toggle()
end

function _BOTTOM_TOGGLE()
	bottom:toggle()
end
