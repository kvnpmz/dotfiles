local M = {}

local helper = require("helpers")

function M.get()
    local tags_line = helper.command([[
        argenctl context list --json | jq -r '
            ["browser", "terminal", "files", "general"] as $names |
            "tags " + ([
                $names[] as $n |
                (.[] | select(.name == $n)) |
                (if .current then "*" else "" end)
            ] | join(","))
        '
    ]])

    if not tags_line or tags_line == "" then
        return "tags argen_offline"
    end

    return tags_line:gsub("%s+$", "")
end

return M
