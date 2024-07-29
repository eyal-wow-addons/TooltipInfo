local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function(self)
    TooltipInfoDB = TooltipInfoDB or {
        ["AnchorMode"] = 1
    }

    SLASH_TOOLTIPINFO1 = "/tooltip"
    SLASH_TOOLTIPINFO2 = "/tti"
    SlashCmdList["TOOLTIPINFO"] = function(input)
        if input == "anchor normal" then
            TooltipInfoDB["AnchorMode"] = 1
            ReloadUI()
        elseif input == "anchor dynamic" then
            TooltipInfoDB["AnchorMode"] = 2
        end
    end

    self:UnregisterEvent("PLAYER_LOGIN")
end)