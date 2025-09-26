return {
    {
        "mfussenegger/nvim-jdtls",
        opts = function()
            local util = require("lspconfig.util")
            return {
                single_file_support = true,
                root_dir = function(fname)
                    return util.root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".idea")(fname)
                        or vim.fn.getcwd()
                end,
                capabilities = {
                    workspace = { configuration = true },
                    textDocument = {
                        completion = { completionItem = { snippetSupport = true } },
                    },
                },
            }
        end,
    },
}
