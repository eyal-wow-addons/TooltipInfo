if not TooltipDataProcessor.AddTooltipPostCall then return end

local UnitIsPlayer = UnitIsPlayer
local GetGuildInfo = GetGuildInfo

local GUILD_PATTERN = ".+"
local GUILD_FORMAT = "|cff00ff10%%s|r |cff00ff10<%%s>|r"
local GUILD_FULLNAME_FORMAT = "%s-%s"

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip)
	if tooltip:IsForbidden() then return end
    if tooltip ~= GameTooltip then return end

    local _, unit = tooltip:GetUnit()
    local numLines = tooltip:NumLines()

    if unit and UnitIsPlayer(unit) then
        local guildName, guildRankName, _, guildRealm = GetGuildInfo(unit)
        if guildName then
            for i = 2, numLines do
                local line = _G["GameTooltipTextLeft" .. i]
                if line then
                    local lineText = line:GetText()
                    if lineText and lineText:find(guildName) then
                        local guildFullName = guildName

                        if guildRealm and IsShiftKeyDown() then
                            guildFullName = GUILD_FULLNAME_FORMAT:format(guildName, guildRealm)
                        end

                        line:SetFormattedText(lineText:gsub(GUILD_PATTERN, GUILD_FORMAT), guildFullName, guildRankName)
                        
                        break
                    end
                end
            end
        end
    end
end)