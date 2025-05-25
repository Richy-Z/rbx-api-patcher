local get_module = loadstring(game:HttpGet("https://raw.githubusercontent.com/andromeda-oss/rbx-api-patcher/main/module_helper.lua"))()
local get_gc = loadstring(game:HttpGet(get_module("getgc")))()

getgenv().getgc = get_gc

function my_global_func()
    print("Hello from global function")
end

task.wait(0.05)

for _, value in pairs(getgc()) do
    if value == my_global_func then
        print("✅ Found my_global_func (global)")
    end
end