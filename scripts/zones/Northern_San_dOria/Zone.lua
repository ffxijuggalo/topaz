-----------------------------------
--
-- Zone: Northern_San_dOria (231)
--
-----------------------------------

package.loaded["scripts/zones/Northern_San_dOria/TextIDs"] = nil;
require("scripts/globals/server");
require("scripts/globals/settings");
require("scripts/globals/titles");
require("scripts/globals/quests");
require("scripts/zones/Northern_San_dOria/TextIDs");

-----------------------------------
-- onInitialize
-----------------------------------

function onInitialize(zone)			
	zone:registerRegion(1, -7,-3,110, 7,-1,155);		
end;			

-----------------------------------			
-- onZoneIn			
-----------------------------------			

function onZoneIn(player,prevZone)			
	cs = -1;		
	-- FIRST LOGIN (START CS)		
	if(prevZone == 0) then		
		if(OPENING_CUTSCENE_ENABLE == 1) then	
			cs = 0x0217;
		end	
		player:setPos(0,0,-11,191);	
		player:setHomePoint();	
	end		
	-- MOG HOUSE EXIT		
	if((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then		
		player:setPos(130,-0.2,-3,160);	
		if(player:getMainJob() ~= player:getVar("PlayerMainJob")) then	
			cs = 0x7534;
		end	
		player:setVar("PlayerMainJob",0);	
	end		
	-- RDM AF3 CS		
	if(player:getVar("peaceForTheSpiritCS") == 5 and player:getFreeSlotsCount() >= 1) then		
		cs = 0x0031;	
	end		
	return cs;	
end;		

-----------------------------------		
-- onRegionEnter		
-----------------------------------		

function onRegionEnter(player,region)		
	switch (region:GetRegionID()): caseof	
	{	
	[1] = function (x)  -- Chateau d'Oraguille access	
	pNation = player:getNation();	
	currentMission = player:getCurrentMission(pNation)	
	if((pNation == 0 and player:getRank() >= 2) or (pNation > 0 and player:hasCompletedMission(pNation,5) == 1) or (currentMission >= 5 and currentMission <= 9) or (player:getRank() >= 3)) then	
		player:startEvent(0x0239);
	else	
		player:startEvent(0x0238);
	end	
	end,	
	}	
end;		

-----------------------------------		
-- onRegionLeave		
-----------------------------------		

function onRegionLeave(player,region)		
end;		

-----------------------------------		
-- onEventUpdate		
-----------------------------------		

function onEventUpdate(player,csid,option)		
	--printf("CSID: %u",csid);	
	--printf("RESULT: %u",option);	
end;		

-----------------------------------		
-- onEventFinish		
-----------------------------------		

function onEventFinish(player,csid,option)		
	--printf("CSID: %u",csid);	
	--printf("RESULT: %u",option);	
	if(csid == 0x0217) then	
		player:messageSpecial(ITEM_OBTAINED,0x218);
	elseif(csid == 0x7534 and option == 0) then	
		player:setHomePoint();
		player:messageSpecial(HOMEPOINT_SET);
	elseif(csid == 0x0239) then	
		player:setPos(0,0,-13,192,0xe9);
	elseif(csid == 0x0031) then	
		player:addTitle(PARAGON_OF_RED_MAGE_EXCELLENCE);
		player:addItem(12513);
		player:messageSpecial(ITEM_OBTAINED, 12513); -- Warlock's Chapeau
		player:setVar("peaceForTheSpiritCS",0);
		player:addFame(SANDORIA,AF3_FAME);
		player:completeQuest(SANDORIA,PEACE_FOR_THE_SPIRIT);
	end	
end;		
