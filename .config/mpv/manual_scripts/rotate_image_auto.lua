local mp = require "mp"
local options = require "mp.options"

local opts = {
    transpose = 2
}

options.read_options(opts, "rotate_image_auto")

local function auto_rotate_image()
    local width = mp.get_property_number("width")
    local height = mp.get_property_number("height")

    if not width or not height then
        return
    end

    if height > width then
        mp.commandv(
            "vf",
            "set",
            "format=nv12,transpose=" .. opts.transpose
        )

        mp.osd_message("Image Auto Rotate: On")
        mp.msg.info(
            "Image is vertical (" .. width .. "x" .. height .. "), rotating."
        )
    else
        mp.commandv("vf", "set", "")
        mp.osd_message("Image Auto Rotate: Off")
        mp.msg.info(
            "Image is horizontal (" .. width .. "x" .. height .. "), normal."
        )
    end
end

mp.register_event("file-loaded", auto_rotate_image)
