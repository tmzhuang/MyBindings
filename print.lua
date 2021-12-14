local _, MB = ...

function MB.PrintError(msg)
    MB.Print("|cffff6666" .. msg .. "|r")
end

function MB.Print(msg)
    local f = SELECTED_CHAT_FRAME or DEFAULT_CHAT_FRAME
    f:AddMessage("|cff00ff00MyBindings:|r " .. msg)
end
