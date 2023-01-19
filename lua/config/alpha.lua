local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
local curr_date = os.date("%m-%d-%Y")
dashboard.section.header.val = {
	[[                               __                ]],
	[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
	[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
	[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
	[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
	[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}
dashboard.section.buttons.val = {
	dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", " " .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
	dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
	dashboard.button("C", " " .. " Colorscheme", ":Telescope colorscheme <CR>"),
	dashboard.button("q", " " .. " Quit", ":qa<CR>"),
	dashboard.button("s", " " .. " Load Directory Session", ":lua require('persistence').load()<CR>"),
	dashboard.button("S", " " .. " Load Last Session", ":lua require('persistence').load({ last = true })<CR>"),
}

local nvim_version = vim.version()
local version_string = "v" .. nvim_version.major .. "." .. nvim_version.minor .. "." .. nvim_version.patch
local plugin_stats = require("lazy").stats()
dashboard.section.footer.val = " "
	.. version_string
	.. " |  "
	.. plugin_stats.count
	.. " plugins |  "
	.. curr_date
dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
