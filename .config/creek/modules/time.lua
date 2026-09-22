local M = {}

local helper = require("helpers")

local last_update = -1
local cached_world_time = nil
local cached_date_str = nil

function M.update(current_time)
    if current_time == last_update then
        return cached_world_time, cached_date_str
    end

    local worldclock = helper.command_line(
        "/home/kevin/bin/worldclock 2>/dev/null"
    )

    local world_time, city_name, world_date

    if worldclock and worldclock ~= "" then
        world_time, city_name, world_date =
            worldclock:match("^([^|]+)|([^|]+)|(.+)$")
    end

    if world_time and city_name and world_date then
        cached_world_time = world_time .. " " .. city_name

        local padding = math.max(
            0,
            44 - helper.display_width(world_date)
        )

        cached_date_str = string.rep(" ", padding) .. world_date
    else
        cached_world_time = os.date("%H:%M:%S")
        cached_date_str = os.date("%A, %d %B %Y")
    end

    last_update = current_time

    return cached_world_time, cached_date_str
end

return M

