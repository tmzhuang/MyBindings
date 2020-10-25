local _, MB = ...

function delete_item(search)
    if not InCombatLockdown() then
        for bag = 0,4 do
            for slot = 1,GetContainerNumSlots(bag) do
                local item = GetContainerItemLink(bag,slot)
                if item and item:find(search) then
                    print('Deleting', search)
                    PickupContainerItem(bag, slot)
                    DeleteCursorItem()
                end
            end
        end
    end
end

function MB.get_mage_data()
    local spells = {}
    local items = {}
    local macros = {}
    local unbound_macros = {}
    spells['2'] = 'Time Warp'
    spells['3'] = 'Mirror Image'
    spells['4'] = 'Alter Time'
    spells['shift-='] = 'Conjure Refreshment'
    spells['w'] = 'Frost Nova'
    spells['shift-e'] = 'Rune of Power'
    spells['r'] = 'Blink'
    spells['shift-t'] = 'Spellsteal'
    spells['a'] = 'Arcane Explosion'
    spells['x'] = 'Ice Block'
    spells['shift-j'] = 'Arcane Explosion'

    items['0'] = 'Hearthstone'

    macros['5'] = [[
/use [nomod] Polymorph; [mod:shift, @focus] Polymorph
]]
    macros['='] = [[
/use item:34062
/use item:43518
/use item:43523
/use item:65499
/use item:65500
/use item:65515
/use item:65516
/use item:65517
/use item:80610
/use item:80618
/use item:113509
    ]]
    SetBinding('SHIFT-V')
    SetBinding('CTRL-V')
    macros['v'] = [[
/use [nomod] Counterspell; [mod:shift, @focus] Counterspell
    ]]
    macros['q'] = [[
/use [spec:1] Greater Invisibility
/use [spec:2] Invisibility
/use [spec:3] Invisibility
    ]]
    macros['shift-w'] = [[
/cast [nopet] Summon Water Elemental
/stop macro [nopet]
/petpassive
/use Freeze
    ]]
    macros['alt-w'] = [[
/use Waterbolt
    ]]
    macros['g'] = [[
/use [spec:1,nomod] Arcane Blast; [spec:1,mod:shift] Frostbolt
/use [spec:2,nomod] Fireball; [spec:1,mod:shift] Frostbolt
/use [spec:3,nomod] Frostbolt; [spec:3,mod:alt] Glacial Spike; [spec:3,mod:shift] Ebonbolt
    ]]
    macros['e'] = [[
/use [spec:1] Touch of the Magi
/use [spec:2] Dragon's Breath
/use [spec:3] Cold Snap
    ]]
    macros['t'] = [[
/use [spec:1] Arcane Missiles
/use [spec:2] Pyroblast
/use [spec:3] Flurry
    ]]
    macros['y'] = [[
/use [spec:1] Presence of Mind
/use [spec:2] Flamestrike
/use [spec:3,nomod] Blizzard; [spec:3,mod:shift] Ring of Frost
    ]]
    macros['alt-s'] = [[
/run C_MountJournal.SummonByID(0)
    ]]
    --/run if not InCombatLockdown()then for b=0,4 do for s=1,36 do n=GetContainerItemLink(b,s)print(n, n=='Mana Gem')DeleteCursorItem()end;end;end;end;
    macros['alt-d'] = [[
/run delete_item("Mana Gem")
/use [spec:1,nocombat]Conjure Mana Gem;Mana Gem
/use [spec:2]Meteor
/use [spec:3]Comet Storm
    ]]
    macros['shift-f'] = [[
/use [spec:1] Evocation
/use [spec:2] Greater Pyroblast
/use [spec:3] Frozen Orb
    ]]
    macros['alt-f'] = [[
/use [spec:3] Ray of Frost
    ]]
    macros['j'] = [[
/dismount
/stopcasting
/use [nomod,@player] Slow Fall; [mod:shift,@mouseover] Slow Fall
    ]]
    macros['z'] = [[
/use [spec:1,nomod] Arcane Barrage; [spec:1,mod:alt] Fire Blast
/use [spec:2,nomod] Ice Lance; [spec:2,mod:shift,@focus] Ice Lance; [spec:2,mod:alt] Fire Blast
/use [spec:3] Fire Blast
    ]]
    macros['c'] = [[
/use [spec:1,nomod] Slow; [spec:1;mod:shift,@focus] Slow
/use [spec:2] Scorch
/use [spec:3] Cone of Cold
    ]]
    -- middle mouse
    macros['numpad3'] = [[
/use [spec:1] Arcane Power
/use [spec:2] Combustion
/use [spec:3] Icy Veins
    ]]
    macros['shift-pagedown'] = [[
/use Every Man for Himself
/use Stoneform
/use Quaking Palm
/use Arcane Torrent
/use Gift of the Naaru
/use Escape Artist
/use Blood Fury
/use Will of the Forsaken
/use Berserking
/use Darkflight
/use Rocket Jump
/use Shadowform
/use War Stomp
    ]]
    -- dpi down
    macros['numpad4'] = [[
/use [@mouseover,help] Arcane Intellect; [@player] Arcane Intellect
    ]]
    -- thumb 1
    macros['numpad1'] = [[
/use Alter Time
    ]]
    -- thumb 2
    macros['numpad2'] = [[
/focus [@mouseover,harm,nodead]; [@target,harm,nodead]
#/run SetRaidTarget("focus",7)
    ]]
    macros['shift-down'] = [[
/target focus
/targetlasttarget
/focus
/targetlasttarget
#/run SetRaidTarget("target",8)
#/run SetRaidTarget("focus",7)
    ]]
    macros['alt-numpad2'] = [[
/clearfocus
    ]]
    -- dpi up
    macros['numpad5'] = [[
/use [spec:1, nomod] Prismatic Barrier
/use [spec:2, nomod] Blazing Barrier
/use [spec:3, nomod] Ice Barrier
/use [mod:shift] Frost Ward
/use [mod:alt] Frost Ward
    ]]
    print('Rebound mage keys.')
    return spells, items, macros, unbound_macros
