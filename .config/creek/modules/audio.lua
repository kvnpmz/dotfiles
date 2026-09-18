local M = {}

function M.volume()
    local handle = io.popen(
        "wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null"
    )

    if not handle then
        return "󰕾   0%"
    end

    local vol_info = handle:read("*a")
    handle:close()

    if not vol_info or vol_info == "" then
        return "󰕾   0%"
    end

    if vol_info:match("MUTED") then
        return string.format("󰝟 %3d %%", 0)
    end

    local vol_float = tonumber(vol_info:match("%d+%.%d+"))

    if vol_float then
        local vol_pct = math.floor(vol_float * 100 + 0.5)
        return string.format("󰕾 %3d %%", vol_pct)
    end

    return string.format("󰕾 %3d %%", 0)
end

return M
