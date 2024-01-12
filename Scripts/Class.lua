if not TooltipDataProcessor.AddTooltipPostCall then return end

local UnitIsPlayer = UnitIsPlayer
local UnitClass = UnitClass

local CLASS_FORMAT = "|c%%s%%s|r"

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip)
	if tooltip:IsForbidden() then return end
    if tooltip ~= GameTooltip then return end

    local _, unit = tooltip:GetUnit()
    local numLines = tooltip:NumLines()

    if unit and UnitIsPlayer(unit) then
		local localizedClass, englishClass = UnitClass(unit)
        for i = 2, numLines do
			local line = _G["GameTooltipTextLeft" .. i]
			if line then
				local lineText = line:GetText()
				if lineText and lineText:find(localizedClass) then
					local classColor = RAID_CLASS_COLORS[englishClass]
                    if classColor then
                        line:SetFormattedText(lineText:gsub(lineText, CLASS_FORMAT), classColor.colorStr, lineText)
                    end
					break
				end
			end
		end
    end
end)