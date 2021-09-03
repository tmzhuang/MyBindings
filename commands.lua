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
    mode = mode or 1
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

local function bind_keys(spells, items, macros, percharacter_macros)
    local ok
    --print('binding spells')
    for key, spell in pairs(spells) do
        ok = SetBindingSpell(string.upper(key), spell)
        --print(key, spell, ok)
    end

    for key, item in pairs(items) do
        ok = SetBindingItem(string.upper(key), item)
        --print(key, item, ok)
    end

    for key, text in pairs(macros) do
        local name = get_macro_name(key)
        ok = SetBindingMacro(string.upper(key), name)
        --print(key, name, ok)
    end

    for key, text in pairs(percharacter_macros) do
        local name = get_macro_name(key)
        ok = SetBindingMacro(string.upper(key), name)
        --print(key, name, ok)
    end
end

local function bind_profile(name, spec)
    print('Binding profile...', name, spec)
    fname = string.format('get_%s_data', name)
    if name == 'mage' then
        data_f = MB.get_mage_data
    elseif name == 'warrior' then
        data_f = MB.get_warrior_data
    end
    if data_f then 
        print('Getting bind data...')
        spells, items, macros, unbound_macros, perCharacter_macros = data_f(spec)
        print('Syncing macros...')
        --print('Data fetched.')
        sync_macros(macros, 1)
        --print('Macros synced.')
        sync_macros(perCharacter_macros, 1, true)
        --print('PerCharacter macros synced.')
        sync_macros(unbound_macros, 2)
        --print('unbound macros synced.')
        print('Binding keys...')
        bind_keys(spells, items, macros, perCharacter_macros)
        --print('keys bound.')
        print('Done!')
    end
end

local function place_cds(name)
    if name == 'mage' then
        cds_f = MB.mage_cds
    elseif name == 'warrior' then
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

    local args = { strsplit(" ", argstr, 2) }
    local name = ''
    local spec = ''
    if args[1]=='' then
        name = 'warrior'
    else
        name = args[1]
    end
    if args[2]==nil then
        spec = 'dps'
    else
        spec = args[2]
    end
    local bindset = {mage=true, mage_noob=true, warrior=true}
    if bindset[name] then
        bind_profile(name, spec)
        save_bindings()
    elseif name == 'test' then
        MB.test()
    end end
