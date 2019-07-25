LoadAddOn("Blizzard_CombatText")
local xOffset, yOffset = 300, 200

function CombatText_AddMessage(message, scrollFunction, r, g, b, displayType, isStaggered)
  local string, noStringsAvailable = CombatText_GetAvailableString();
  if ( noStringsAvailable ) then
    return;
  end
 
  string:SetText(message);
  string:SetTextColor(r, g, b);
  string.scrollTime = 0;
  if ( displayType == "crit" ) then
    string.scrollFunction = CombatText_StandardScroll;
  else
    string.scrollFunction = scrollFunction;
  end
 
  -- See which direction the message should flow
  local yDir;
  local lowestMessage;
  local useXadjustment = 0;
  if ( COMBAT_TEXT_LOCATIONS.startY < COMBAT_TEXT_LOCATIONS.endY ) then
    -- Flowing up
    lowestMessage = string:GetBottom();
    -- Find lowest message to anchor to
    for index, value in pairs(COMBAT_TEXT_TO_ANIMATE) do
      if ( lowestMessage >= value.yPos - 16 - COMBAT_TEXT_SPACING) then
        lowestMessage = value.yPos - 16 - COMBAT_TEXT_SPACING;
      end
    end
    if ( lowestMessage < (COMBAT_TEXT_LOCATIONS.startY - COMBAT_TEXT_MAX_OFFSET) ) then
      if ( displayType == "crit" ) then
        lowestMessage = string:GetBottom();
      else
        COMBAT_TEXT_X_ADJUSTMENT = COMBAT_TEXT_X_ADJUSTMENT * -1;
        useXadjustment = 1;
        lowestMessage = COMBAT_TEXT_LOCATIONS.startY - COMBAT_TEXT_MAX_OFFSET;
      end
    end
  else
    -- Flowing down
    lowestMessage = string:GetTop();
    -- Find lowest message to anchor to
    for index, value in pairs(COMBAT_TEXT_TO_ANIMATE) do
      if ( lowestMessage <= value.yPos + 16 + COMBAT_TEXT_SPACING) then
        lowestMessage = value.yPos + 16 + COMBAT_TEXT_SPACING;
      end
    end
    if ( lowestMessage > (COMBAT_TEXT_LOCATIONS.startY + COMBAT_TEXT_MAX_OFFSET) ) then
      if ( displayType == "crit" ) then
        lowestMessage = string:GetTop();
      else
        COMBAT_TEXT_X_ADJUSTMENT = COMBAT_TEXT_X_ADJUSTMENT * -1;
        useXadjustment = 1;
        lowestMessage = COMBAT_TEXT_LOCATIONS.startY + COMBAT_TEXT_MAX_OFFSET;
      end
    end
  end
 
  -- Handle crits
  if ( displayType == "crit" ) then
    string.endY = COMBAT_TEXT_LOCATIONS.startY;
    string.isCrit = 1;
    string:SetTextHeight(COMBAT_TEXT_CRIT_MINHEIGHT);
  elseif ( displayType == "sticky" ) then
    string.endY = COMBAT_TEXT_LOCATIONS.startY;
    string:SetTextHeight(COMBAT_TEXT_HEIGHT);
  else
    string.endY = COMBAT_TEXT_LOCATIONS.endY;
    string:SetTextHeight(COMBAT_TEXT_HEIGHT);
  end
 
  -- Stagger the text if flagged
  local staggerAmount = 0;
  if ( isStaggered ) then
    staggerAmount = fastrandom(0, COMBAT_TEXT_STAGGER_RANGE) - COMBAT_TEXT_STAGGER_RANGE/2;
  end
 
  -- Alternate x direction
  CombatText.xDir = CombatText.xDir * -1;
  if ( useXadjustment == 1 ) then
    if ( COMBAT_TEXT_X_ADJUSTMENT > 0 ) then
      CombatText.xDir = -1;
    else
      CombatText.xDir = 1;
    end
  end
  string.xDir = CombatText.xDir;
  string.startX = COMBAT_TEXT_LOCATIONS.startX + staggerAmount + (useXadjustment * COMBAT_TEXT_X_ADJUSTMENT) + xOffset;
  string.startY = lowestMessage + yOffset;
  string.yPos = lowestMessage;
  string:ClearAllPoints();
  string:SetPoint("TOP", WorldFrame, "BOTTOM", string.startX, lowestMessage);
  string:SetAlpha(1);
  string:Show();
  tinsert(COMBAT_TEXT_TO_ANIMATE, string);
end
