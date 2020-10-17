local _, MB = ...

local function get_macro_name(key)
    return ('K:' .. string.upper(key))
end

local function create_or_update_macro(name, text)
    local existing_name = GetMacroInfo(name)
    if existing_name then
        index = EditMacro(existing_name, nil, nil, text)
    else
        index = CreateMacro(name, "INV_MISC_QUESTIONMARK", text)
    end
    return index
end

local function sync_macros(macros)
    for key, text in pairs(macros) do
        local name = get_macro_name(key)
        local index = create_or_update_macro(name, text)
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

function MB.run_command(argstr)
    if InCombatLockdown() then
        MB.PrintError(ERR_NOT_IN_COMBAT)
        return true
    end

    local args = { strsplit(" ", argstr) }
    local cmd = table.remove(args, 1)
    print('Reloading bindings...')

    local spells, items, macros = MB.get_mage_data()
    sync_macros(macros)
    bind_keys(spells, items, macros)

    SaveBindings(1)
    SaveBindings(2)
    print('Done.')
end
