
local home_dir = os.getenv("HOME")
local markdown_lsp_path = home_dir .. "/.local/share/mise/installs/marksman/latest/marksman"

vim.lsp.config['marksman'] = {
	-- Command and arguments to start the server.
	cmd = { markdown_lsp_path, "server" },
	root_markers = { ".marksman.toml", "markdown.mdx" },
	-- Filetypes to automatically attach to.
	filetypes = { 'markdown', "markdown.mdx" },
}

vim.lsp.enable('marksman')

