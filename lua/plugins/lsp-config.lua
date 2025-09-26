return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = { prefix = "" },
        underline = true,
        severity_sort = true,
      },
    },
  },
}
