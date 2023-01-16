local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup({
	debug = false,
	on_attach = function(client, bufnr)
		local group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = group,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format()
				end,
			})
		end
	end,
	sources = {
		-- formatting
		formatting.prettier.with({
			extra_filetypes = { "toml" },
			extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
		}),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.autoflake.with({ extra_args = { "--ignore-pass-statements" } }),
		formatting.stylua,
		formatting.isort,
		formatting.rustfmt,
		formatting.alejandra,
		formatting.yamlfmt,
		formatting.zigfmt,
		formatting.gofmt,
		formatting.fixjson,
		formatting.goimports,
		formatting.taplo,
		formatting.terraform_fmt,

		-- diagnostics
		diagnostics.flake8.with({
			extra_args = { "--max-line-length=100" },
			diagnostics_postprocess = function(diagnostic)
				diagnostic.severity = vim.diagnostic.severity["WARN"]
			end,
		}),
		diagnostics.tsc,
		diagnostics.buf,
		diagnostics.jsonlint,
		diagnostics.shellcheck,
		diagnostics.statix,
		diagnostics.yamllint,

		-- code actions
		code_actions.statix,
		code_actions.eslint,
		code_actions.shellcheck,
	},
})
