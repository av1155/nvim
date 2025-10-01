local M = {}

local function is_normal_file_buffer(bufnr)
    if not vim.api.nvim_buf_is_loaded(bufnr) then
        return false
    end
    local buftype = vim.bo[bufnr].buftype
    local filetype = vim.bo[bufnr].filetype
    return buftype == "" and filetype ~= "alpha"
end

local function get_normal_file_windows()
    local normal_wins = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local config = vim.api.nvim_win_get_config(win)
        if config.relative == "" then
            local buf = vim.api.nvim_win_get_buf(win)
            if is_normal_file_buffer(buf) then
                table.insert(normal_wins, { win = win, buf = buf })
            end
        end
    end
    return normal_wins
end

local function find_next_normal_buffer(current_buf)
    for _, info in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
        local bufnr = info.bufnr
        if bufnr ~= current_buf and is_normal_file_buffer(bufnr) then
            return bufnr
        end
    end
    return nil
end

function M.run(force)
    local buftype = vim.bo.buftype
    local filetype = vim.bo.filetype

    if buftype ~= "" or filetype == "alpha" then
        return
    end

    local cur_buf = vim.api.nvim_get_current_buf()
    local cur_win = vim.api.nvim_get_current_win()
    local normal_wins = get_normal_file_windows()

    local other_normal_wins = vim.tbl_filter(function(w)
        return w.buf ~= cur_buf
    end, normal_wins)

    if #other_normal_wins > 0 then
        if force then
            pcall(vim.api.nvim_buf_delete, cur_buf, { force = true })
        else
            pcall(function()
                vim.cmd("confirm bdelete")
            end)
        end
    elseif #normal_wins == 1 then
        local next_buf = find_next_normal_buffer(cur_buf)
        if next_buf then
            pcall(vim.api.nvim_win_set_buf, cur_win, next_buf)
            vim.schedule(function()
                if force then
                    pcall(vim.api.nvim_buf_delete, cur_buf, { force = true })
                else
                    pcall(vim.api.nvim_buf_delete, cur_buf, { force = false })
                end
            end)
        else
            vim.schedule(function()
                local ok_alpha, alpha = pcall(require, "alpha")
                if ok_alpha then
                    alpha.start()
                else
                    vim.cmd.enew()
                end
                vim.schedule(function()
                    pcall(vim.api.nvim_buf_delete, cur_buf, { force = force or false })
                end)
            end)
        end
    end
end

return M
