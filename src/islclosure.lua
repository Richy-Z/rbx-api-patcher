local function islclosure(func)
    if typeof(func) ~= "function" then return false end

    local info = debug.getinfo(func)
    -- A Luau-compiled function typically has a `source` starting with "@"
    -- C functions may have "[C]" as their source
    return info and info.source and not info.source:find("^%[C%]")
end

return islclosure