local M = {}


function M.read_file(path)
    local f = io.open(path, "r")
    if not f then
        return nil
    end

    local value = f:read("*a")
    f:close()

    return value
end

function M.read_line(path)
    local f = io.open(path, "r")
    if not f then
        return nil
    end

    local value = f:read("*l")
    f:close()

    return value
end

function M.file_exists(path)
    local f = io.open(path, "r")
    if not f then
        return false
    end

    f:close()
    return true
end


function M.command(cmd)
    local handle = io.popen(cmd .. " 2>/dev/null")
    if not handle then
        return nil
    end

    local output = handle:read("*a")
    handle:close()

    if not output or output == "" then
        return nil
    end

    return output
end

function M.command_line(cmd)
    local output = M.command(cmd)

    if not output then
        return nil
    end

    return output:gsub("%s+$", "")
end


function M.trim(s)
    if not s then
        return nil
    end

    return s:gsub("^%s+", ""):gsub("%s+$", "")
end

function M.split(s, separator)
    local result = {}

    if not s then
        return result
    end

    separator = separator or "%s"

    for value in s:gmatch("([^" .. separator .. "]+)") do
        result[#result + 1] = value
    end

    return result
end


function M.now()
    return os.time()
end

function M.time_string(format)
    return os.date(format or "%H:%M")
end


function M.cpu_times()
    local line = M.read_line("/proc/stat")

    if not line then
        return nil
    end

    local user, nice, system, idle, iowait =
        line:match("^cpu%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s*(%d*)")

    if not user then
        return nil
    end

    user = tonumber(user)
    nice = tonumber(nice)
    system = tonumber(system)
    idle = tonumber(idle)
    iowait = tonumber(iowait) or 0

    local used = user + nice + system
    local total = used + idle + iowait

    return {
        used = used,
        total = total,
    }
end

function M.cpu_percent(previous, current)
    if not previous or not current then
        return 0
    end

    local used_delta = current.used - previous.used
    local total_delta = current.total - previous.total

    if total_delta <= 0 then
        return 0
    end

    return math.floor((used_delta * 100 / total_delta) + 0.5)
end


function M.battery()
    local base = "/sys/class/power_supply/BAT0"

    if not M.file_exists(base .. "/capacity") then
        return nil
    end

    local capacity = M.read_line(base .. "/capacity")
    local status = M.read_line(base .. "/status")

    if not capacity then
        return nil
    end

    return {
        capacity = tonumber(capacity) or 0,
        status = status or "Unknown",
    }
end


function M.percent(icon, value, width)
    width = width or 3
    return string.format("%s %%%dd%%", icon, width):format(value)
end

function M.display_width(s)
    if not s then
        return 0
    end

    local output = M.command_line(
        "printf '%s' " .. string.format("%q", s) .. " | wc -L"
    )

    return tonumber(output) or #s
end

return M

