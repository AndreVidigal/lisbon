module(...,package.seeall)


local FORWARD  =  1
local BACKWARD = -1
TRAM_SPEED    =  0.005

--local starts_on    = 11
--local starts_offset = 0.1
--local starts_dest   = 2 -- goes to index 2 on connections[starts_on]
local INIT_DIRECTION = 1

savedSpeed = TRAM_SPEED

function loadConnectionsAndCrossroads()
	crossRoadsData  = auxFunctions:load("crossroads.json")  
	connectionsData = auxFunctions:load("connection.json")  

    crossRoads  = {}
    connections = {}

    for i=1, #crossRoadsData.crossroads, 1 do    
        
        --crossroad = {}
        crossroad = crossRoadsData.crossroads[i]
        -- Add to trams table, a brand new Enemy!
        --crossRoads[i] = crossroad
        crossRoads[i] = crossroad
    end        

    for i=1, #connectionsData.connections, 1 do    
        
        --crossroad = {}
        connection = connectionsData.connections[i]
        -- Add to trams table, a brand new Enemy!
        connections[connection.estaRua] = connection
    end     
end


function getNextDest(initialStreet, initialOffset)
	i = 1
	while(connections[initialStreet].cruzaCom[i].offset < initialOffset) do
		i = i + 1
	end
	return i	

end

function initLisbonTram(groupie, initialStreet, initialOffset)	

	localGroup = groupie

	lisbonTram = {}   

	lisbonTram.image   = display.newImageRect( "images/lisbonTram.png", 60, 27)
	lisbonTram.image.myName = "LisbonTram"

	starts_on     = initialStreet
	starts_offset = initialOffset
	starts_dest   = getNextDest(initialStreet, initialOffset)

	command.initializeCommand()
	resetTram()

	lisbonTramGroup = display.newGroup( )
	lisbonTramGroup:insert(lisbonTram.image)	


	lisbonTramCollisionFilter = { categoryBits = 4, maskBits = 3 } 
	shapeTram = {-27,-10, 27,-10, 27, 10, -27, 10}
	physics.addBody( lisbonTram.image, { density = 22.0, friction = 71.3, bounce = 0.0, 
		                                 filter = lisbonTramCollisionFilter, shape = shapeTram} )	

	
	initCrossRoadEvents()
	command.setTram(lisbonTram, savedSpeed)	
	rotateVar = 0
	lisbonTram.speed = TRAM_SPEED
end


