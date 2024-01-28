format:
	stylua nvim/ --config-path=./nvim/.stylua.toml

lint:
	luacheck nvim/ --config ./nvim/.luacheckrc
