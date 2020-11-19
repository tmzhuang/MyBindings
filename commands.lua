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

local function bind_keys(spells, items, macros)
    for key, spell in pairs(spells) do
        SetBindingSpell(string.upper(key), spell)
    end

    for key, item in pairs(items) do
        SetBindingItem(string.upper(key), item)
    end

    for key, text in pairs(macros) do
        local name = get_macro_name(key)
        local ok = SetBindingMacro(string.upper(key), name)
    end
end

local function bind_profile(name)
    fname = string.format('get_%s_data', name)
    data_f = MB[fname]
    if data_f then 
        spells, items, macros, unbound_macros, perCharacter_macros = data_f()
        sync_macros(macros, 1)
        sync_macros(perCharacter_macros, 1, true)
        sync_macros(unbound_macros, 2)
        bind_keys(spells, items, macros)
        bind_keys(spells, items, perCharacter_macros)
        SaveBindings(1)
        SaveBindings(2)
    end
end

local function place_cds(name)
    fname = string.format('%s_cds', name)
    cds_f = MB[fname]
    cds_f()
end


function MB.run_command(argstr)
    if InCombatLockdown() then
        MB.PrintError(ERR_NOT_IN_COMBAT)
        return true
    end

    local args = { strsplit(" ", argstr) }
    local name = ''
    if args[1]=='' then
        name = 'mage'
    else
        name = args[1]
    end
    local bindset = {mage=true, mage_noob=true}
    if bindset[name] then
        if not args[2] then
            args[2] = 'spells'
        end
        if args[2] == 'spells' then
            bind_profile(name)
        elseif args[2] == 'cds' then
            place_cds(name)
        end
    elseif name == 'test' then
        MB.test()
    end end
