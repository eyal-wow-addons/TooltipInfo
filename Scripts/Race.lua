if not TooltipDataProcessor.AddTooltipPostCall then return end

local UnitIsPlayer = UnitIsPlayer
local UnitRace = UnitRace
local UnitIsFriend = UnitIsFriend

local RACE_FORMAT = "%%s%%s|r"
--local ALLIANCE = "Alliance"
--local HORDE = "Horde"
--local PANDAREN = "Pandaren"

local function GetUnitReactionColor(unit)
    if UnitIsFriend(unit, "player") then
        return "|cff49ad4d"
    else
        return "|cffff0000"
    end
end

--[[local function GetUnitBattlefieldFaction(unit)
	local englishFaction, localizedFaction = UnitFactionGroup(unit)

	-- This might be a rated BG or wargame and if so the player's faction might be altered
	-- should also apply if `player` is a mercenary.
	if unit == "player" then
		if C_PvP.IsRatedBattleground() or IsWargame() then
			englishFaction = PLAYER_FACTION_GROUP[GetBattlefieldArenaFaction()]
			localizedFaction = (englishFaction == ALLIANCE and FACTION_ALLIANCE) or FACTION_HORDE
		elseif UnitIsMercenary(unit) then
			if englishFaction == ALLIANCE then
				englishFaction, localizedFaction = HORDE, FACTION_HORDE
			else
				englishFaction, localizedFaction = ALLIANCE, FACTION_ALLIANCE
			end
		end
	end

	return englishFaction, localizedFaction
end]]

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip)
    if tooltip:IsForbidden() then return end
    if tooltip ~= GameTooltip then return end

    local _, unit = tooltip:GetUnit()
    local numLines = tooltip:NumLines()

    if unit and UnitIsPlayer(unit) then
        local race = UnitRace(unit)
        --[[local _, localizedFaction = GetUnitBattlefieldFaction(unit)
        if localizedFaction and englishRace == PANDAREN then 
            race = localizedFaction .. " " .. race
        end]]
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