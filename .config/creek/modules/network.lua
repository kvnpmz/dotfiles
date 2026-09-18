local M = {}

local last_update = -1
local cached_status = ""

function M.get(current_time)
    if current_time ~= last_update then
        local route_check =
            os.execute("ip route show default | grep -q 'dev'")

        if route_check == true or route_check == 0 then
            cached_status = "󰤨 "
        else
            cached_status = "󰤭 "
        end

        last_update = current_time
    end

    return cached_status
end

return M
