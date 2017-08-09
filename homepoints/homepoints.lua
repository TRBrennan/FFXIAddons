-- Make this file's filepath ../addons/homepoints/homepoints.lua
-- Load it (//lua l homepoints), use whatever homepoint you want,
-- and then I recommend unloading it if you're going to do something else.

require 'pack'

windower.register_event('incoming chunk',function(id,original,modified,is_blocked,is_injected)
    if  id == 0x34 then
        if windower.ffxi.get_mob_by_id(original:unpack("I",5)).name:sub(1,10) == "Home Point" and windower.ffxi.get_items().gil == original:byte(0x1D)+original:byte(0x1E)*256+original:byte(0x1F)*256^2+original:byte(0x20)*256^3 then
            -- Need to fix this so the current Region and favorites are preserved
            return original:sub(1,12)..string.char(0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF)..original:sub(29,32)..string.char(0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFA,0xFF)..original:sub(41)
        elseif windower.ffxi.get_mob_by_id(original:unpack("I",5)).name:sub(1,8) == "Waypoint" then
            -- Block the "Somewhere" Enigmatic Device
            return original:sub(1,12)..string.char(0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF)..original:sub(41)
        elseif windower.ffxi.get_mob_by_id(original:unpack("I",5)).name:sub(1,14) == "Proto-Waypoint" then
            return original:sub(0x01,0x0C)..string.char(0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF)..original:sub(0x15,0x1C)..string.char(0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF)..original:sub(0x29)
        elseif windower.ffxi.get_mob_by_id(original:unpack("I",5)).name:sub(1,14) == "Survival Guide" then
            -- Are favorites preserved?
            return original:sub(1,20)..string.char(0xFF):rep(20)..original:sub(41)
        end
    end
end)