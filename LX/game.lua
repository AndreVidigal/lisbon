module(...,package.seeall)

local completed       = 0
totalObjectives = 0
local points   = 50

BONUS_PASTEL_BELEM = 1
BONUS_SARDINHA     = 2
BONUS_GINGA        = 3
BONUS_LIMONADA     = 4
BONUS_CAPILE       = 5
BONUS_MAZAGRAN     = 6


function catchObjective(id)
	levelObjectives[id].catched = true
	completed = completed + 1
	goals.text = completed.."/4"
	
	if completed == totalObjectives then
		print("GAME: LevelCompleted")
	end
	return completed
end

function catchTourist(tourist)
	if tourist.y < baloon.height then
		baloon.yScale = -1 
		baloonText.yScale = -1 
	else 
		baloon.yScale = 1 
		baloonText.yScale = 1 
	end
	baloon.x = tourist.x
	baloon.y = tourist.y
	baloon.id = tourist.id
	baloon.alpha = 1.0
	baloonText.text = tourists[tourist.id].dialog
	baloonText.x = baloon.x + 16 + (baloon.width/2)
	baloonText.y = baloon.y - baloon.height + 110
	baloonText.alpha = 1.0
	command.command_.stopped = true
end

function touchedBallon(event)
	command.command_.stopped = false
	baloon.alpha     = 0.0
	baloonText.alpha = 0.0
	levelLoaded.objectives[event.target.id].icon.alpha = 1.0
	physics.addBody( levelLoaded.objectives[event.target.id].icon, { density = 1.0, friction = 0.3, bounce = 0.2, filter = goalCollisionFilter} )	
end


-- This function is invoked in mode "Tourist enters/exits tram" 
function checkObjective(posx, posy)

	var = nil
	
	for i = 1, #levelObjectives, 1 do
		if posx == levelObjectives[i].x and
		   posy == levelObjectives[i].y then
		   var = i
		end
	end

	--var = table.indexOf( levelObjectives, coord )
	
	if var ~= nil then
		-- object was acomplished, but was it the right time?
		if levelLoaded.order == true and var > 1 then
			if levelLoaded.objectives[var-1].accomplished == false then
				display2EarlyMsg()
				return
			end
		end
		objectiveAccomplished(var)
	else 
		print("nope, that point is not an obj", posx, posy)
	end
end

function getPoints()
	return points
end


function display2EarlyMsg()
	print("GAME : too early")
end
	
function objectiveAccomplished(var)
	levelLoaded.objectives[var].accomplished = true
	levelLoaded.objectives[var].icon.isVisible = false
	--print(levelLoaded.objectives[var].dialog[math.random(3)])
	print("GAME " , levelLoaded.objectives[var].dialogs[1])
end

