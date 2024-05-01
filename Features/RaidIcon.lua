if not TooltipDataProcessor.AddTooltipPostCall then return end

local ICON_LIST = ICON_LIST

local UnitExists = UnitExists
local GetRaidTargetIndex = GetRaidTargetIndex

local RAID_ICON_FORMAT = "%s %s"

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip)
    if tooltip:IsForbidden() then return end
    if tooltip ~= GameTooltip then return end

    local _, unit = tooltip:GetUnit()
    
    if unit and UnitExists(unit) then
        local ricon = GetRaidTargetIndex(unit)
        if ricon then
            local text = GameTooltipTextLeft1:GetText()
            if text then
                GameTooltipTextLeft1:SetFormattedText(RAID_ICON_FORMAT, ICON_LIST[ricon] .. "18|t", text)
            end
        end
    end
end)