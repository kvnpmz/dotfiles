local M = {}

--local cached_context = "*,,,"
local cached_context = ""

function M.get()
    local f = io.open("/tmp/argen_contexts", "r")
    if f then
        local val = (f:read("*all") or ""):gsub("%s+$", "")
        f:close()
        if val ~= "" then
            cached_context = val
        end
    end
    return cached_context
end

return M

