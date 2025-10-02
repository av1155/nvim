return {
    {
        "nvim-mini/mini.animate",
        opts = {
            open = {
                enable = true,
                winconfig = function(win_id)
                    if not vim.api.nvim_win_is_valid(win_id) then
                        return {}
                    end

                    local buf = vim.api.nvim_win_get_buf(win_id)
                    if vim.b[buf].sidekick_cli then
                        return {}
                    end

                    return require("mini.animate").gen_winconfig.static({ steps = 25 })(win_id)
                end,
            },
            close = { enable = false },
        },
    },
}
