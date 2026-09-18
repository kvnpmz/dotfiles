local M = {}

local last_update = -1
local cached_status = ""

function M.get(current_time)
    if current_time ~= last_update then
        local f = io.open("/proc/meminfo", "r")

        if f then
            local total, available

            for line in f:lines() do
                if line:match("^MemTotal:") then
                    total = tonumber(line:match("(%d+)"))
                elseif line:match("^MemAvailable:") then
                    available = tonumber(line:match("(%d+)"))
                end

                if total and available then
                    break
                end
            end

            f:close()

            if total and available then
                local used = total - available
                local used_gb = used / 1048576
                cached_status = string.format("⇄ %2.0f G", used_gb)
            else
                cached_status = ""
            end
        else
            cached_status = ""
        end

        last_update = current_time
    end

    return cached_status
end

return M