function findAnotherBothWayStreet(cr, fromIndex)

	index = fromIndex + 1
	
	if index > #cr.rua then
		return -1
	end

	while cr.rua[index].bothWays ~= true do
		index = index + 1
		if (index > #cr.rua) then	
			return -1			
		end
	end
	return index
end

function userTapsCrossing(event)


	local cr = crossRoads[event.target.id]
	local currSel

	--- find selected street
	for i=1, #cr.rua, 1 do		
		--print(i, " ", cr.rua[i].selected)
		if cr.rua[i].selected ~= 0 then
			currSel = i			
			break
		end
	end

	-- specialIndex is the one being selected (round robin for fork!)
	--if (specialIndex == #cr.rua) then
	--	specialIndex = 0	
	--end

	--- change table, to deselect all but our special index
	-- for i=1, #cr.rua, 1 do
	-- 	if i == specialIndex+1 then
	-- 		cr.rua[i].selected = 1
	-- 		if cr.rua[i].bothWays == true then
	-- 			cr.rua[i].dir   = -1 * cr.rua[i].dir
	-- 			cr.rua[i].angle = 180 + cr.rua[i].angle
	-- 			if cr.rua[i].angle >= 360 then
	-- 				cr.rua[i].angle = cr.rua[i].angle - 360
	-- 			end
	-- 		end			
	-- 		--change image
	-- 		changeImage(cr, cr.rua[i].angle)
	-- 	else 
	-- 		cr.rua[i].selected = 0
	-- 	end
	-- end

	if currSel == #cr.rua then
		nextSel = 1
	else 
		nextSel = currSel + 1
	end
	
	
	if (currSel ~= #cr.rua) then
		if (cr.rua[currSel].selected == 1) then
			cr.rua[currSel].selected = 0
			cr.rua[nextSel].selected = 1
			changeImageDirection(cr, cr.rua[nextSel].angle, nextSel)

		elseif (cr.rua[currSel].selected == -1)	 then					
			
			index = findAnotherBothWayStreet(cr, currSel)			
			
			if index == -1 then						
				cr.rua[currSel].selected = 0
				cr.rua[1].selected = 1
				index = 1
			else
				cr.rua[currSel].selected = 0				
				cr.rua[index].selected = -1				
			end
			
	 		changeImageDirection(cr, cr.rua[index].angle, index)		

		end
	else 	
		if (cr.rua[currSel].selected == -1) then
			cr.rua[currSel].selected = 0
			cr.rua[1].selected = 1
			index = 1
		else
			index = findAnotherBothWayStreet(cr, 0)	-- starts from 1 (adds 1 on findAnother...) 				
			if index == -1 then				
				cr.rua[1].selected = 1			
				index  = 1
			else			
				cr.rua[currSel].selected = 0
				cr.rua[index].selected = -1			
			end			
	 	end
	 	changeImageDirection(cr, cr.rua[index].angle, index)		

	end	
end


function changeImageDirection(cr, angle, index)
	if cr.rua[index].bothWays == true then		
		cr.rua[index].dir   = -1 * cr.rua[index].dir
		cr.rua[index].angle = 180 + cr.rua[index].angle
		if cr.rua[index].angle >= 360 then
			cr.rua[index].angle = cr.rua[index].angle - 360
		end
	end
	transition.to( cr.image, { rotation=cr.rua[index].angle, time=0 } )	
end

function changeImage_(crossing, angle)
	--crRotation = crossing.image.rotation + 90
	--transition.to( crossing.image, { rotation=crRotation, time=0 } )	
	transition.to( crossing.image, { rotation=angle, time=0 } )	
end

function play:setAlpha(alpha)
    for i=1, #enemies, 1 do
    	crossRoads[i].image.alpha = alpha        
    end
end

function initCrossRoadEvents()

	crossGroup = display.newGroup( )

	for i=1, #crossRoads, 1 do
		crossEventArea    = display.newCircle( crossRoads[i].posX, crossRoads[i].posY, 32 )		
		crossEventArea.id = i
		--crossEventArea:addEventListener("tap", userChangesCrossroad)	
		crossEventArea:addEventListener("tap", userTapsCrossing)	
		crossEventArea.alpha = 0.0
		crossEventArea.isHitTestable = true		
		 -- insert into Group
		crossGroup:insert(crossEventArea)

		crossEventArea.crossImage = display.newImageRect( "images/crossing.png", 50,14)
		crossEventArea.crossImage.anchorX = 1
		crossEventArea.crossImage.anchorY = 0.5
		--crossEventArea.crossImage.isVisible = true
		crossEventArea.crossImage.x = crossEventArea.x
		crossEventArea.crossImage.y = crossEventArea.y
		crossEventArea.crossImage.rotation = crossRoads[i].rua[1].angle
		--crossEventArea.crossImage.rotation = 0

		crossRoads[i].image = crossEventArea.crossImage
		-- insert into Group
		crossGroup:insert(crossEventArea.crossImage)
	end	

end


function getIndex(ruaNr)	
	for i=1, #connections[lisbonTram.street].cruzaCom, 1 do
		if connections[lisbonTram.street].cruzaCom[i].rua == ruaNr then
			return i
		end
	end
end

function releaseTram()
	command.command_.stopped = false
	command.command_.breaked = false	
	lisbonTram.speed = TRAM_SPEED
end

-- function actionCommand(event)
-- 	lisbonTram.direction = lisbonTram.direction * -1
-- 	lisbonTram.destCross = -3
-- 	checkCrossing(lisbonTram.offset)
-- end

function checkCrossing(offset)
	--index   = getCrossing(offset)
	--crossing = connections[lisbonTram.street].cruzaCom[index].crossing

	local crossing = lisbonTram.destCross	
	--print("Checking crossing", crossing)
	local x = crossing
	local value

	if x < 0  then		
		-- (-3 means outside the map, so the tram goes back in)
		if x == -3 then 
			lisbonTram.direction = lisbonTram.direction * -1
			lisbonTram.offset = lisbonTram.destOffset		
		else
			newOffset = getNextStreetWithNoConnection(r.rua, lisbonTram.street)
			lisbonTram.street    = r.rua		
			lisbonTram.offset    = newOffset
			if x == -1 then
				lisbonTram.direction = FORWARD
			else 
				lisbonTram.direction = BACKWARD
			end
		end
	else
		--print("Crossing", crossing)
		rua = whichPathSelected(crossing)

		previousStreet = lisbonTram.street

		lisbonTram.street    = rua.nome
		lisbonTram.direction = rua.dir
		lisbonTram.offset    = rua.offset	
		--lisbonTram.image.yScale = 1
	end

	--print(lisbonTram.street, lisbonTram.direction, lisbonTram.offset)

	-- next intersection 	
	r = getNextIntersection()
	lisbonTram.destOffset = r.offset
	lisbonTram.destCross  = r.crossing	
	--print(lisbonTram.street, lisbonTram.direction, lisbonTram.offset, lisbonTram.destCross, lisbonTram.destOffset)

	-- AVOID BUMPS
	lisbonTram.offset = lisbonTram.offset + lisbonTram.speed*(lisbonTram.direction)

end

function getNextStreetWithNoConnection(street1, street2)
	
	for i=1, #connections[street1].cruzaCom, 1 do
		if connections[street1].cruzaCom[i].rua == street2 then			
			return connections[street1].cruzaCom[i].offset
		end 
	end
end


function restart()
	lisbonTram.image.x  = math.floor( x )
    lisbonTram.image.y  = math.floor( y )    
    a, b = myUtil:paralax(x, y)
    localGroup.x = a
    localGroup.y = b
	auxFunctions:stopGlow(lisbonTram.image)
	command.command_.stopped = true
	--physics.pause( )
	physics.removeBody( lisbonTram.image )
	print("Timer")
	auxFunctions:glow(lisbonTram.image)
	timer.performWithDelay( 7000, resumePhysics , 1)
end

function resumePhysics()
	print("resume")
	auxFunctions:stopGlow(lisbonTram.image)
	physics.addBody( lisbonTram.image, { density = 22.0, friction = 71.3, bounce = 0.0, 
		                                 filter = lisbonTramCollisionFilter, shape = shapeTram} )	
	
end

-- This function is like a reset to restart the game or just start for the 1st time
function resetTram()
	lisbonTram.street      = connections[starts_on].estaRua
	lisbonTram.offset      = starts_offset
	lisbonTram.direction   = INIT_DIRECTION	
	lisbonTram.destOffset  = connections[starts_on].cruzaCom[starts_dest].offset
	lisbonTram.destCross   = connections[starts_on].cruzaCom[starts_dest].crossing
	lisbonTram.previousX,  lisbonTram.previousY  = setOfLines[starts_on](0.0)

	transition.to( lisbonTram.image, { rotation = 0,  time=0} )

	initParallaxMap()

	-- START GAME WITH TRAM STOPPED
	command.resetCommand()	
end


function initParallaxMap()			
    x, y = setOfLines[starts_on](starts_offset)
    lisbonTram.image.x  = math.floor( x )
    lisbonTram.image.y  = math.floor( y )    
    a, b = myUtil:paralax(x, y)
    localGroup.x = a
    localGroup.y = b
end

function whichPathSelected(crossing)
	for i=1, #crossRoads[crossing].rua, 1 do
		if crossRoads[crossing].rua[i].selected ~= 0 then
			return crossRoads[crossing].rua[i]
		end
	end
end

function getNextIntersection()
	nrRuasCruzamento = #connections[lisbonTram.street].cruzaCom
	local index = -1	

	--print("nextINt: ", lisbonTram.street,  lisbonTram.offset )

	for i=1, nrRuasCruzamento, 1 do
		-- search for the offset on the street, we must stop on the previous crossing  or the next one
		-- depending on the direction. when we get there, let's check the direction and so on...	
		--print("--", lisbonTram.street,lisbonTram.offset)			
		if connections[lisbonTram.street].cruzaCom[i].offset == lisbonTram.offset then
			-- found equal, but we must find the first that is different, because
			-- it might exist more than one offset with the same value...
			if lisbonTram.direction == BACKWARD then				
				return connections[lisbonTram.street].cruzaCom[i-1]
			end
			index = i				
		else 
			if index ~= -1	then -- FORWARD 
				return connections[lisbonTram.street].cruzaCom[index+1]
			end
		end
	end	
	print("BAD MISTAKE")
end


-- function startGame()
-- 	-- -- wait a second and start Tram
-- 	--  x, y  = setOfLines[starts_on](starts_offset)
--  -- --    -- if so, then let's have the screen following it!      
--  --     a, b = myUtil:paralax(x, y)  
--  --     group.x = a
--  --     group.y = b
--  --     lisbonTram.image.x  = math.floor( x )
--  --     lisbonTram.image.y  = math.floor( y )  
--  	initParallaxMap()
--  	lisbonTram.speed = 0.0
--  	moveLisbonTram() 
-- end

function moveLisbonTram()
    
    if command.command_.stopped == true then
    	return
    end

    x, y  = setOfLines[lisbonTram.street](lisbonTram.offset)

    -- if so, then let's have the screen following it!      
    a, b = myUtil:paralax(x, y)  
    localGroup.x = a
    localGroup.y = b  
    

	if command.command_.stopped == false then
		if command.command_.breaked == true then
			-- BREAK, BREAK!!!
			lisbonTram.speed = lisbonTram.speed / 1.3				
			if (lisbonTram.speed < 0.0001) then
				command.command_.stopped = true 
				return
			end			
		end
	end

    lisbonTram.image.x  = math.floor( x )
    lisbonTram.image.y  = math.floor( y )

	--print(lisbonTram.offset)

    rotateVar = rotateVar + 1

    if (rotateVar == 5) then
		auxFunctions:rotateImage(lisbonTram)
		rotateVar = 0 
	end
    --lisbonTram.image.x = math.floor( x )
    --lisbonTram.image.y = math.floor( y )    
    
    if lisbonTram.direction == FORWARD then
    	if lisbonTram.offset < lisbonTram.destOffset then
    		lisbonTram.offset = lisbonTram.offset + lisbonTram.speed
		else 
			checkCrossing(lisbonTram.destOffset)
		end
    else
		if lisbonTram.offset > lisbonTram.destOffset then
    		lisbonTram.offset = lisbonTram.offset - lisbonTram.speed
		else 
			checkCrossing()
		end
	end
end


------------------------------
function reorderConnection(selectedRua)	
	for i=1, #crossRoads[4].rua, 1 do
		numeroRua = c_.rua[i].nome
		connections[numeroRua].next = selectedRua
		connections[numeroRua].next = selectedRua
	end

end


function tramChangesLine()
	-- if lisbonTram.street == lisbonTram.nextStreet then
	-- 	lisbonTram.direction = -1 * lisbonTram.direction
	-- 	lisbonTram.direction = -1 * lisbonTram.direction
	-- 	return
	-- end

	lisbonTram.street    = lisbonTram.nextStreet
	lisbonTram.offset    = lisbonTram.nextOffset
	lisbonTram.direction = lisbonTram.nextDirection	

	-- get the next street and this street offset (where to exit)
	local ruaNr = connections[lisbonTram.street].next 
	ix = getIndex(ruaNr)
	lisbonTram.nextStreet    = connections[lisbonTram.street].cruzaCom[ix].rua
	lisbonTram.leaveOnOffset = connections[lisbonTram.street].cruzaCom[ix].offset	
	lisbonTram.nextDirection = connections[lisbonTram.street].cruzaCom[ix].direction
	lisbonTram.nextOffset    = connections[lisbonTram.street].cruzaCom[ix].offset2
end


function userChangesCrossroad(event)	
	--print(event.target.id)

	c_ = crossRoads[event.target.id]

	for i=1, #c_.rua, 1 do
		if c_.rua[i].selected == 1 then
			-- deselect 
			c_.rua[i].selected = 0			
		else
			-- this street is selected
			c_.rua[i].selected = 1			
			-- change direction if needed (street selected may have 2 possible directions)			
			if c_.rua[i].bothWays == true then
				c_.rua[i].dir   = -1 * c_.rua[i].dir
				c_.rua[i].angle = 180 + c_.rua[i].angle
				if c_.rua[i].angle >= 360 then
					c_.rua[i].angle = c_.rua[i].angle - 360
				end
			end			
			--change image
			changeImage(c_, c_.rua[i].angle)
			--reorderConnection(c_.rua[i].nome)
		end
	end
end