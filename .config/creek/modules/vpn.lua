local M = {}

local last_update = -1
local cached_status = ""

function M.get(current_time)
    if current_time ~= last_update then
        local vpn_check =
            os.execute("ip link show vpn_nl >/dev/null 2>&1")

        cached_status =
            (vpn_check == true or vpn_check == 0)
            and " 󰯄 "
            or " 󱎘 "

        last_update = current_time
    end

    return cached_status
end

return M
--[[
            and " 󰯄 "
            or " 󱎘 "
            --]]
