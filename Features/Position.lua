local function SetPoint(tooltip, dir)
    dir = dir or "BOTTOMRIGHT"
    local scale = tooltip:GetEffectiveScale()
    local width = tooltip:GetWidth() * scale
    local height = tooltip:GetHeight() * scale
    local x, y = GetCursorPosition()
    local cursorSize = GetCVar("cursorsizepreferred")

    tooltip:ClearAllPoints()

    if cursorSize == "0" then
        cursorSize = 32
    elseif cursorSize == "2" then
        cursorSize = 64
    else
        cursorSize = 48
    end
    
    cursorSize = cursorSize * scale
    x, y = (x / scale) + cursorSize, (y / scale) - cursorSize

    if dir == "TOPLEFT" then
        y = y + height * 2
    elseif dir == "TOPRIGHT" then
        y = y + height * 2
        x = x - width * 2
    elseif dir == "BOTTOMLEFT" then
        y = y - height
        x = x - width * 2
    else
        y = y - height
    end

    tooltip:SetPoint("BOTTOMLEFT", UIParent, x, y)
end

GameTooltip:HookScript("OnUpdate", function(self, elapsed)
    if GetMouseFocus() == WorldFrame and self:GetAnchorType() == "ANCHOR_CURSOR" then
        SetPoint(self)
    end
end)

hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
    local frame = GetMouseFocus()

    if frame == WorldFrame then	
        tooltip:SetOwner(parent, "ANCHOR_CURSOR")
        SetPoint(tooltip)
        return
    end

    if frame == MainMenuMicroButton then
        tooltip:SetOwner(MainMenuMicroButton, "ANCHOR_TOP")
        return
    end

    if frame == MainStatusTrackingBarContainer.bars[4] then
        tooltip:SetOwner(MainStatusTrackingBarContainer.bars[4], "ANCHOR_CURSOR")
        return
    end

    tooltip:SetOwner(parent, "ANCHOR_NONE")
end)


