-- :h lsp-quickstart
local home_dir = os.getenv("HOME")

vim.lsp.config['luals'] = {
	-- Command and arguments to start the server.
	cmd = { home_dir .. "/.local/share/mise/installs/lua-language-server/latest/bin/lua-language-server" },
	-- Filetypes to automatically attach to.
	filetypes = { 'lua' },
	-- Sets the "workspace" to the directory where any of these files is found.
	-- Files that share a root directory will reuse the LSP server connection.
	-- Nested lists indicate equal priority, see |vim.lsp.Config|.
	root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
	-- Specific settings to send to the server. The schema is server-defined.
	-- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			}
		}
	}
}

vim.lsp.enable('luals')
