local _, MB = ...

function MB.get_spellid(spellname)
    local _,_,_,_,_,_, spellid = GetSpellInfo(spellname)
    return spellid
end

function MB.get_cd_table(tab)
    -- get table that maps spellid:cd
    local cd_table = {}
    local tabname, tabicon, offset, num, _, _ = GetSpellTabInfo(tab)
    local i = 1
    for spellnum = offset + 1, offset + num do
        --local realspellnum = GetKnownSlotFromHighestRankSlot(spellnum)
        local spellname, spellSubName = GetSpellBookItemName(spellnum, BOOKTYPE_SPELL)
        local spellid = MB.get_spellid(spellname)
        local cd, gcd = GetSpellBaseCooldown(spellname)
        if cd and cd > 0 then
            cd_table[spellid] = cd
        end
    end
    return cd_table
end

function MB.update_table(table1, table2)
    -- updates values from table with values from table2
    new_table = {}
    for k,v in pairs(table1) do
        new_table[k] = v
    end
    for k,v in pairs(table2) do
        new_table[k] = v
    end
    return new_table
end

function MB.place_spells(cds)
    local slot = 1
    local sorted = {}
    local values_list = {}
    local values_set = {}
    for spellid, cd in pairs(cds) do
        if not values_set[cd] then
            table.insert(values_list, cd)
            values_set[cd] = true
        end
        spellids = sorted[cd]
        if spellids then
            table.insert(spellids, spellid)
        else
            sorted[cd] = {spellid}
        end
    end
    table.sort(values_list)
    for i = #values_list, 1, -1 do
        cd = values_list[i]
        local spellids = sorted[cd]
        for _, spellid in pairs(spellids) do
            print(GetSpellLink(spellid), spellid, cd)
            PickupSpell(spellid)
            PlaceAction(slot)
            slot = slot + 1
        end
    end
end
