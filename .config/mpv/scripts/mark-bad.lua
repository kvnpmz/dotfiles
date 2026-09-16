local mp = require "mp"

local bad_file = os.getenv("HOME") .. "/.config/mpv/bad-audio.txt"

mp.add_key_binding("ctrl+b", "mark-bad-audio", function()
    local path = mp.get_property("path")

    if not path then
        mp.osd_message("No file is currently playing", 2)
        return
    end

    local audio_id = mp.get_property("aid") or "none"
    local audio_codec = mp.get_property("audio-codec-name") or "unknown"
    local time_pos = mp.get_property_number("time-pos") or 0

    local f = io.open(bad_file, "a")

    if not f then
        mp.osd_message("ERROR: Could not open bad-audio.txt", 3)
        return
    end

    f:write(string.format(
        "%s\taudio-track=%s\tcodec=%s\tposition=%.2f\n",
        path,
        audio_id,
        audio_codec,
        time_pos
    ))

    f:close()

    mp.osd_message(
        string.format("⚠ BAD AUDIO — track %s marked", audio_id),
        3
    )
end)
