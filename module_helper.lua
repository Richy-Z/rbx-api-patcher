local src = "https://raw.githubusercontent.com/andromeda-oss/rbx-api-patcher/main/src/"
local function get_module(module)
    return src .. module .. ".lua"
end

return get_module