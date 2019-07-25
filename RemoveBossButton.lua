local RemoveTexture = function(self, texture, stopLoop)
	if stopLoop then return end

	self:SetTexture("", true) --2nd argument is to stop endless loop
end
hooksecurefunc(ZoneAbilityFrame.SpellButton.Style, 'SetTexture', RemoveTexture)
hooksecurefunc(ExtraActionButton1.style, 'SetTexture', RemoveTexture)
