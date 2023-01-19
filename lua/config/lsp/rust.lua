local status_ok_crates, crates = pcall(require, "crates")

if status_ok_crates then
	crates.setup({
		null_ls = {
			enabled = true,
			name = "crates.nvim",
		},
	})
end
