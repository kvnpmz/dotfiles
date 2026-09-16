#!/usr/bin/env luajit

local home = os.getenv("HOME")
package.path = package.path .. ";" .. home .. "/.config/creek/?"
local helper = require("helpers")
os.setlocale("", "time")

local last_cpu_time = 0
local cpu_usage = "󱐋 0 %"
local cpu_values = {}
local last_mem_time = -1
local cached_mem_status = ""
local last_battery_time = -1
local cached_battery = nil
local last_time_update = -1
local cached_world_time = nil
local cached_date_str = nil
local last_kb_layout_time = -1
local cached_kb_layout = ""
local last_vpn_time = -1
local cached_vpn_status = ""
local last_network_time = -1
local cached_network_str = ""

while true do
    local contexts_line = " "
    local context_output = helper.command(
        "argenctl context list --json | jq -r '[\"browser\", \"terminal\", \"files\", \"general\"] as $names | \" \" + ([$names[] as $n | if (map(select(.name == $n))[0].current // false) then \"\" else \"\" end] | join(\"  \"))'"
    )

    if context_output then
        contexts_line = context_output:gsub("%s+$", "")
    else
        contexts_line = "argen offline"
    end

    local current_time = helper.now()
    if current_time - last_cpu_time >= 2 then
        local prev_sample = helper.cpu_times()
        io.popen("sleep 0.05"):close()
        local curr_sample = helper.cpu_times()

        if prev_sample and curr_sample then
            local pct = helper.cpu_percent(prev_sample, curr_sample)

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

        last_cpu_time = current_time
    end

    if current_time ~= last_mem_time then
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
                cached_mem_status = string.format("⇄ %2.0f G", used_gb)
            else
                cached_mem_status = ""
            end
        else
            cached_mem_status = ""
        end

        last_mem_time = current_time
    end

    local mem_status = cached_mem_status

    local icons = {
        "󰁺", -- 20% (Empty)
        "󰁼", -- 40% (Low)
        "󰁿", -- 60% (Medium)
        "󰂁", -- 80% (High)
        "󰁹"  -- 100% (Full)
    }

    if current_time ~= last_battery_time then
        cached_battery = helper.battery()
        last_battery_time = current_time
    end

    local battery = cached_battery
    local battery_str = ""

    if battery then
        local bat_icon

        if battery.status == "Charging" or battery.status == "Full" or battery.status == "Not charging" then
            bat_icon = "󰂄" 
        else
            local index = math.floor((battery.capacity / 100) * (#icons - 1)) + 1
            index = math.max(1, math.min(index, #icons)) 
            bat_icon = icons[index]
        end

        battery_str = string.format("%s %d %%", bat_icon, battery.capacity)
    end

    if current_time ~= last_time_update then
        cached_world_time = helper.command_line("/home/kevin/bin/worldclock 2>/dev/null")
        if not cached_world_time or cached_world_time == "" then
            cached_world_time = os.date("%H:%M")
        end

        local raw_date = helper.command_line(
            "date +'%A, %d %B' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2)); print}'"
        ) or os.date("%A, %d %B")

        local display_width = helper.display_width(raw_date)
        local date_width = 40
        local padding_needed = math.max(0, date_width - display_width)
        cached_date_str = string.rep(" ", padding_needed) .. raw_date

        last_time_update = current_time
    end

    local world_time = cached_world_time
    local date_str = cached_date_str

    local brightness = "󰃠"

    if current_time ~= last_vpn_time then
        local vpn_check = os.execute("ip link show vpn_nl >/dev/null 2>&1")
        cached_vpn_status = (vpn_check == true or vpn_check == 0) and " 󰯄 " or " 󱎘 "
        last_vpn_time = current_time
    end

    local vpn_status = cached_vpn_status

    if current_time ~= last_network_time then
        local route_check = os.execute("ip route show default | grep -q 'dev'")

        if route_check == true or route_check == 0 then
            cached_network_str = "󰤨 "
        else
            cached_network_str = "󰤭 "
        end

        last_network_time = current_time
    end

    local network_str = cached_network_str

    if current_time ~= last_kb_layout_time then
        cached_kb_layout = helper.command_line("/home/kevin/bin/xkb_status 2>/dev/null") or ""
        last_kb_layout_time = current_time
    end

    local kb_layout = cached_kb_layout

    local vol_info = helper.command_line("wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null")
    local volume_str = ""
    if vol_info and vol_info:match("MUTED") then
        volume_str = string.format("󰝟 %3d %%", 0)
    elseif vol_info then
        local vol_float = tonumber(vol_info:match("%d+%.%d+"))
        if vol_float then
            local vol_pct = math.floor(vol_float * 100 + 0.5)
            volume_str = string.format("󰕾 %3d %%", vol_pct)
        else
            volume_str = string.format("󰕾 %3d %%", 0)
        end
    else
        volume_str = string.format("󰕾 %3d%%", 0)
    end

    local power = "󰐥 "

    local function nz(value)
        return value or ""
    end 

    local SPACER = "                "

    local final_output = string.format( "%s %s %s %s %s %s %s %s %s %s %s %s %s\n", 
        nz(contexts_line), 
        nz(cpu_usage), 
        nz(mem_status), 
        nz(battery_str), 
        nz(date_str), 
        nz(world_time), 
        SPACER, 
        nz(power),
        nz(network_str), 
        nz(volume_str), 
        nz(brightness), 
        nz(vpn_status), 
        nz(kb_layout)
    )

    io.write(final_output)
    io.flush()

    io.popen("sleep 0.05"):close()
end

