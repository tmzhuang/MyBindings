local _, MB = ...

function MB.get_spellid(spellname)
    local _,_,_,_,_,_, spellid = GetSpellInfo(spellname)
    return spellid
end

function MB.pickup_item(search)
    if not InCombatLockdown() then
        for bag = 0,4 do
            for slot = 1,GetContainerNumSlots(bag) do
                local item = GetContainerItemLink(bag,slot)
                if item and item:find(search) then
                    ClearCursor()
                    PickupContainerItem(bag, slot)
                    return bag, slot
                end
            end
        end
    end
    return nil, nil
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

function MB.place_action(type_, id, slot)
    local picked_up = true
    if type_ == 'spell' then
        PickupSpell(id)
    elseif type_ == 'item' then
        local bag, container_slot = MB.pickup_item(id)
    elseif type_ == 'inv' then
        ClearCursor()
        PickupInventoryItem(id)
    else
        picked_up = false
    end

    if picked_up then
        PlaceAction(slot)
        ClearCursor()
    end
end

function MB.place_spells(cds, max, bar, reverse)
    if not max then max = 9 end
    local slot = 1
    if bar then slot = 12 * bar end
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
            if cd > 0 then
                print('Placing spell', GetSpellLink(spellid), 'in slot', slot)
                MB.place_action('spell', spellid, slot)
                if reverse then
                    slot = slot - 1
                    if ((slot % 12 - 1) > max) then
                        local bar = math.floor(slot/12)
                        slot = (bar - 1) * 12 + max
                    end
                else
                    slot = slot + 1
                    if ((slot % 12 - 1) > max) then
                        local bar = math.floor(slot/12)
                        slot = (bar + 1) * 12 + 1
                    end
                end
            end
        end
    end
    return slot
end

MB.racial_spell = {
    goblin='Rocket Jump',
    ['blood elf']='Arcane Torrent',
    undead='Will of the Forsaken',
    troll='Berserking',
    ['dark iron dwarf']='Fireblood',
    draenei='Gift of the Naaru',
    dwarf='Stoneform',
    human='Will to Survive',
    ['kul tiran']='Haymaker', 
    ['lightforged draenei']="Light's Judgement",
}
