if not TooltipDataProcessor.AddTooltipPostCall then return end

do
    local text = GameTooltipStatusBar:CreateFontString(nil, "OVERLAY", "TextStatusBarText")
    text:SetPoint("CENTER")
    GameTooltipStatusBar.TextString = text
end

GameTooltipStatusBar.capNumericDisplay = true
GameTooltipStatusBar.forceShow = true
GameTooltipStatusBar.lockShow = 0
GameTooltipStatusBar:HookScript("OnValueChanged", function(self, value)
    self:SetStatusBarColor(0, 1, 0)
    
    if not value then
        return
    end
    
    local min, max = self:GetMinMaxValues()
    if (value < min) or (value > max) then
        return
    end

    local _, unit = GameTooltip:GetUnit()
    
    -- Shows percentage on structures
    self.showPercentage = not unit and max == 1

    local textString = self.TextString
    if(textString) then
        if value == 0 then
            self.TextString:Hide()
        elseif unit then
            value, max = UnitHealth(unit), UnitHealthMax(unit)
            TextStatusBar_UpdateTextStringWithValues(self, textString, value, 0, max)
        else
            TextStatusBar_UpdateTextString(self)
        end
    end
  
    value = (value - min) / (max - min)

    local r, g, b = 0, 1, 0
    if value > 0.5 then
        r, g = (1.0 - value) * 2, 1.0
    else
        r, g= 1.0, value * 2
    end

    self:SetStatusBarColor(r, g, b)
end)

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip)
    if tooltip:IsForbidden() then return end
    if tooltip ~= GameTooltip then return end 
    if GameTooltipStatusBar.TextString then
        local textWidth = GameTooltipStatusBar.TextString:GetStringWidth()
        if textWidth then
            tooltip:SetMinimumWidth(textWidth)
        end
    end
end)