local function getgc(includeTables)
    includeTables = includeTables or false

    local getregistry = getreg or (debug and debug.getregistry)
    local getupvalue = debug and debug.getupvalue
    if not getregistry then
        error("getgc failed: required function getreg or debug.getregistry not found")
    end
    if not getupvalue then
        error("getgc failed: required function debug.getupvalue not found")
    end

    local seen = {}
    local results = {}

    local function scan(obj)
        if seen[obj] then return end
        seen[obj] = true

        local t = typeof(obj)
        if (t == "table" and includeTables) or (t == "function" or t == "userdata") then
            table.insert(results, obj)
        end

        if t == "table" then
            for k, v in pairs(obj) do
                scan(k)
                scan(v)
            end
        elseif t == "function" then
            local i = 1
            while true do
                local name, val = getupvalue(obj, i)
                if not name then break end
                scan(val)
                i = i + 1
            end
        end
    end

    scan(getregistry())

    return results
end

return getgc
