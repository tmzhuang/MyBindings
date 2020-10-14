local _, MB = ...

function MB.get_mage_data()
    local spells = {}
    local items = {}
    local macros = {}
    spells['2'] = 'Time Warp'
    spells['3'] = 'Mirror Image'
    spells['shift-='] = 'Conjure Refreshment'
    spells['w'] = 'Frost Nova'
    spells['shift-e'] = 'Rune of Power'
    spells['r'] = 'Blink'
    spells['shift-t'] = 'Spellsteal'
    spells['a'] = 'Arcane Explosion'
    spells['x'] = 'Ice Block'
    spells['shift-j'] = 'Arcane Explosion'
    spells['numpad4'] = 'Arcane Intellect'

    items['0'] = 'Hearthstone'

    macros['5'] = [[
/use [nomod] Polymorph; [mod:shift, @focus] Polymorph
    ]]
    macros['='] = [[
#show Conjure Refreshment
#showtooltip Conjure Refreshment
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
    macros['v'] = [[
/use [nomod] Counterspell; [mod:shift, @focus] Counterspell
    ]]
    macros['q'] = [[
/use [spec:1] Greater Invisibility
/use [spec:2] Invisibility
/use [spec:3] Invisibility
    ]]
    macros['shift-w'] = [[
#showtooltip Summon Water Elemental
/cast [nopet] Summon Water Elemental
/stop macro [nopet]
/petpassive
/use Freeze
    ]]
    macros['alt-w'] = [[
/use Waterbolt
    ]]
    macros['g'] = [[
/use [spec:1] Arcane Blast
/use [spec:2] Fireball
/use [spec:3,nomod] Frostbolt; [spec:3,mod:shift] Glacial Spike; [spec:3,mod:alt] Ebonbolt
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
    macros['alt-d'] = [[
/use [spec:1, nocombat] Conjure Mana Gem
/use [spec:1, combat] Mana Gem
/use [spec:2] Meteor
/use [spec:3] Comet Storm
    ]]
    macros['shift-f'] = [[
/use [spec:1] Evocation
/use [spec:2] Greater Pyroblast
/use [spec:3] Frozen Orb
    ]]
    macros['alt-f'] = [[
/use [spec:3] Ray of Frost
    ]]
    macros['shift-g'] = [[
/use [spec:3] Glacial Spike
]]
    macros['j'] = [[
/dismount
/stopcasting
/use [nomod,@player] Slow Fall; [mod:shift,@mouseover] Slow Fall
]]
    macros['z'] = [[
/use [spec:1] Arcane Barrage
/use [spec:2, nomod] Ice Lance; [spec:2, mod:shift, @focus] Ice Lance
/use [spec:3] Fire Blast
/use [mod:alt] Fire Blast
    ]]
    macros['c'] = [[
/use [spec:1] Slow
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
-- thumb 1
    macros['numpad1'] = [[
/use [spec:1, nomod] Prismatic Barrier
/use [spec:2, nomod] Blazing Barrier
/use [spec:3, nomod] Ice Barrier
/use [mod:shift] Frost Ward
/use [mod:alt] Frost Ward
    ]]
-- thumb 2
    macros['numpad2'] = [[
/focus [@mouseover]
/run SetRaidTarget("focus",7)
    ]]
    macros['shift-down'] = [[
/target focus
/targetlasttarget
/focus
/targetlasttarget
/run SetRaidTarget("target",8)
/run SetRaidTarget("focus",7)
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
    return spells, items, macros
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
