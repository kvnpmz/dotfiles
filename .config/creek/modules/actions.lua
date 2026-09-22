local M = {}

M.click = {
    ["󰐥"] = "/home/kevin/bin/power_menu &",
 
    ["󰖟"] = "/home/kevin/bin/timezone_change &",

    ["󰕾"] = "wpctl set-mute @DEFAULT_SINK@ toggle &",
    ["󰝟"] = "wpctl set-mute @DEFAULT_SINK@ toggle &",

    ["󰯄"] = "/home/kevin/bin/vpn &",
    ["󱎘"] = "/home/kevin/bin/vpn &",
}

M.scroll = {
    ["󰕾:up"]   = "wpctl set-volume @DEFAULT_SINK@ --limit 1.0 '5%+'",
    ["󰕾:down"] = "wpctl set-volume @DEFAULT_SINK@ '5%-'",

    ["󰃠:up"]   = "brightnessctl set +5%",
    ["󰃠:down"] = "brightnessctl set 5%-",
}

return M