end

-- thumb1: 1/end
-- thumb2: 2/down
-- middle: 3/pagedown
-- dpi down: 4/left
-- dpi up: 6/right
--# Fire
--Living Bomb

--# Frost
--Ice Floes
--Ice Nova

--# Other macros/items
--Trinket
--Potion
--Portals
--Mount

--# Baseline
--[Alter Time]
--R[Covenant signature]
--[Covenant spell]
function MB.get_mage_noob_data()
    local spells = {}
    local items = {}
    local macros = {}
    local unbound_macros = {}
    spells['shift-='] = 'Conjure Refreshment'
    spells['w'] = 'Frost Nova'
    spells['r'] = 'Blink'
    spells['a'] = 'Arcane Explosion'
    spells['g'] = 'Frostbolt'
    spells['z'] = 'Fire Blast'
    macros['5'] = [[
/use [nomod] Polymorph; [mod:shift, @focus] Polymorph
]]
    macros['='] = [[
/use item:34062
/use item:43518
/use item:43523
/use item:65499
/use item:65500
/use item:65515
/use item:65516
/use item:65517
/use item:80610
/use item:80618
/use item:113509
    ]]
    SetBinding('SHIFT-V')
    SetBinding('CTRL-V')
    macros['v'] = [[
/use [nomod] Counterspell; [mod:shift, @focus] Counterspell
    ]]
    macros['j'] = [[
/dismount
/stopcasting
/use [nomod,@player] Slow Fall; [mod:shift,@mouseover] Slow Fall
    ]]
    macros['shift-pagedown'] = [[
/use Every Man for Himself
/use Stoneform
/use Quaking Palm
/use Arcane Torrent
/use Gift of the Naaru
/use Escape Artist
/use Blood Fury
/use Will of the Forsaken
/use Berserking
/use Darkflight
/use Rocket Jump
/use Shadowform
/use War Stomp
    ]]
    -- dpi down
    macros['numpad4'] = [[
/use [@mouseover,help] Arcane Intellect; [@player] Arcane Intellect
    ]]
    -- thumb 2
    macros['numpad2'] = [[
/focus [@mouseover,harm,nodead]; [@target,harm,nodead]
#/run SetRaidTarget("focus",7)
    ]]
    macros['shift-down'] = [[
/target focus
/targetlasttarget
/focus
/targetlasttarget
#/run SetRaidTarget("target",8)
#/run SetRaidTarget("focus",7)
    ]]
    macros['alt-numpad2'] = [[
/clearfocus
    ]]
    print('Rebound mage_noob keys.')
    return spells, items, macros, unbound_macros
end

local function get_cd_table(tab)
    local cd_table = {}
    local tabname, tabicon, offset, num, _, _ = GetSpellTabInfo(tab)
    local i = 1
    for spellnum = offset + 1, offset + num do
        --local realspellnum = GetKnownSlotFromHighestRankSlot(spellnum)
        local spellname, spellSubName = GetSpellBookItemName(spellnum, BOOKTYPE_SPELL)
        local _,_,_,_,_,_, spellid = GetSpellInfo(spellname)
        local cd, gcd = GetSpellBaseCooldown(spellname)
        if cd and cd > 0 then
            cd_table[spellid] = cd
        end
    end
    return cd_table
end

local function update_table(table1, table2)
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

local function place_spells(cds)
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


function MB.mage_cds()
    book2_cds = get_cd_table(2)
    book3_cds = get_cd_table(3)
    cds = update_table(book2_cds, book3_cds)
    --for spellid in pairs(cds) do
        --print(GetSpellLink(spellid), spellid)
    --end
    place_spells(cds)
    --print(spellname)
    --PickupSpell(spellid)
    --print(i)
    --PlaceAction(i)
    --i = i + 1
    --ClearCursor()
    --print(a, b)
end

local function get_stats_string()
    s = ''
    local _, _, int = UnitStat('player', 4)
    return (string.format("gear_intellect=%d", int) .. '\n'
    .. string.format("gear_crit_rating=%d", GetCombatRating(9)) .. '\n'
    .. string.format("gear_haste_rating=%d", GetCombatRating(18)) .. '\n'
    .. string.format("gear_mastery_rating=%d", GetCombatRating(26)) .. '\n'
    .. string.format("gear_versatility_rating=%d", GetCombatRating(29)))
end

function MB.mage_stats()
	local frame = CreateFrame("Frame", "MyStatsFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
	table.insert(UISpecialFrames, "MyStatsFrame")
	frame:SetBackdrop(PaneBackdrop)
	frame:SetBackdropColor(0,0,0,1)
	frame:SetWidth(500)
	frame:SetHeight(400)
	frame:SetPoint("CENTER", UIParent, "CENTER")
	frame:Hide()
	frame:SetFrameStrata("DIALOG")

	local scrollArea = CreateFrame("ScrollFrame", "MyStatsScroll", frame, "UIPanelScrollFrameTemplate")
	scrollArea:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -30)
	scrollArea:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 8)

	local editBox = CreateFrame("EditBox", nil, frame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(ChatFontNormal)
	editBox:SetWidth(400)
	editBox:SetHeight(270)
	editBox:SetScript("OnEscapePressed", function() frame:Hide() end)
	editBox:SetText(get_stats_string())

	scrollArea:SetScrollChild(editBox)

	local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", frame, "TOPRIGHT")
	frame:Show()
end
