local _, MB = ...

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
