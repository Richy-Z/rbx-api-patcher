local function islclosure(func)
    if typeof(func) ~= "function" then return false end

    local info = debug.getinfo(func)
    return info and info.what ~= "C"
end

return islclosure