local _, MB = ...

local function get_macro_name(key)
    return ('K:' .. string.upper(key))
end

local function create_or_update_macro(name, text, perCharacter)
    local existing_name = GetMacroInfo(name)
    if existing_name then
        index = EditMacro(existing_name, nil, nil, text)
    else
        index = CreateMacro(name, "INV_MISC_QUESTIONMARK", text, perCharacter)
    end
    return index
end

local function sync_macros(macros, mode, perCharacter)
    mode = (mode==nil and 1) or mode
    for key, text in pairs(macros) do
        local name = ''
        if mode == 1 then
            name = get_macro_name(key)
        else
            name = key
        end
        local index = create_or_update_macro(name, text, perCharacter)
    end
end

local function clear_keys()
    local base_keys = {'1', '2', '3', '4', '5',
    'q', 'w', 'e', 'r', 't', 'y', 'u', 'a', 'g', 'h',
    'z', 'x', 'c', 'v', 'b'}
    for _, mod in pairs({'none', 'shift-', 'alt-'}) do
        for _, key in pairs(base_keys) do
            if mod == 'none' then
                --MB.Print(string.upper(key))
                SetBinding(string.upper(key))
            else
                --MB.Print(string.upper(mod..key))
                SetBinding(string.upper(mod..key))
            end
        end
    end
    MB.Print('Cleared previous bindings.')
end

local function bind_keys(spells, items, macros, percharacter_macros)
    clear_keys()
    local ok
    --MB.Print('binding spells')
    for key, spell in pairs(spells) do
        ok = SetBindingSpell(string.upper(key), spell)
        --MB.Print(key, spell, ok)
    end

    for key, item in pairs(items) do
        ok = SetBindingItem(string.upper(key), item)
        --MB.Print(key, item, ok)
    end

    for key, text in pairs(macros) do
        local name = get_macro_name(key)
        ok = SetBindingMacro(string.upper(key), name)
        --MB.Print(key, name, ok)
    end

    for key, text in pairs(percharacter_macros) do
        local name = get_macro_name(key)
        ok = SetBindingMacro(string.upper(key), name)
        --MB.Print(key, name, ok)
    end
end

local function bind_profile(spec)
    local class = string.lower(UnitClass('player'))
    MB.Print('Binding profile...', class, spec)
    fname = string.format('get_%s_data', class)
    if class == 'mage' then
        data_f = MB.get_mage_data
    elseif class == 'warrior' then
        data_f = MB.get_warrior_data
    elseif class == 'priest' then
        --MB.Print('Before data_f')
        data_f = MB.get_priest_data
        --MB.Print('After data_f')
    end
    if data_f then 
        MB.Print('Getting bind data...')
        spells, items, macros, unbound_macros, perCharacter_macros = data_f(spec)
        MB.Print('Syncing macros...')
        --MB.Print('Data fetched.')
        sync_macros(macros, 1)
        --MB.Print('Macros synced.')
        sync_macros(perCharacter_macros, 1, true)
        --MB.Print('PerCharacter macros synced.')
        sync_macros(unbound_macros, 2)
        --MB.Print('unbound macros synced.')
        MB.Print('Binding keys...')
        bind_keys(spells, items, macros, perCharacter_macros)
        --MB.Print('keys bound.')
        MB.Print('Done!')
    end
end

local function place_cds(class)
    if class == 'mage' then
        cds_f = MB.mage_cds
    elseif class == 'warrior' then
        cds_f = MB.warrior_cds
    end
    cds_f()
end

local function save_bindings()
    SaveBindings(2)
    SaveBindings(1)
end

function MB.run_command(argstr)
    if InCombatLockdown() then
        MB.PrintError(ERR_NOT_IN_COMBAT)
        return true
    end

    local class = ''
    local args = { strsplit(" ", argstr, 2) }
    local spec = ''
    if args[1]=='' then
        spec = 'dps'
    else
        spec = args[1]
        MyBindingsSpec = spec
    end
    local class = string.lower(UnitClass('player'))
    --MB.Print('DEBUG: class is', class)
    --MB.Print('DEBUG: spec is', spec)
    bind_profile(spec)
    save_bindings()
end

local frame = CreateFrame("FRAME", "MBFrame");
frame:RegisterEvent("PLAYER_LOGIN");
local function eventHandler(self, event, ...)
    if MyBindingsSpec == nil then
        MyBindingsSpec = 'dps'
    end
    bind_profile(MyBindingsSpec)
    MB.Print('MyBindings: Commands loaded!')
end
frame:SetScript("OnEvent", eventHandler);
