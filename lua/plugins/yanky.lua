return {
    {
        "gbprod/yanky.nvim",
        keys = {
            -- Disable the default "=p" / "=P" and add "-p" / "-P"
            { "=p", false },
            { "=P", false },
            { "-p", "<Plug>(YankyPutAfterFilter)", mode = "n", desc = "Yanky: Put After (filter)" },
            { "-P", "<Plug>(YankyPutBeforeFilter)", mode = "n", desc = "Yanky: Put Before (filter)" },
        },
    },
}
