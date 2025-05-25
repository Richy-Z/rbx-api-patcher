local get_module = loadstring(game:HttpGet("https://raw.githubusercontent.com/andromeda-oss/rbx-api-patcher/main/module_helper.lua"))()

local function filtergc(filterType, filterOptions, returnOne)
    local getgc = getgenv().getgc
    local islclosure = getgenv().islclosure
    if not getgc then
        local success, result = pcall(function()
            return loadstring(game:HttpGet(get_module("getgc")))()
        end)
        if not success then
            error("filtergc: failed to load getgc from module")
        end
        getgc = result
        getgenv().getgc = getgc
    end
    if not islclosure then
        local success, result = pcall(function()
            return loadstring(game:HttpGet(get_module("islclosure")))()
        end)
        if not success then
            error("filtergc: failed to load islclosure from module")
        end
        islclosure = result
        getgenv().islclosure = islclosure
    end

    local includeTables = filterType == "table"
    local results = {}

    for _, obj in ipairs(getgc(includeTables)) do
        if filterType == "function" and typeof(obj) == "function" then
            if filterOptions.IgnoreExecutor ~= false and islclosure and not islclosure(obj) then
                continue
            end

            if filterOptions.Name and debug.getinfo(obj).name ~= filterOptions.Name then
                continue
            end

            if filterOptions.Constants then
                local getconstants = debug.getconstants
                if not getconstants then continue end
                local constants = getconstants(obj)
                for _, required in ipairs(filterOptions.Constants) do
                    if not table.find(constants, required) then
                        continue
                    end
                end
            end

            if filterOptions.Upvalues then
                local match = true
                for _, v in ipairs(filterOptions.Upvalues) do
                    local found = false
                    for i = 1, debug.getinfo(obj).nups or 0 do
                        local _, upv = debug.getupvalue(obj, i)
                        if upv == v then
                            found = true
                            break
                        end
                    end
                    if not found then
                        match = false
                        break
                    end
                end
                if not match then continue end
            end

            if returnOne then return obj end
            table.insert(results, obj)

        elseif filterType == "table" and typeof(obj) == "table" then
            local match = true
            local opts = filterOptions

            if opts.Keys then
                for _, k in ipairs(opts.Keys) do
                    if obj[k] == nil then match = false break end
                end
            end

            if opts.Values then
                for _, v in ipairs(opts.Values) do
                    local found = false
                    for _, val in pairs(obj) do
                        if val == v then found = true break end
                    end
                    if not found then match = false break end
                end
            end

            if opts.KeyValuePairs then
                for k, v in pairs(opts.KeyValuePairs) do
                    if obj[k] ~= v then match = false break end
                end
            end

            if opts.Metatable and getmetatable(obj) ~= opts.Metatable then
                match = false
            end

            if match then
                if returnOne then return obj end
                table.insert(results, obj)
            end
        end
    end

    return results
end

return filtergc