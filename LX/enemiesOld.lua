 module(...,package.seeall)




function moveNonCollisionObjects()
	    
    if (bouncingUp) then
    	angle = angle + 0.04
    	if (angle > 3) then
    		bouncingUp = false
    	end
    else
    	angle = angle - 0.04
    	if (angle < -0.4) then
    		bouncingUp = true
    	end
    end
    
    transition.to( ship, { rotation=angle, time=0, x = ship.x -value, transition=easing.inOutCubic } )

    if (ship.x > display.contentWidth + ship.width) then
    	ship.x = -10    	
    end
end

function enemies:disposeAll()
    for i=#smiles,1,-1 do
        smiles[i]:removeSelf()
        smiles[i] = nil
    end 
end

function enemies:moveEnemies()

    --print(#enemies)
    local var = #enemies

    aux = aux + 1
    for ind = 1, var, 1 do
        moveVehicle(enemies[ind])    
        
        if (aux == 5) and (enemies[ind].isPeople == false) then
             auxFunctions:rotateImage(enemies[ind]) 
         end
    end
    if (aux == 5) then
        aux = 0
    end

    --movePeople()
    moveNonCollisionObjects()

end

function movePeople()
     
     person.x = person.x + (0.3*back)
     person.y = person.y + (0.3*back)

     if(person.x >= 920) then
        back = -1
    end
     if (person.x <= 850) then
        back = 1
    end

end


function moveVehicle(vehicle)

    path      = vehicle.points[vehicle.path]  
    streetNr  = path.streetNr  -- streetNumber to be fetched on ruas.json
    x, y      = setOfLines[streetNr](vehicle.offset)
    
    vehicle.image.x = math.floor(x)
    vehicle.image.y = math.floor(y)

    if (path.go == AHEAD) then
        if (vehicle.offset <= path.endOffset) then
            vehicle.offset = vehicle.offset + enemiesSpeed
        else
            vehicle.path = vehicle.path + 1
            if (vehicle.path > #vehicle.points) then
                vehicle.path = 0
            end
            path = vehicle.points[vehicle.path]
            if (path.switchY == true) then
                vehicle.image.yScale = vehicle.image.yScale * (-1)
            end
            vehicle.offset = path.startOffset
        end
    else
        if (vehicle.offset >= path.endOffset) then
            vehicle.offset = vehicle.offset - enemiesSpeed
        else
            vehicle.path = vehicle.path + 1
            if (vehicle.path > #vehicle.points) then
                vehicle.path = 0
            end
            path = vehicle.points[vehicle.path]
            if (path.switchY == true) then
                vehicle.image.yScale = vehicle.image.yScale * (-1)
            end
            vehicle.offset = path.startOffset
        end
    end
end

-- gets a different image when spawning
function getImage()

    newEnemy = newEnemy + 1
    if (newEnemy > #tableImages) then
        newEnemy = 1
    end

    return tableImages[newEnemy]
end


function spawnEnemies(event)

    local params = event.source.params

    --for i=0, number, 1 do
        local e = enemies[params.type] 

        local enemy = {}

        enemy.name    = "ss" .. #enemies
        enemy.image   = display.newImageRect(group, getImage(), e.image.width, e.image.height)
        enemy.number  = #enemies
        enemy.image.xScale  = e.image.xScale
        enemy.image.yScale  = params.yScale

        enemy.points = {}

        for j=0, #e.points, 1 do      
            t = {}
            t.startOffset = e.points[j].startOffset
            t.endOffset = e.points[j].endOffset
            t.streetNr = e.points[j].streetNr
            t.go = e.points[j].go
            t.switchY = e.points[j].switchY
            
            enemy.points[j] = t
        end

        enemy.image.anchorX = 0.5
        enemy.image.anchorY = 0.5

        enemy.isPeople = false
 
        --transition.to( enemy.image, { rotation = e_.initRotation, time=200} )
        enemy.previousX, enemy.previousY = setOfLines[enemy.points[0].streetNr](enemy.points[0].startOffset)


        --enemy.path      = tonumber(event.source.params.startPath)
        enemy.path      = event.source.params.startPath
        enemy.offset    = e.points[0].startOffset
        streetNr        = e.points[0].streetNr
        x, y            = setOfLines[streetNr](enemy.offset)
        enemy.x         = math.floor(x)
        enemy.y         = math.floor(y)
        enemy.isVisible = true
        enemy.angle = 0

        -- Add to enemies table, a brand new Enemy!
        
        table.insert(enemies, enemy)
        --printTable()

    --end

end

function loadEnemies()
    local enemiesData = auxFunctions:load("enemies.json")  
    e_ = enemiesData.enemiesFile[1]

    enemies = {}

    for i=1, #enemiesData.enemiesFile, 1 do
    --for i =6, 6, 1 do
        
        e_ = enemiesData.enemiesFile[i]
        
        local enemy = {}

        enemy.name          = e_.name
        enemy.image         = display.newImageRect(group, e_.image, e_.width, e_.height)
        enemy.number        = e_.number
        enemy.image.xScale  = e_.xScale
        enemy.image.yScale  = e_.yScale

        enemy.points = {}

        for j=0, #e_.points-1, 1 do      
            t = {}
            t.startOffset = e_.points[j+1].startOffset
            t.endOffset = e_.points[j+1].endOffset
            t.streetNr = e_.points[j+1].streetNr
            t.go = e_.points[j+1].go
            t.switchY = e_.points[j+1].switchY
            
            enemy.points[j] = t
        end

        enemy.image.anchorX = 0.5
        enemy.image.anchorY = 0.5
        enemy.x = 0
        enemy.y = 0
        enemy.angle = 0
        if (e_.isPeople ~= nil) then
            enemy.isPeople = e_.isPeople
        else
            enemy.isPeople = false
        end

        --transition.to( enemy.image, { rotation = e_.initRotation, time=200} )
        enemy.previousX, enemy.previousY = setOfLines[enemy.points[0].streetNr](enemy.points[0].startOffset)


        -- Add to enemies table, a brand new Enemy!
        enemies[i] = enemy
    end

    -- We have read the paths and the possible types of enemies
    -- lets spawn lots of them based on the previous ones
    --spawnEnemies(5, "clone", 4)
   -- print(">>>", #enemies)
end

-- invoked on create Scene
function enemies:initializeEnemies() 

    loadEnemies()
    person   = display.newImageRect(group, "images/enemies/pessoa1.png", 15, 20)
    person.x = 830
    person.y = 880
    back = 1
    -- this var is for loading a different kind of image when spawning
    newEnemy = 0
	-- car = display.newRect(0,0,14,22)
	-- car:setFillColor(0,220,0, 170)
	-- car.name = "car"
	-- group:insert( car)
    tableImages = {}

    table.insert(tableImages, "images/enemies/carro1.png")
    table.insert(tableImages, "images/enemies/carro2.png")
    table.insert(tableImages, "images/enemies/carro3.png")
    table.insert(tableImages, "images/enemies/carro4.png")
    table.insert(tableImages, "images/enemies/taxi.png")
		
	value = 0.45

	go     = AHEAD

    aux = 0

    enemiesSpeed = 0.004

	-- AMV remove this for collisions
	--physics.addBody( car, { density = 1.0, friction = 0.3, bounce = 0.2} )	
end


-- invoked on EnterScene
function enemies:startEnemies()

    for i=1, #enemies, 1 do
        enemies[i].path   = 0
        enemies[i].offset = enemies[i].points[0].startOffset
        streetNr       = enemies[i].points[0].streetNr
	    x, y           = setOfLines[streetNr](enemies[i].offset)
	    enemies[i].x      = math.floor(x)
        enemies[i].y      = math.floor(y)
        enemies[i].isVisible = true
    end

    ship = display.newImageRect(group, "images/ship.png", 266, 118)
    ship.name = "ship"
    ship.anchorX = 0.9
	ship.anchorY = 0.5
	
	bouncingUp = true
	angle = 0

	ship.x = map.width  -30
    ship.y = map.height -120

    -- SPAWN LOTS of motherFu#$" enemies!!!
    tm = timer.performWithDelay(5000, spawnEnemies, 3)
    tm.params = { type=3, startPath=0, yScale=1}
    
    
    tm = timer.performWithDelay(50, spawnEnemies, 1)
    tm.params = { type=5, startPath=3, yScale =1 }
    

	--taxi:addEventListener( "touch", onTouch )
end

function printTable()
    for i=1, #enemies, 1 do
        print("----------", i, "----------")
        print(enemies[i].points[0].startOffset)
        print(enemies[i].points[0].streetNr)
    end

end
-- Processes the touch events on the background. Moves the taxi object accordingly.
onTouch = function(event)--{{{
	-- if gameIsOver then
	-- 	return
	-- end
	
	if "began" == event.phase then
		taxi.isFocus = true

		taxi.x0 = event.x - taxi.x
		taxi.y0 = event.y - taxi.y
        elseif taxi.isFocus then
			if "moved" == event.phase then
                taxi.x = event.x - taxi.x0
                taxi.y = event.y - taxi.y0
                --coerceOnScreen( taxi )
            elseif "ended" == phase or "cancelled" == phase then
                taxi.isFocus = false
            end
        end
 
        -- Return true if touch event has been handled.
        return true
end--}}}

