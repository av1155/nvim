local M = {}

-- Check if iferr is installed
local function is_installed()
    return vim.fn.executable("iferr") == 1
end

-- Install iferr binary
local function install_iferr()
    local cmd = "go install github.com/koron/iferr@latest"
    vim.notify("Installing iferr...", vim.log.levels.INFO)

    vim.fn.jobstart(cmd, {
        on_exit = function(_, code)
            if code == 0 then
                vim.notify("iferr installed successfully", vim.log.levels.INFO)
            else
                vim.notify("Failed to install iferr", vim.log.levels.ERROR)
            end
        end,
    })
end

-- Handle job data (remove empty lines and ANSI codes)
local function handle_job_data(data)
    if not data then
        return nil
    end

    -- Remove trailing empty lines (go.nvim does this 3 times)
    for _ = 1, 3 do
        if data[#data] == "" then
            table.remove(data, #data)
        end
    end

    if #data < 1 then
        return nil
    end

    -- Remove ANSI escape codes (from go.nvim's utils.remove_ansi_escape)
    for i, v in ipairs(data) do
        data[i] = v:gsub("\27%[%d+;%d*;%d*m", ""):gsub("\27%[[%d;]*%a", "")
    end

    return data
end

-- Insert if err != nil block (matches go.nvim's run() function exactly)
function M.insert()
    -- Ensure iferr is installed
    if not is_installed() then
        install_iferr()
        return
    end

    local byte_offset = vim.fn.wordcount().cursor_bytes
    local cmd = string.format("iferr -pos %d", byte_offset)
    local raw_data = vim.fn.systemlist(cmd, vim.fn.bufnr("%"))

    local data = handle_job_data(raw_data)
    if not data then
        return
    end

    if vim.v.shell_error ~= 0 then
        vim.notify("iferr failed: " .. vim.inspect(data), vim.log.levels.WARN)
        return
    end

    local pos = vim.fn.getcurpos()[2]
    vim.fn.append(pos, data)

    -- Auto-indent (matches go.nvim exactly)
    vim.cmd("silent normal! j=2j")
    vim.fn.setpos(".", pos)

    -- Apply vertical shift (configurable like go.nvim's iferr_vertical_shift)
    local vertical_shift = tostring(vim.g.go_iferr_vertical_shift or 2) .. "j"
    vim.cmd("silent normal! " .. vertical_shift)
end

return M
