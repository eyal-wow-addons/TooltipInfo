if not TooltipDataProcessor.AddTooltipPostCall then return end

local _G = _G
local TARGET = TARGET
local FACTION_BAR_COLORS = FACTION_BAR_COLORS
local RAID_CLASS_COLORS = RAID_CLASS_COLORS

local UnitIsUnit = UnitIsUnit
local UnitIsPlayer = UnitIsPlayer
local UnitClass = UnitClass
local UnitReaction = UnitReaction
local UnitName = UnitName
local UnitExists = UnitExists

local THE_TARGET_FORMAT = "|cfffed100" .. TARGET .. ":|r %s"
local PLAYER_FORMAT = "|cffffffff<You>|r"
local UNIT_NAME_FORMAT = "|cff%2x%2x%2x%s|r"
local OTHER_UNIT_NAME_FORMAT = "|cffffffff%s|r"

local function GetUnitName(color, unit)
    return UNIT_NAME_FORMAT:format(color.r * 255, color.g * 255, color.b * 255, UnitName(unit))
end

local function GetTargetName(unit)
    if UnitIsUnit(unit, "player") then
        return PLAYER_FORMAT
    elseif UnitIsPlayer(unit) then
        local class = select(2, UnitClass(unit))
        if class then
            local color = RAID_CLASS_COLORS[class]
            return GetUnitName(color, unit)
        end
    elseif UnitReaction(unit, "player") then
        local color = FACTION_BAR_COLORS[UnitReaction(unit, "player")]
        return GetUnitName(color, unit)
    else
        return OTHER_UNIT_NAME_FORMAT:format(UnitName(unit))
    end
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip)
    if tooltip:IsForbidden() then return end
    if tooltip ~= GameTooltip then return end

    local _, unit = tooltip:GetUnit()
    
    if unit then
        local numLines = tooltip:NumLines()
        for i = 1, numLines do
            local line = _G["GameTooltipTextLeft" .. i]
            local text = line:GetText()
            local unit = unit .. "target"
            if text and text:find(THE_TARGET_FORMAT:format(".+")) then
                if UnitExists(unit) then
                    line:SetText(THE_TARGET_FORMAT:format(GetTargetName(unit)))
                else
                    tooltip:SetUnit("mouseover")
                end
                break
            elseif i == numLines and UnitExists(unit) then
                tooltip:AddLine(THE_TARGET_FORMAT:format(GetTargetName(unit)))
            end
        end
    end
end)