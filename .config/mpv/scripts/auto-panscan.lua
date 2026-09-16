mp.register_event("video-reconfig", function()
    local vw = mp.get_property_number("video-params/w")
    local vh = mp.get_property_number("video-params/h")
    local ww = mp.get_property_number("osd-width")
    local wh = mp.get_property_number("osd-height")

    if vw and vh and ww and wh then
        if vw < ww or vh < wh then
            mp.set_property_number("panscan", 1)
        else
            mp.set_property_number("panscan", 0)
        end
    end
end)
