local _, MB = ...

local MANA_GEM_ID = 36799
local TRINKET1_ID = 13
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
    spells['shift-='] = 'Conjure Refreshment'
    spells['w'] = 'Frost Nova'
    spells['shift-e'] = 'Rune of Power'
    spells['shift-t'] = 'Spellsteal'
    spells['a'] = 'Arcane Explosion'
    spells['x'] = 'Ice Block'
    spells['shift-j'] = 'Arcane Explosion'

    items['0'] = 'Hearthstone'

    macros['1'] = [[
/use Phial of Serenity
]]
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
/use [nomod,harm,@mouseover][nomod,harm][mod:shift, @focus]Counterspell
    ]]
    macros['q'] = [[
/cancelaura Greater Invisibility
/cancelaura Invisibility
/use [nomod] Invisibility
/use [spec:1,nomod]Greater Invisibility; [spec:1,mod:shift] Mass Invisibility
    ]]
    macros['shift-q'] = [[
/cancelaura Mass Invisibility
/use [spec:1] Mass Invisibility
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
    macros['alt-e'] = [[
/use Radiant Spark
/use Deathborne
/use Shifting Power
/use Mirrors of Torment
    ]]
    macros['r'] = [[
#showtooltip
/cancelaura Ice Block
/use Blink
    ]]
    macros['shift-r'] = [[
#showtooltip
/cancelaura Ice Block
/use Summon Steward
/use Fleshcraft
/use Soulshape
/use Door of Shadows
    ]]
    macros['shift-s'] = [[
/use [help,@cursor][@player]Remove Curse
    ]]
    macros['g'] = [[
/use [spec:1,nomod] Arcane Blast;[spec:1,mod:shift] Frostbolt
/use [spec:2,nomod] Fireball;[spec:1,mod:shift] Greater Pyroblast;[spec:1,mod:alt] Frostbolt
/use [spec:3,nomod] Frostbolt;[spec:3,mod:alt] Glacial Spike;[spec:3,mod:shift] Ebonbolt
    ]]
    macros['e'] = [[
/use [spec:1] Touch of the Magi
/use [spec:2] Dragon's Breath
/use [spec:3] Ice Floes
    ]]
    macros['t'] = [[
/use [spec:1] Arcane Missiles
/use [spec:2] Pyroblast
/use [spec:3] Flurry
    ]]
    macros['y'] = [[
/use [spec:1] Presence of Mind
/use [spec:2,@cursor] Flamestrike
/use [spec:3,nomod,@cursor] Blizzard;[spec:3,mod:shift,@cursor] Ring of Frost
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
/use [spec:3] Ice Floes
/use [spec:3] Ray of Frost
    ]]
    macros['j'] = [[
/dismount
/stopcasting
/use [nomod,@player][mod:shift,@mouseover]Slow Fall
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
    macros['shift-c'] = [[
/use [spec:2] Living Bomb
/use [spec:3] Ice Nova
    ]]
    macros['alt-c'] = [[
/use [spec:2] Phoenix Flames
/use [spec:3] Cold Snap
    ]]
    -- middle mouse
    macros['numpad3'] = [[
/use Berserking
/use 13
/use 14
/use [spec:1] Arcane Power
/use [spec:2] Combustion
/use [spec:3] Icy Veins
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
    macros['alt-numpad1'] = [[
/cancelaura Alter Time
    ]]
    macros['shift-end'] = [[
/use Temporal Shield
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
function MB.get_mage_noob_data()
    local spells = {}
    local items = {}
    local macros = {}
    local perCharacter_macros = {}
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
/use [nomod,harm,@mouseover][nomod,harm]Counterspell;[mod:shift, @focus]Counterspell
    ]]
    macros['j'] = [[
/dismount
/stopcasting
/use [nomod,@player]Slow Fall;[mod:shift,@mouseover]Slow Fall
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
    ['Rune of Power']=45000,
    ['Freeze']=25000,
    ['Frost Nova']=30000,
    ['Blink']=15000,
    ['Fire Blast']=11000,
    ['Conjure Refreshment']=0,
    --arcane
    ['Evocation']=90000,
    --fire
    ['Phoenix Flames']=25000,
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

    local slot = MB.place_spells(cds, 7)
    local race = string.lower(UnitRace('player'))
    print(slot)
    MB.place_action('spell', MB.get_spellid(MB.racial_spell[race]), slot)
    slot = slot + 1
    MB.place_action('inv', TRINKET1_ID, slot)
    slot = slot + 1
    MB.place_action('inv', TRINKET2_ID, slot)
    slot = slot + 1
    MB.place_action('item', MANA_GEM_ID, slot)
    print('Placed mage cds.')
end

MB.mage_noob_cds = MB.mage_cds
