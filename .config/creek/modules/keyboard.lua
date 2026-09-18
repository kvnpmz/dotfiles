local M = {}

local helper = require("helpers")

local last_update = -1
local cached_layout = ""

function M.get(current_time)
    if current_time ~= last_update then
        cached_layout =
            helper.command_line(
                "/home/kevin/bin/xkb_status 2>/dev/null"
            ) or ""

        last_update = current_time
    end

    return cached_layout
end

return M
