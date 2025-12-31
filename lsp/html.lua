return {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "htmlangular", "htmldjango" },
  root_markers = { ".git" }
}
vim.lsp.enable("html")
