local get_module = loadstring(game:HttpGet("https://raw.githubusercontent.com/andromeda-oss/rbx-api-patcher/main/module_helper.lua"))()
local is_l_closure = loadstring(game:HttpGet(get_module("islclosure")))()

getgenv().islclosure = is_l_closure

local function a() end
local b = function() end

local c = print

print("a is Luau:", islclosure(a))
print("b is Luau:", islclosure(b))
print("c is Luau:", islclosure(c))
