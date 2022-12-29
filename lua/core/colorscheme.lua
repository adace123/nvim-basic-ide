local colorscheme = "tundra"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("Failed to load colorscheme " .. colorscheme, "error")
	vim.cmd("colorscheme slate")
	return
end
