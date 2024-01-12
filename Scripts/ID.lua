if not TooltipDataProcessor.AddTooltipPostCall then return end

local select = select

local IsShiftKeyDown = IsShiftKeyDown
local GetDisplayedItem = TooltipUtil and TooltipUtil.GetDisplayedItem
local GetAuraDataByIndex = C_UnitAuras and C_UnitAuras.GetAuraDataByIndex

local _G = _G
local ID = _G.ID

local ID_FORMAT = "|cffca3c3c<%s>|r %s"
local LINK_PATTERN = ":(%w+)"

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, data)
	if not IsShiftKeyDown() then return end
    if tooltip:IsForbidden() then return end
    if tooltip ~= GameTooltip then return end

    local itemID = data and data.id

    if not itemID then
        local GetItem = GetDisplayedItem or tooltip.GetItem
        if GetItem then
            local _, link = GetItem(tooltip)
            itemID = link:match(LINK_PATTERN)
        end
    end

    if itemID then
        itemID = ID_FORMAT:format(ID, itemID)
        tooltip:AddLine(itemID)
    end
end)

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, function(tooltip, data)
	if not IsShiftKeyDown() then return end
    if tooltip:IsForbidden() then return end
    if tooltip ~= GameTooltip then return end

    local spellID = data and data.id

    if not spellID then
        spellID = select(2, tooltip:GetSpell())
    end

    if spellID then
        spellID = ID_FORMAT:format(ID, spellID)
        tooltip:AddLine(spellID)
    end
end)

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.UnitAura, function(tooltip, data)
	if not IsShiftKeyDown() then return end
    if tooltip:IsForbidden() then return end
    if tooltip ~= GameTooltip then return end

    local auraID = data and data.id

    if not auraID then
        local info = tooltip:GetPrimaryTooltipInfo()
        if info and info.getterArgs then
            local unit, index, filter = unpack(info.getterArgs)
            local auraData = GetAuraDataByIndex(unit, index, filter)
            auraID = auraData.spellId
        end
    end

    if auraID then
        auraID = ID_FORMAT:format(ID, auraID)
        tooltip:AddLine(auraID)
    end
end)