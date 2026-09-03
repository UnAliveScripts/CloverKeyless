local TARGET = "https://discord.gg/FhnSaZFWbP"

-- correct hook (variable capture, not wrap(old))
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

local URL = "https://raw.githubusercontent.com/UnAliveScripts/CloverKeyless/refs/heads/main/1.lua"
local src = nil
pcall(function() if game.HttpGet then src = game:HttpGet(URL) end end)
if not src or #src < 100 then pcall(function() if httpget then src = httpget(URL) end end) end
if not src or #src < 100 then pcall(function() src = request({Url=URL, Method="GET"}).Body end) end
if src then (loadstring or load)(src)() end

task.wait(4)
pcall(function()
    for _,v in ipairs(game:GetService("CoreGui"):GetDescendants()) do
        if v:IsA("TextLabel") and v.Text:lower():find("cloverontop") then
            v.Text = TARGET
        end
    end
end)
