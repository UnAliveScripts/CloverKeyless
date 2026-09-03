-- CloverHub Patched Loader - PUBLIC VERSION
-- Host this file raw: loadstring(game:HttpGet("https://raw.githubusercontent.com/YOURNAME/YOURREPO/main/CloverHub_Patched.lua"))()

local TARGET = "https://discord.gg/FhnSaZFWbP"

-- 0. PATCH SOURCE BEFORE LOADSTRING (baked in - survives Auto Load/Config)
pcall(function()
    local oldHttp
    oldHttp = hookfunction(game.HttpGet, function(self, url, ...)
        local src = oldHttp(self, url, ...)
        if type(src)=="string" and url:find("CloverKeyless") then
            src = src:gsub("discord%.gg/CloverOnTop", "discord.gg/FhnSaZFWbP")
            src = src:gsub("discord%.gg%/[Cc]loverOnTop", "discord.gg/FhnSaZFWbP")
        end
        return src
    end)
end)
pcall(function()
    if httpget and hookfunction then
        local old2
        old2 = hookfunction(httpget, function(url, ...)
            local src = old2(url, ...)
            if type(src)=="string" and url:find("CloverKeyless") then
                src = src:gsub("discord%.gg/CloverOnTop", "discord.gg/FhnSaZFWbP")
            end
            return src
        end)
    end
end)

-- 1. hook copy BEFORE load
pcall(function()
    local old
    old = hookfunction(setclipboard, function(s)
        if type(s)=="string" then
            local low = string.lower(s)
            if low:find("cloverontop") or (low:find("discord%.gg") and low:find("clover")) or s=="discord.gg/CloverOnTop" then
                s = TARGET
            end
        end
        return old(s)
    end)
end)
pcall(function()
    local old2
    old2 = hookfunction(toclipboard, function(s)
        if type(s)=="string" and string.lower(s):find("clover") then s = TARGET end
        return old2(s)
    end)
end)

-- 2. load Clover (only once)
local URL = "https://raw.githubusercontent.com/UnAliveScripts/CloverKeyless/refs/heads/main/1.lua"
local src = nil
pcall(function() if game.HttpGet then src = game:HttpGet(URL) end end)
if not src or #src < 100 then pcall(function() if httpget then src = httpget(URL) end end) end
if not src or #src < 100 then pcall(function() src = request({Url=URL, Method="GET"}).Body end) end
if src then (loadstring or load)(src)() end

task.wait(4)

-- 3. edit texts (find once, cache, no lag)
local cg = game:GetService("CoreGui")
local l1, l2 = nil, nil

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
                            l1.Text = TARGET
                            l1:GetPropertyChangedSignal("Text"):Connect(function() if l1.Text ~= TARGET then l1.Text = TARGET end end)
                        end
                        if not l2 and string.find(low, "cloverontop") then
                            l2 = v
                            l2.Text = TARGET
                            l2:GetPropertyChangedSignal("Text"):Connect(function() if l2.Text ~= TARGET then l2.Text = TARGET end end)
                        end
                    end
                end
            end
        end)
        if l1 and l2 then break end
        task.wait(1)
    end
end)
