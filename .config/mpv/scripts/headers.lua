local sites = {
    ["pornhub"] = "https://pornnhub.com/",
    ["phncdn"] = "https://pornnhub.com/",
    ["pornzog"] = "https://pornzog.com/",
    ["darknessporn"] = "https://darknessporn.com/",
    ["yesporn"] = "https://yesporn.vip/",
    ["mat6tube"] = "https://mat6tube.com/",
    ["bigassporn"] = "https://bigassporn.tv/",
    ["eporner"] = "https://eporner.com/",
    ["tubeorigin"] = "https://tubeorigin.com/",
    ["pornve"] = "https://pornve.com/",
    ["noodlemagazine"] = "https://noodlemagazine.com/",
    ["dirtyship"] = "https://dirtyship.com/",
    ["porn00"] = "https://porn00.org/",
    ["cloudatacdn"] = "https://teencamrips.com/",
}

mp.add_hook("on_load", 10, function()
    local url = mp.get_property("path")

    for domain, referer in pairs(sites) do
        if url:find(domain, 1, true) then
            mp.set_property(
                "http-header-fields",
                "Referer: " .. referer .. "\r\nUser-Agent: Mozilla/5.0"
            )
            return
        end
    end
end)
