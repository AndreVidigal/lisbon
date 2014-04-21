module(...,package.seeall)

local completed       = 0
totalObjectives = 0
local points   = 50

function catchObjective(id)
	levelObjectives[id].catched = true
	completed = completed + 1
	
	if completed == totalObjectives then
		print("GAME: LevelCompleted")
	end
	return completed
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

    table.insert(tableIcons, icon1)
    table.insert(tableIcons, icon2)

    icon1.alpha = 0.0
    icon2.alpha = 0.0

    icon1.type = BONUS_TYPE
    icon2.type = BONUS_TYPE

    physics.addBody( icon1, { density = 1.0, friction = 0.3, bounce = 0.2, filter = goalCollisionFilter} )	
    physics.addBody( icon2, { density = 1.0, friction = 0.3, bounce = 0.2, filter = goalCollisionFilter} )	

    bonusGroup:insert(icon1)
    bonusGroup:insert(icon2)

	bonusIndex = 1
    t = math.random( 7 , 20)
    timer.performWithDelay( t, showIcon)

end

function showIcon()

	local street = math.random(1, #play.connections)

	local size = #play.connections[street].cruzaCom

	local min = play.connections[street].cruzaCom[1].offset * 100
	local max = play.connections[street].cruzaCom[size].offset * 100

	local randomOffset = math.random(min, max) / 100

	x, y = setOfLines[street](randomOffset)
	print(randomOffset, x, y)

	tableIcons[bonusIndex].x = x
	tableIcons[bonusIndex].y = y

	transition.fadeIn(tableIcons[bonusIndex], {time=500})
	bonusIndex = bonusIndex + 1
end

function catchBonus()
	   
end


function loadLevel(num)

	local levelData = auxFunctions:load("level.json")  

    
	e_ = levelData.levelsConfiguration[num]
        
    levelLoaded = {}

    levelLoaded.name    = e_.name
    levelLoaded.id	    = e_.id
    levelLoaded.order   = e_.order


    levelLoaded.objectives = {}
    levelObjectives = {}

    goalsGroup = display.newGroup( )

	goalCollisionFilter = { categoryBits = 2, maskBits = 4 } 	

    for i=1, #e_.objectives, 1 do      
        o = {}

        o.name     = e_.objectives[i].name
        o.icon   = display.newImageRect(goalsGroup, "images/goal.png", 40, 50)
        o.icon.myName = o.name
        o.icon.id = i

		
        physics.addBody( o.icon, { density = 1.0, friction = 0.3, bounce = 0.2, filter = goalCollisionFilter} )	
        
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

    totalObjectives = #levelObjectives

    --group:insert(goals)
	--Runtime:addEventListener( "collision", onCollision )

end

