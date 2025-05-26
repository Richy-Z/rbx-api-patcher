local function islclosure(func)
    if typeof(func) ~= "function" then return false end

    local info = debug.getinfo(func, "S")
    return info and info.what == "Lua"
end

return islclosure