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
        if not force and vim.bo[cur].modified then
            local name = vim.fn.expand("%:p") ~= "" and vim.fn.expand("%:p") or "[No Name]"
            local choice = vim.fn.confirm(("Save changes to %s?"):format(name), "&Yes\n&No\n&Cancel", 1)
            if choice == 1 then
                pcall(function()
                    vim.cmd.write()
                end)
            elseif choice == 3 then
                return
            end
        end
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
