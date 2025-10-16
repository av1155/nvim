local M = {}

function M.show()
    local word = vim.fn.expand("<cword>")
    if word == "" then
        return
    end

    local man_cmd = string.format("man %s 2>/dev/null | col -b", vim.fn.shellescape(word))
    local output = vim.fn.systemlist(man_cmd)

    if vim.v.shell_error ~= 0 or #output == 0 then
        vim.notify(string.format("No man page found for '%s'", word), vim.log.levels.WARN)
        return
    end

    local _, winid = vim.lsp.util.open_floating_preview(output, "man", {
        max_height = 25,
        focus_id = "man_page",
        focusable = true,
        border = "rounded",
        offset_x = -1,
    })

    if winid then
        local bufnr = vim.api.nvim_win_get_buf(winid)
        local source_bufnr = vim.w[winid].man_page

        local function close_and_return()
            if source_bufnr and vim.api.nvim_buf_is_valid(source_bufnr) then
                vim.api.nvim_win_close(winid, true)
                local source_win = vim.fn.bufwinid(source_bufnr)
                if source_win ~= -1 then
                    vim.api.nvim_set_current_win(source_win)
                end
            else
                vim.api.nvim_win_close(winid, true)
            end
        end

        vim.keymap.set("n", "q", close_and_return, { buffer = bufnr, nowait = true, silent = true })
    end
end

return M