function createBonus()
	
	tableIcons = {}


    bonusGroup = display.newGroup( )    

    local icon1 = display.newImageRect( "images/icons/icon2.png", 86, 86)
    local icon2 = display.newImageRect( "images/icons/icon4.png", 86, 86 )
    local icon3 = display.newImageRect( "images/indice/ginginha.png", 28, 85 )
    local icon4 = display.newImageRect( "images/icons/icon2.png", 86, 86)
    local icon5 = display.newImageRect( "images/icons/icon2.png", 86, 86)
    local icon6 = display.newImageRect( "images/icons/icon2.png", 86, 86)

    table.insert(tableIcons, icon1)
    table.insert(tableIcons, icon2)
    table.insert(tableIcons, icon3)
    table.insert(tableIcons, icon4)
    table.insert(tableIcons, icon5)
    table.insert(tableIcons, icon6)

    icon1.alpha = 0.0
    icon2.alpha = 0.0
    icon3.alpha = 0.0
    icon4.alpha = 0.0
    icon5.alpha = 0.0
    icon6.alpha = 0.0

    icon1.type = BONUS_TYPE
    icon2.type = BONUS_TYPE
    icon3.type = BONUS_TYPE
    icon4.type = BONUS_TYPE
    icon5.type = BONUS_TYPE
    icon6.type = BONUS_TYPE

    icon1.myName = "pastel de belem"
    icon2.myName = "sardinha"
    icon3.myName = "ginginha"
    icon4.myName = "limonada"
    icon5.myName = "capile"
    icon6.myName = "mazagran"

    physics.addBody( icon1, { density = 1.0, friction = 0.3, bounce = 0.2, filter = goalCollisionFilter} )	
    physics.addBody( icon2, { density = 1.0, friction = 0.3, bounce = 0.2, filter = goalCollisionFilter} )	
    physics.addBody( icon3, { density = 1.0, friction = 0.3, bounce = 0.2, filter = goalCollisionFilter} )	
    physics.addBody( icon4, { density = 1.0, friction = 0.3, bounce = 0.2, filter = goalCollisionFilter} )	
    physics.addBody( icon5, { density = 1.0, friction = 0.3, bounce = 0.2, filter = goalCollisionFilter} )	
    physics.addBody( icon6, { density = 1.0, friction = 0.3, bounce = 0.2, filter = goalCollisionFilter} )	

    bonusGroup:insert(icon1)
    bonusGroup:insert(icon2)
    bonusGroup:insert(icon3)
    bonusGroup:insert(icon4)
    bonusGroup:insert(icon5)
    bonusGroup:insert(icon6)

    t = math.random( 1 , 10) * 1000
    timer.performWithDelay( t, showIcon)

end

