local helper = {}
local current_env = {}
local batch_buffer = {}

function helper.export(env)
    for k, v in pairs(env) do
        current_env[k] = v
    end
end

function helper.cmd(command, ...)
    local formatted = string.format(command, ...)
    table.insert(batch_buffer, formatted)
end

function helper.flush()
    if #batch_buffer == 0 then return end
    local prefix = ""
    for k, v in pairs(current_env) do
        prefix = prefix .. string.format("export %s='%s' && ", k, v)
    end
    os.execute(prefix .. table.concat(batch_buffer, " && \n"))
    batch_buffer = {}
end

function helper.start(commands)
    helper.flush()
    for _, d in ipairs(commands) do
        local cmd_str = d:match("%s*&%s*$") and d or (d .. " &")
        local prefix = ""
        for k, v in pairs(current_env) do
            prefix = prefix .. string.format("export %s='%s' && ", k, v)
        end
        os.execute(prefix .. cmd_str)
    end
end

function helper.bind_keys(bindings)
    for _, b in ipairs(bindings) do
        local flag = (b.mode == "repeat") and "--repeat normal" or "normal"
        if b.action == "window" then
            -- Window actions pass arguments directly without quotes
            helper.cmd('argenctl binding set %s %s %s %s', flag, b.key, b.action, b.value)
        else
            -- Exec and sh actions keep quotes for the command string
            helper.cmd('argenctl binding set %s %s %s "%s"', flag, b.key, b.action, b.value)
        end
    end
end

return helper
