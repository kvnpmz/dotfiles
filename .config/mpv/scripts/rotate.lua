local mp = require "mp"

local rotation = 0
local flipped = false

mp.add_forced_key_binding("r", "rotate-video-reverse", function()
    rotation = (rotation - 90 + 360) % 360
    mp.set_property_number("video-rotate", rotation)
    mp.osd_message("Rotation: " .. rotation .. "°")
end)

mp.add_forced_key_binding("ALT+r", "rotate-video", function()
    rotation = (rotation + 90) % 360
    mp.set_property_number("video-rotate", rotation)
    mp.osd_message("Rotation: " .. rotation .. "°")
end)

mp.add_forced_key_binding("ALT+h", "horizontal-flip", function()
    flipped = not flipped

    if flipped then
        mp.commandv("vf", "add", "format=nv12,hflip")
    else
        mp.commandv("vf", "remove", "format=nv12,hflip")
    end

    mp.osd_message("Mirror: " .. (flipped and "On" or "Off"))
end)

local rotation = 0

mp.add_key_binding("CTRL+r", "rotate-zoom", function()
    rotation = (rotation + 90) % 360

    mp.set_property_number("video-rotate", rotation)

    if rotation == 90 or rotation == 270 then
        mp.set_property_number("video-zoom", 1.6)
    else
        mp.set_property_number("video-zoom", 0)
    end

    mp.osd_message("Rotation: " .. rotation .. "°")
end)
