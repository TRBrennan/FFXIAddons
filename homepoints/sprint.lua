packets = require('packets')
windower.register_event('incoming chunk',function(id,original,modified,is_blocked,is_injected)
    if id == 0x34 then
        --local index = original:byte(0x28)+original:byte(0x29))
        local packet = packets.parse('incoming', original)
        if windower.ffxi.get_mob_by_index(packet['NPC Index']).name:startswith('Home Point') then
            if windower.ffxi.get_items().gil == original:byte(0x1D)+original:byte(0x1E)*256+original:byte(0x1F)*256^2+original:byte(0x20)*256^3 then
                return original:sub(1,12)..string.char(0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF)..original:sub(28,32)..string.char(0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF)..original:sub(41)	
            end
        elseif windower.ffxi.get_mob_by_index(packet['NPC Index']).name == 'Survival Guide' then
            if windower.ffxi.get_items().gil == original:byte(0x11)+original:byte(0x12)*256+original:byte(0x13)*256^2+original:byte(0x14)*256^3 then
            return original:sub(1,20)..string.char(0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF)..original:sub(41)
            end
        elseif windower.ffxi.get_mob_by_index(packet['NPC Index']).name == 'Waypoint' then
            print(original:byte(0x0B)+original:byte(0x0C)*256)
            --original:sub(1,12)..string.char()..original:sub(41)
        end
    end
end)
-- original:sub(36)
-- home points : byte(0x24) populates current area and excludes current hp
-- home points : byte(0x26) 01 registers new hp, 00 not new hp
-- return original:sub(1,12)..string.char(0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF)..original:sub(25,32)..string.char(0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF)..original:sub(41)