return {
	settings = {
		yaml = {
			schemas = {
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				["http://json.schemastore.org/kustomization"] = "kustomization.yaml",
				["https://json.schemastore.org/chart.json"] = "Chart.yaml",
			},
			format = {
				enable = true,
			},
		},
	},
}
