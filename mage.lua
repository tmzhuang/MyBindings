local _, MB = ...

local MANA_GEM_ID = 36799
local TRINKET2_ID = 14

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
    local race = string.lower(UnitRace('player'))
    local spells = {}
    local items = {}
    local macros = {}
    local perCharacter_macros = {}
    local unbound_macros = {}
    spells['2'] = 'Time Warp'
    spells['3'] = 'Mirror Image'
    spells['4'] = 'Alter Time'
    spells['shift-='] = 'Conjure Refreshment'
    spells['w'] = 'Frost Nova'
    spells['shift-e'] = 'Rune of Power'
    spells['r'] = 'Blink' spells['shift-t'] = 'Spellsteal'
    spells['a'] = 'Arcane Explosion'
    spells['shift-s'] = 'Remove Curse'
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
/use [spec:1] Arcane Orb
/use [spec:2] Greater Pyroblast
/use [spec:3] Frozen Orb
    ]]
    macros['alt-f'] = [[
/use [spec:1] Evocation
/use [spec:3] Ray of Frost
    ]]
    macros['j'] = [[
/dismount
/stopcasting
/use [nomod,@player] Slow Fall; [mod:shift,@mouseover] Slow Fall
    ]]
    macros['z'] = [[
/use [spec:1,nomod] Arcane Barrage; [spec:1,mod:alt] Fire Blast
/use [spec:2] Fire Blast
/use [spec:3,nomod] Ice Lance; [spec:3,mod:shift,@focus] Ice Lance; [spec:3,mod:alt] Fire Blast
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
# trinket2
/use 14
    ]]
    perCharacter_macros['shift-pagedown'] = string.format('/use %s', MB.racial_spell[race])
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
    macros['numpad6'] = [[
/use [spec:1, nomod] Prismatic Barrier
/use [spec:2, nomod] Blazing Barrier
/use [spec:3, nomod] Ice Barrier
/use [mod:shift] Frost Ward
/use [mod:alt] Frost Ward
    ]]
    print('Rebound mage keys.')
    return spells, items, macros, unbound_macros, perCharacter_macros
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
    return spells, items, macros, unbound_macros, perCharacter_macros
end

local fixes = {
    ['Frost Nova']=30000,
    ['Blink']=15000,
    ['Fire Blast']=11000,
    ['Conjure Refreshment']=0,
}

local function valid_key(key)
    return not (key:find('^Portal') ~= nil)
end

local function fix_cds(cds)
    for k,v in pairs(fixes) do
        if valid_key(k) then
            local spellid = MB.get_spellid(k)
            if spellid then
                cds[spellid] = v
            end
        end
    end
end

function MB.mage_cds()
    book2_cds = MB.get_cd_table(2)
    book3_cds = MB.get_cd_table(3)
    cds = MB.update_table(book2_cds, book3_cds)
    -- TODO: fix wrong cds
    fix_cds(cds)

    MB.place_spells(cds)
    local race = string.lower(UnitRace('player'))
    local slot = 3 * 12 --bar 3
    MB.place_action('spell', MB.get_spellid(MB.racial_spell[race]), slot)
    slot = slot - 1
    MB.place_action('inv', TRINKET2_ID, slot)
    slot = slot - 1
    MB.place_action('item', MANA_GEM_ID, slot)
    print('Placed mage cds.')
end
