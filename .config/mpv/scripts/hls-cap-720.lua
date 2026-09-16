local function select_video()
    local tracks = mp.get_property_native("track-list")

    local best_id = nil

    for _, t in ipairs(tracks) do
        if t.type == "video" then
            -- cap at the 720p slot
            if t.id <= 4 then
                if not best_id or t.id > best_id then
                    best_id = t.id
                end
            end
        end
    end

    if best_id then
        mp.set_property_number("vid", best_id)
    end
end

mp.register_event("file-loaded", function()
    mp.add_timeout(10, select_video)
end)
