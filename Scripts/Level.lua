if not TooltipDataProcessor.AddTooltipPostCall then return end

local CreateColor = CreateColor
local GetContentDifficultyCreatureForPlayer = C_PlayerInfo.GetContentDifficultyCreatureForPlayer
local GetDifficultyColor = GetDifficultyColor
local UnitIsPlayer = UnitIsPlayer
local UnitEffectiveLevel = UnitEffectiveLevel
local UnitLevel = UnitLevel

local LEVEL1_FORMAT = "|cff%%s%%s|r"
local LEVEL2_FORMAT = "|cff%%s%%s|r (%%s)"

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip)
	if tooltip:IsForbidden() then return end
    if tooltip ~= GameTooltip then return end

    local _, unit = tooltip:GetUnit()
    local numLines = tooltip:NumLines()

    if unit and UnitIsPlayer(unit) then
		local difficulty = GetContentDifficultyCreatureForPlayer(unit)
        local diffColor = GetDifficultyColor(difficulty)
		local diffHexColor = CreateColor(diffColor.r, diffColor.g, diffColor.b, 1):GenerateHexColorNoAlpha()
		local level, realLevel = UnitEffectiveLevel(unit), UnitLevel(unit)
        for i = 2, numLines do
			local line = _G["GameTooltipTextLeft" .. i]
			if line then
				local lineText = line:GetText()
				if lineText and lineText:find(LEVEL) then
					local levelText = level > 0 and level or "??"

					if level < realLevel then
						line:SetFormattedText(lineText:gsub(level, LEVEL2_FORMAT), diffHexColor, levelText, realLevel)
					else
						line:SetFormattedText(lineText:gsub(level, LEVEL1_FORMAT), diffHexColor, levelText)
					end

					break
				end
			end
		end
    end
end)