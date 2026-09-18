local M = {}

local helper = require("helpers")

local last_update = -1
local cached_world_time = nil
local cached_date_str = nil

function M.update(current_time)
    if current_time ~= last_update then
        cached_world_time = helper.command_line(
            "/home/kevin/bin/worldclock 2>/dev/null"
        )

        if not cached_world_time or cached_world_time == "" then
            cached_world_time = os.date("%H:%M")
        end

        local raw_date = helper.command_line(
            "date +'%A, %d %B' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2)); print}'"
        ) or os.date("%A, %d %B")

        local display_width = helper.display_width(raw_date)
        local date_width = 40
        local padding_needed = math.max(0, date_width - display_width)

        cached_date_str =
            string.rep(" ", padding_needed) .. raw_date

        last_update = current_time
    end

    return cached_world_time, cached_date_str
end

return M
