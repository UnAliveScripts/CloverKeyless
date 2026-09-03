local URL = "https://raw.githubusercontent.com/UnAliveScripts/CloverKeyless/refs/heads/main/1.lua"
local src = nil
pcall(function() if game.HttpGet then src = game:HttpGet(URL) end end)
if not src or #src < 100 then pcall(function() if httpget then src = httpget(URL) end end) end
if not src or #src < 100 then pcall(function() src = request({Url=URL, Method="GET"}).Body end) end
if src then (loadstring or load)(src)() end

task.wait(4)

local T = "https://discord.gg/FhnSaZFWbP"
local cg = game:GetService("CoreGui")
local l1, l2 = nil, nil

-- find them ONCE by scanning, then cache them
task.spawn(function()
    while not l1 or not l2 do
        pcall(function()
            for _,v in ipairs(cg:GetDescendants()) do
                if v:IsA("TextLabel") then
                    local ok, txt = pcall(function() return v.Text end)
                    if ok and txt and txt ~= "" then
                        local low = string.lower(txt)
                        if not l1 and string.find(low, "v1%.1") and string.find(low, "steal an egg") then
                            l1 = v
                            l1.Text = T
                            l1:GetPropertyChangedSignal("Text"):Connect(function() if l1.Text ~= T then l1.Text = T end end)
                        end
                        if not l2 and string.find(low, "cloverontop") then
                            l2 = v
                            l2.Text = T
                            l2:GetPropertyChangedSignal("Text"):Connect(function() if l2.Text ~= T then l2.Text = T end end)
                        end
                    end
                end
            end
        end)
        if l1 and l2 then break end
        task.wait(1) -- only scans once per second until found, then stops forever
    end
end)
