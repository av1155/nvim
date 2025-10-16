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

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
    vim.bo[buf].filetype = "man"
    vim.bo[buf].modifiable = false

    local width = math.min(100, vim.o.columns - 4)
    local height = math.min(40, vim.o.lines - 4)

    local opts = {
        relative = "editor",
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        style = "minimal",
        border = "rounded",
    }

    local win = vim.api.nvim_open_win(buf, true, opts)

    vim.wo[win].wrap = true
    vim.wo[win].linebreak = true

    local close_keys = { "q", "<Esc>" }
    for _, key in ipairs(close_keys) do
        vim.keymap.set("n", key, "<cmd>close<cr>", { buffer = buf, nowait = true, silent = true })
    end
end

return M
