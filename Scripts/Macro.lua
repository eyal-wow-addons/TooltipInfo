if not TooltipDataProcessor.AddTooltipPostCall then return end

local GetActionText = GetActionText

local MACRO_FORMAT = "|cffca3c3c<Macro>|r %s"

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Macro, function(tooltip)
    if not IsShiftKeyDown() then return end
	if tooltip:IsForbidden() or tooltip:NumLines() == 1 then return end
    if tooltip ~= GameTooltip then return end

	local info = tooltip:GetPrimaryTooltipInfo()
	
	if info and info.getterArgs then
		local slot = info.getterArgs[1]
		if slot then
			local text = GetActionText(slot)
			if text then
				tooltip:AddLine(MACRO_FORMAT:format(text))
			end
		end
	end
end)