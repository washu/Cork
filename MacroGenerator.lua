
local myname, Cork = ...
local MAX_ACCOUNT_MACROS, MAX_CHARACTER_MACROS = 36, 18

local function GetMacroID()
	for i=(MAX_ACCOUNT_MACROS+1),(MAX_ACCOUNT_MACROS+MAX_CHARACTER_MACROS) do if GetMacroInfo(i) == "Cork" then return i end end
end

function Cork.GenerateMacro()
	if InCombatLockdown() then return end

	local id = GetMacroID()
	if id then PickupMacro(id)
	elseif select(2, GetNumMacros()) < MAX_CHARACTER_MACROS then
		local body, ic, ooc
		local c = Cork.MYCLASS
		if c == "DEATHKNIGHT" then ooc = GetSpellInfo(3714)
		elseif c == "HUNTER"  then ooc = GetSpellInfo(13165)
		elseif c == "SHAMAN"  then ooc = GetSpellInfo(324)
		elseif c == "WARLOCK" then ooc = GetSpellInfo(687)
		elseif c == "WARRIOR" then ooc = GetSpellInfo(6673)
		elseif c == "DRUID"   then ic, ooc = GetSpellInfo(22812), GetSpellInfo(1126)
		elseif c == "MAGE"    then ic, ooc = GetSpellInfo(30482), GetSpellInfo(1459)
		elseif c == "PALADIN" then ic, ooc = GetSpellInfo(20154), GetSpellInfo(19740)
		elseif c == "PRIEST"  then ic, ooc = GetSpellInfo(588),   GetSpellInfo(21562)
		elseif c == "MONK"	  then ooc = GetSpellInfo(115921) end
		if ic and ooc then
			body = "#showtooltip [combat] "..ic.."; "..ooc.."\n/cast [combat] "..ic.."\n/stopmacro [combat]\n/click CorkFrame"
		elseif ooc then
			body = "#showtooltip "..ooc.."\n/click CorkFrame"
		else
			body = "/click CorkFrame"
		end
		local id = CreateMacro("Cork", 1, body, true)
		PickupMacro(id)
	end
end
