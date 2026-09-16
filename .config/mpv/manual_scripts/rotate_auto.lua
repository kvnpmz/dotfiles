local mp = require "mp"
local options = require "mp.options"

local opts = {
    transpose = 2
}

options.read_options(opts, "rotate_auto")

local last_state = nil
local changing = false

local function auto_rotate()
    if changing then
        return
    end

    local width = mp.get_property_number("width")
    local height = mp.get_property_number("height")

    if not width or not height then
        return
    end

    local should_rotate = height > width

    mp.msg.info("Video size: " .. width .. "x" .. height)

    if should_rotate ~= last_state then
        changing = true

        if should_rotate then
            mp.commandv(
                "vf",
                "set",
                "format=nv12,lavfi=[transpose=" .. opts.transpose .. ",scale=iw:ih]"
            )

            mp.osd_message("Auto rotate")
        else
            mp.commandv("vf", "set", "")

            mp.osd_message("Auto rotate: off")
        end

        last_state = should_rotate

        -- allow future reconfigs
        mp.add_timeout(0.2, function()
            changing = false
        end)
    end
end

mp.register_event("video-reconfig", auto_rotate)

mp.register_event("file-loaded", function()
    last_state = nil
end)
