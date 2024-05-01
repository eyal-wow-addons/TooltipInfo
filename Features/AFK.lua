if not TooltipDataProcessor.AddTooltipPostCall then return end

local UnitIsPlayer = UnitIsPlayer
local UnitIsAFK = UnitIsAFK
local UnitIsDND = UnitIsDND
local UnitIsConnected = UnitIsConnected

local PLAYER_BUSY_FORMAT = " |cff00cc00%s|r"
local DISCONNECTED = "<DC>"

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip)
    if tooltip:IsForbidden() then return end
    if tooltip ~= GameTooltip then return end
    
    local _, unit = tooltip:GetUnit()

    if unit and UnitIsPlayer(unit) then
        local afk = UnitIsAFK(unit) and CHAT_FLAG_AFK
        local dnd = UnitIsDND(unit) and CHAT_FLAG_DND
        local dc = not UnitIsConnected(unit) and DISCONNECTED
        tooltip:AppendText(PLAYER_BUSY_FORMAT:format(afk or dnd or dc or ""))
    end
end)