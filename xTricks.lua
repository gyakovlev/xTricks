-- do not load for other classes eh
if select(2,UnitClass("player")) ~= "ROGUE" then return end

-- whisper to person you've chosen to trick to.
local whispertarget=true
-- color printer
local pr = function(msg)
    print("|cffFF0000x|rTricks:", tostring(msg))
end
-- be locale independent
local ToT=GetSpellInfo(57934)

-- check for existance, macro space and create one if available
local init=function()
--check for existing.
	if GetMacroInfo("xTricks") or GetMacroInfo("xTricks_Set") then
		return
	else
		local _, num = GetNumMacros()
			if num>16 then
				pr("You have no slot for xTricks macro!\n Delete something.")
				return
			else
				CreateMacro("xTricks", "INV_Misc_QuestionMark", "#showtooltip "..ToT.."\n/run print(test)",1)
				CreateMacro("xTricks_Set", "Spell_Shadow_Rune", "/xtricks",1)
				pr("Created xTricks macros for current character\n  You can use xTricks macro to cast ToT.\n  xTricks macro will use tricks the following way:\n  Your target, if friendly > Predefined target > focus if present and friendly and not dead > you target's target if friendly and exists\n  use |cffFF0000/xtricks|r to set predefined target (xTricks_Set macro)")
			end
	end
end
-- bless someone (un)lucky
-- slash commands
SLASH_XTRICKS1="/xtricks"
SlashCmdList["XTRICKS"]=function()
	local t=UnitName("target")
	if t then
		if not InCombatLockdown() then
			EditMacro('xTricks', nil, nil, '#showtooltip '..ToT..'\n/cast [help,nodead][@'..t..'][@focus,help,nodead][@targettarget,help] ' ..ToT..'', nil)
			pr('Preferred Tricks target is '..t)
			if whispertarget==true then
				SendChatMessage("Will put "..GetSpellLink(57934).."on you during combat!","WHISPER",nil,t)
			end
		else
			pr(ERR_NOT_IN_COMBAT)
		end
	else
		pr("Please target someone you want to put tricks on")
	end	
end



local f=CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent",function()
init()
f:UnregisterAllEvents()
f=nil
init=nil
end)

