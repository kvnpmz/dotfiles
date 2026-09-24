local M = {}

local helper = require("helpers")

local last_update = -1
local cached_battery = nil

local icons = {
    "󰁺", -- 20%
    "󰁼", -- 40%
    "󰁿", -- 60%
    "󰂁", -- 80%
    "󰁹", -- 90%
}

function M.get(current_time)
    if current_time ~= last_update then
        cached_battery = helper.battery()
        last_update = current_time
    end

    if not cached_battery then
        return ""
    end

    local battery = cached_battery
    local icon

    if battery.status == "Charging"
        or battery.status == "Full"
        or battery.status == "Not charging"
    then
        icon = "󰂄"
    else
        local cap = battery.capacity
        local index = 1
        if cap >= 90 then index = 5
        elseif cap >= 80 then index = 4
        elseif cap >= 60 then index = 3
        elseif cap >= 40 then index = 2
        end
        
        icon = icons[index]
    end

    return string.format("%s %3d %%", icon, battery.capacity)
end

return M