function showIcon()
	
	--local street = math.random(1, #play.connections)
	local street = 14
	local size = #play.connections[street].cruzaCom

	local min = play.connections[street].cruzaCom[1].offset * 100
	local max = play.connections[street].cruzaCom[size].offset * 100

	local randomOffset = math.random(min, max) / 100

	x, y = setOfLines[street](randomOffset)
	print(randomOffset, x, y)

	--bonusIndex = math.random(1, #tableIcons)
	bonusIndex = 6
	if bonusIndex == BONUS_PASTEL_BELEM then
		tableIcons[bonusIndex].x = 372
		tableIcons[bonusIndex].y = 980
	elseif bonusIndex == BONUS_SARDINHA then
		tableIcons[bonusIndex].x = 1530
		tableIcons[bonusIndex].y = 522
	elseif bonusIndex == BONUS_GINGA then
		tableIcons[bonusIndex].x = 1350
		tableIcons[bonusIndex].y = 562
	elseif bonusIndex == BONUS_LIMONADA then
		tableIcons[bonusIndex].x = 712
		tableIcons[bonusIndex].y = 406
	elseif bonusIndex == BONUS_CAPILE then
		tableIcons[bonusIndex].x = 1004
		tableIcons[bonusIndex].y = 256		
	elseif bonusIndex == BONUS_MAZAGRAN then
		tableIcons[bonusIndex].x = 788
		tableIcons[bonusIndex].y = 798
	end

	--transition.fadeIn(tableIcons[bonusIndex], {time=500})
	auxFunctions:glow(tableIcons[bonusIndex])
end

function addBonus(bonus)
	auxFunctions:stopGlow(bonus)
	if bonus.type == BONUS_TYPE then
		points = points + 5
		t = math.random( 7 , 20) * 1000
    	timer.performWithDelay( t, showIcon)
    	score.text = "score: "..points
    end
end

function createSounds()
	sound_beep1 = audio.loadSound( "audio/beep1.wav" )
	sound_beep2 = audio.loadSound( "audio/beep2.wav" )
	sound_atmosphere = audio.loadStream( "audio/traffic2.wav"  )

	audio.play(sound_atmosphere, { channel=2, loops=-1})
	audio.setVolume( 0.2, { channel=2 } )
	local delay = math.random( 1500, 5500)
	timer.performWithDelay(delay, playSounds)
end

function playSounds()
	audio.play(beep1, { channel=2 } )
end

function getInitialStreet()
	return e_.tram_initial_street
end


function getInitialOffset()
	return e_.tram_initial_offset
end

function loadLevel(num)

	local levelData = auxFunctions:load("level.json")  
	local font_2 = "Belta Regular"
	local font_2 = "Belta Bold"
	local font_2 = "Aracne Regular"

    
	--e_ = levelData.levelsConfiguration[num]
	-- FORCE 1
	e_ = levelData.levelsConfiguration[1]
        
    levelLoaded = {}

    levelLoaded.name    = e_.name
    levelLoaded.id	    = e_.id
    levelLoaded.order   = e_.order

    goalsGroup = display.newGroup( )

    tourists = {}
    tourists = e_.tourists
    for i=1, #e_.tourists, 1 do    
    	tourists[i].image   = display.newImageRect(goalsGroup, tourists[i].icon, 16, 50)
    	tourists[i].image.type = TOURIST_TYPE
    	tourists[i].image.x = tourists[i].x
    	tourists[i].image.y = tourists[i].y
    	tourists[i].image.id = i
    	tourists[i].image.myName = tourists[i].myName
    	physics.addBody( tourists[i].image, { density = 1.0, friction = 0.3, bounce = 0.2, filter = goalCollisionFilter} )	
    end


    levelLoaded.objectives = {}
    levelObjectives = {}

	goalCollisionFilter = { categoryBits = 2, maskBits = 4 } 	

    for i=1, #e_.objectives, 1 do      
        o = {}

        o.name     = e_.objectives[i].name
        o.icon   = display.newImageRect(goalsGroup, "images/goal.png", 40, 50)
        o.icon.myName = o.name
        o.icon.id = i
        o.icon.type = GOAL_TYPE
        o.icon.alpha = 0.0
		
       
        
        o.dialogs = {}

        for j = 1, #e_.objectives[i].dialog, 1 do
        	o.dialogs[j]  = e_.objectives[i].dialog[j]
        end

        o.accomplished = false
	    
	    coord    = {}
	    coord.x  = e_.objectives[i].obj_x
	    coord.y  = e_.objectives[i].obj_y
	    o.icon.x = e_.objectives[i].icon_x
	    o.icon.y = e_.objectives[i].icon_y


        levelLoaded.objectives[i] = o
        levelObjectives[i] = coord
    end    

    createBonus()
    createSounds()

    baloon = display.newImageRect(bonusGroup, "images/baloon.png",260, 225)
    baloon.anchorX = 0.0
    baloon.anchorY = 1.0
    baloon.alpha = 0.0
    baloon:addEventListener("tap", touchedBallon)

    baloonText = display.newText( bonusGroup, " ", 0,0, 150, 0, font_2, 30 )
    --baloonText.anchorY = 1.0
    baloonText:setFillColor( 0.1, 0.0, 0.1 )
    baloonText.alpha = 0.0

    totalObjectives = #levelObjectives
    --totalObjectives = 1

	--score    = display.newText( "SCORE", 100 , display.contentHeight - 60,  font_2, 60 )
	if (display.pixelWidth == 1536) and (display.pixelHeight ==  2048) then	
		backGoals  = display.newRoundedRect( 10, display.contentHeight - 10, 300,80, 6 )
		score     = display.newText( "score: 0", 14 , display.contentHeight - 50,  font_2, 55 )
		goals     = display.newText( "0/4", 240 ,  display.contentHeight - 50,  font_2, 55 )
	else
		backGoals  = display.newRoundedRect( 8, display.contentHeight - 8, 220,60, 6 )
		score     = display.newText( "score: 0", 14 , display.contentHeight - 40,  font_2, 38 )
		goals     = display.newText( "0/4", 186 ,  display.contentHeight - 40,  font_2, 38 )
	end
	
	backGoals:setFillColor(139/255,100/255,97/255, 0.8) 
	backGoals.anchorX = 0
	backGoals.anchorY = 1
	score.anchorX = 0
	goals.anchorX = 0
	goals:setFillColor(0.75, 0.95, 1.0)
	score:setFillColor(0.75, 0.95, 1.0)

    --group:insert(goals)
	--Runtime:addEventListener( "collision", onCollision )

end

