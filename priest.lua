local _, MB = ...

local HEALTHSTONE_ID = 5512
local TRINKET1_ID = 13
local TRINKET2_ID = 14

local function delete_item(search)
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

function MB.get_priest_data(spec)
    local DW1 = ''
    local DW2 = ''
    local TWOHAND = ''
    local MH = '' 
    local SHIELD = ''
    if spec == 'dps' then
        DW1 = "The Decapitator"
        DW2 = "Spiteblade"
        TWOHAND = "Gorehowl"
        SHIELD = "Azure-Shield of Coldarra"
        MH = "The Decapitator"
    elseif spec == 'tank' then
        DW1 = "The Decapitator"
        DW2 = "Spiteblade"
        TWOHAND = "Gorehowl"
        SHIELD = "Azure-Shield of Coldarra"
        MH = "The Decapitator"
    elseif spec == 'pvp' then
        MH = "Fool's Bane"
        DW1 = "Fool's Bane"
        TWOHAND = "Stormherald"
        SHIELD = "The Fel Barrier"
    end
    if not MH then
        MH = DW1
    end


    local race, _ = string.lower(UnitRace('player'))
    local spells = {}
    local items = {}
    local macros = {}
    local perCharacter_macros = {}
    local unbound_macros = {}

    unbound_macros['ClearFocus'] = [[
/clearfocus
]]
    unbound_macros['SetFocus'] = [[
/focus [@mouseover,harm,nodead]; [@target,harm,nodead]
]]
    unbound_macros['SwapFocus'] = [[
/target focus
/targetlasttarget
/focus
/targetlasttarget
#/run SetRaidTarget("target",8)
#/run SetRaidTarget("focus",7)
]]
    unbound_macros['RaidFrame'] = [[
/run CompactRaidFrameManager:UnregisterAllEvents()
/run CompactRaidFrameManager:Hide()
]]
    unbound_macros['Fort'] = [[
/use [help,@mouseover]Power Word: Fortitude;[@player]Power Word: Fortitude
]]

    items['0'] = 'Hearthstone'

    macros['shift-`'] = [[
/run ToggleBag(KEYRING_CONTAINER)
]]
    macros['1'] = [[
/use Bottled Nethergon Vapor
/use Master Healthstone
/use Major Healthstone
/use Healthstone
/use Auchenai Healing Potion
/use Mad Alchemist's Potion
/use Super Healing Potion
/use Volatile Healing Potion
]]
    macros['shift-1'] = [[
/use [@player] Heavy Netherweave Bandage
/use [@player] Netherweave Bandage
/use [@player] Heavy Runecloth Bandage
/use [@player] Runecloth Bandage
]]
    macros['alt-1'] = [[
/use Mighty Rage Potion
]]
    macros['2'] = [[
/use Death Wish
/use Last Stand
/use Bloodlust Brooch
/use Abacus of Violent Odds
]]
    macros['3'] = [[
/use Arcane Torrent
/use Bloodlust Brooch
/use Abacus of Violent Odds
]]
    macros['shift-3'] = [[
/use [stance:1] Retaliation
/use [stance:2] Shield Wall
/use [stance:3] Recklessness
]]
    macros['4'] = [[
/use Mind Blast
]]
    macros['5'] = [[
/use Psychic Scream
]]
    macros['shift-5'] = [[
/use Shadowfiend
]]
--1	Star: Shackle undead
--2	Circle: Sap
--3	Diamond: Fear
--4	Triangle: Hibernate
--5	Moon: Sheep
--6	Square: Trap
--7	Cross (X)
--8	Skull
    macros['6'] = [[
/run SetRaidTarget('target', 8)
]]
    macros['shift-6'] = [[
/run SetRaidTarget('target', 7)
]]
    macros['7'] = [[
/run SetRaidTarget('target', 5)
]]
    macros['shift-7'] = [[
/run SetRaidTarget('target', 2)
]]
    macros['8'] = [[
/run SetRaidTarget('target', 6)
]]
    macros['shift-8'] = [[
/run SetRaidTarget('target', 4)
]]
    macros['9'] = [[
/run SetRaidTarget('target', 3)
]]
    macros['shift-9'] = [[
/run SetRaidTarget('target', 1)
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
    -- unbind default nameplate toggle keys
    SetBinding('SHIFT-V')
    SetBinding('CTRL-V')
    --print('DEBUG: reset default V bindings')
    macros['shift-q'] = [[
/use Fade
    ]]
    macros['w'] = [[
/use [help,@mouseover]Renew;[@player]Renew
    ]]
    macros['alt-w'] = string.format([[
#showtooltip
/equipslot [noworn:shield] 16 %s
/equipslot [noworn:shield] 17 %s
/use [nostance:2] Defensive Stance
/use [stance:2] Spell Reflection
    ]], MH, SHIELD)
    macros['e'] = [[
/use [help,@mouseover]Lesser Heal;[@player]Lesser Heal
    ]]
    macros['alt-e'] = [[
/use Challenging Shout
    ]]
    macros['r'] = [[
/use [nomod,harm,@mouseover][nomod,harm][mod:shift,@focus]Shadow Word: Pain
    ]]
    macros['shift-r'] = [[
/startattack
/use Concussion Blow
/use Rampage
    ]]
    macros['alt-r'] = [[
/use Piercing Howl
    ]]
--/use [stance:2,nomod,noharm,@mouseover][stance:2,nomod,noharm]Intervene
    macros['t'] = [[
/use [nomod,harm,@mouseover][nomod,harm][mod:shift,@focus]Shadow Word: Death
    ]]
    macros['a'] = [[
/startattack
/use [nostance:1] Battle Stance
/use [harm] Overpower
    ]]
    macros['alt-a'] = [[
/use [nostance:1] Battle Stance
/use [nomod,harm,@mouseover][nomod,harm]Mocking Blow
    ]]
    macros['alt-s'] = [[
/dismount
/use Swift Yellow Windrider
/use Horn of the Swift Brown Wolf
/run UIErrorsFrame:Clear()
    ]]
    macros['y'] = [[
/startattack
/use Cleave
    ]]
    macros['shift-y'] = [[
/use Shoot
]]
    macros['alt-d'] = [[
/use [stance:2][nomod,harm,@mouseover][nomod,harm]Taunt
/use [stance:1][stance:3]Sweeping Strikes
    ]]
    macros['shift-f'] = [[
/use [stance:1][stance:2]Thunder Clap
/use [stance:3]Berserker Rage
    ]]
    macros['alt-f'] = [[
/use Demoralizing Shout
    ]]
    macros['g'] = [[
/use Mind Flay
]]
    macros['shift-g'] = [[
/use Smite
    ]]
    macros['h'] = [[
/use Ressurection
]]
    macros['shift-h'] = [[
/use Mana Tap
]]
    macros['\''] = [[
/use Prayer of Fortitude
]]
    macros['z'] = [[
/use [nomod,harm,@mouseover][nomod,harm][mod:shift,@focus]Shadow Word: Death
    ]]
    macros['alt-z'] = [[
/startattack
/use Victory Rush
    ]]
    macros['shift-z'] = [[
/startattack
/use [stance:1][stance:2]Rend
    ]]
--/equipslot [mod:alt] 16 Grom'tor's Charge
    macros['x'] = string.format([[
#showtooltip
/stopattack
/equipslot [mod:shift] 16 %s
/equipslot [mod:shift] 17 %s
/eq [noworn:two-hand,nomod] %s
/equipslot [mod:alt] 16 %s
/equipslot [mod:alt] 17 %s
    ]], DW1, DW2, TWOHAND, MH, SHIELD)
    macros['c'] = [[
/use [help,@mouseover]Power Word: Shield;[@player]Power Word: Shield
    ]]
    macros['shift-c'] = [[
/use Defensive Stance
/use [harm] Disarm
    ]]
    macros['v'] = [[
/use [nomod,harm,@mouseover][nomod,harm][mod:shift,@focus]Silence
    ]]
    macros['b'] = [[
/use 13
    ]]
    macros['shift-b'] = [[
/use 14
    ]]
    -- middle mouse
    return spells, items, macros, unbound_macros, perCharacter_macros
end

-- thumb1: 1/end
-- thumb2: 2/down
-- middle: 3/pagedown
-- dpi down: 4/left
-- dpi up: 6/right

local fixes = {}

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

function MB.priest_cds()
    print('priest_cds')
    book2_cds = MB.get_cd_table(2)
    book3_cds = MB.get_cd_table(3)
    cds = MB.update_table(book2_cds, book3_cds)
    -- TODO: fix wrong cds
    --fix_cds(cds)

    local max = 7
    local slot = MB.place_spells(cds, max)
    local race = string.lower(UnitRace('player'))
    slot = MB.place_action('spell', MB.get_spellid(MB.racial_spell[race]), slot, max)
    --slot = MB.place_action('macro', nil, slot, max, nil, 'belt')
    --slot = MB.place_action('macro', nil, slot, max, nil, 'trinket1')
    --slot = MB.place_action('macro', nil, slot, max, nil, 'trinket2')
    print('Placed priest cds.')
end

