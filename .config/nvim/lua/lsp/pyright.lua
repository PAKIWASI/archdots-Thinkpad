
return {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "standard",
        autoSearchPaths = true,

        diagnosticSeverityOverrides = {
          reportUnusedVariable = "warning",
          reportUnusedImport = "warning",
          reportMissingTypeStubs = "warning",
        },

        useLibraryCodeForTypes = true,
        autoImportCompletions = true,
        diagnosticMode = "workspace",
      },
    },
  },

  on_attach = function(_, bufnr)
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("<leader>co", "<cmd>LspPyrightOrganizeImports<cr>", "Organize Imports")
  end,
}
