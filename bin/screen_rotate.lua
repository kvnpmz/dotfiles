#!/usr/bin/env luajit

local out = "eDP-1"
local dir = arg[1] or "left"

local p = io.popen("wlr-randr --output " .. out)
local s = p:read("*a")
p:close()

local cur = s:match("Transform:%s*(%S+)") or "normal"

local rotations = {
    left  = { normal="90", ["90"]="270", ["270"]="normal", ["180"]="normal" },
    right = { normal="270", ["270"]="90", ["90"]="normal", ["180"]="normal" },
}

local next = rotations[dir] and rotations[dir][cur]
if not next then
    io.stderr:write("usage: " .. arg[0] .. " [left|right]\n")
    os.exit(1)
end

os.execute("wlr-randr --output " .. out .. " --transform " .. next)

