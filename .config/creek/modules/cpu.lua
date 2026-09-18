local M = {}

local helper = require("helpers")

local last_update = 0
local cpu_usage = "󱐋 0 %"
local cpu_values = {}

function M.get(current_time)
    if current_time - last_update >= 2 then
        local previous = helper.cpu_times()

        io.popen("sleep 0.05"):close()

        local current = helper.cpu_times()

        if previous and current then
            local pct = helper.cpu_percent(previous, current)

            table.insert(cpu_values, pct)

            if #cpu_values > 5 then
                table.remove(cpu_values, 1)
            end

            local total = 0

            for _, value in ipairs(cpu_values) do
                total = total + value
            end

            local average = total / #cpu_values
            cpu_usage = string.format(" 󱐋 %2.0f %%", average)
        else
            cpu_usage = " 󱐋 0 %"
        end

        last_update = current_time
    end

    return cpu_usage
end

return M
