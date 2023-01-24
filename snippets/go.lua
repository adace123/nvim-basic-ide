require("luasnip.loaders.from_lua").lazy_load()

local env = snip_env

return {
	env.s(
		"ret_err",
		env.fmt(
			[[
    if err != nil {{
      return err
    }}
  ]],
			{}
		)
	),
}
