if not TooltipDataProcessor.AddTooltipPostCall then return end

local _G = _G
local UnitIsPlayer = UnitIsPlayer
local UnitRace = UnitRace
local UnitIsFriend = UnitIsFriend

local RACE_FORMAT = "%%s%%s|r"

local function GetUnitReactionColor(unit)
    if UnitIsFriend(unit, "player") then
        return "|cff49ad4d"
    else
        return "|cffff0000"
    end
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip)
    if tooltip:IsForbidden() then return end
    if tooltip ~= GameTooltip then return end

    local _, unit = tooltip:GetUnit()
    local numLines = tooltip:NumLines()

    if unit and UnitIsPlayer(unit) then
        local race = UnitRace(unit)
        if race then
            for i = 2, numLines do
                local line = _G["GameTooltipTextLeft" .. i]
                if line then
                    local lineText = line:GetText()
                    if lineText and lineText:find(race) then
                        line:SetFormattedText(lineText:gsub(race, RACE_FORMAT), GetUnitReactionColor(unit), race)
                        break
                    end
                end
            end
        end
    end
end)