require("luasnip.loaders.from_lua").lazy_load()
local env = snip_env

return {
	env.s(
		"kust",
		env.fmt(
			[[
  ---
  apiVersion: kustomize.config.k8s.io/v1beta1
  kind: Kustomization
  resources:
  ]],
			{}
		)
	),
}
