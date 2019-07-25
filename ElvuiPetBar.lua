local E, L, V, P, G = unpack(ElvUI)
local CT = E:NewModule("CustomElvuiPetBar")
local EP = LibStub("LibElvUIPlugin-1.0") 
local addonName, addonTable = ... 

local AB = E:GetModule('ActionBars');
--Lua functions
local _G = _G
local NUM_PET_ACTION_SLOTS = NUM_PET_ACTION_SLOTS

function AB:UpdatePetBindings()
	for i=1, NUM_PET_ACTION_SLOTS do
		_G["PetActionButton"..i.."HotKey"]:Hide()
	end
end


