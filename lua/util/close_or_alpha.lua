local M = {}

local function real_listed_count()
    local n = 0
    for _, info in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
        local b = info.bufnr
        if vim.api.nvim_buf_is_loaded(b) and vim.bo[b].buftype == "" and vim.bo[b].filetype ~= "alpha" then
            n = n + 1
        end
    end
    return n
end

function M.run(force)
    if vim.bo.filetype == "alpha" then
        return
    end

    local cur = vim.api.nvim_get_current_buf()
    local last_real = real_listed_count() == 1

    if last_real then
        local ok_alpha, alpha = pcall(require, "alpha")
        if ok_alpha then
            alpha.start()
        else
            vim.cmd.enew()
        end
        vim.schedule(function()
            pcall(vim.api.nvim_buf_delete, cur, { force = force or false })
        end)
    else
        if force then
            pcall(function()
                vim.api.nvim_buf_delete(cur, { force = true })
            end)
        else
            pcall(function()
                vim.cmd("confirm bdelete")
            end)
        end
    end
end

return M
