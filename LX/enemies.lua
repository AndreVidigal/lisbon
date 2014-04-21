 module(...,package.seeall)

local localGroup


function enemies:disposeAll()
    for i=#enemies,1, -1 do
        enemies[i]:removeSelf()
        enemies[i] = nil
    end 
end

function enemies:moveEnemies()

    --print(#enemies)
    local var = #enemies    

    for ind = 1, var, 1 do
        moveVehicle(enemies[ind])    
        enemies[ind].rotateAux = enemies[ind].rotateAux + 1
        
        if enemies[ind].rotateAux == 5 then
            auxFunctions:rotateImage(enemies[ind])             
            enemies[ind].rotateAux = 0
        end
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
            vehicle.offset = vehicle.offset + vehicle.image.speed
        else
            vehicle.path = vehicle.path + 1
            if (vehicle.path > #vehicle.points) then
                vehicle.path = 1
            end
            path = vehicle.points[vehicle.path]
            if (path.switchY == true) then
                vehicle.image.yScale = vehicle.image.yScale * (-1)
            end
            vehicle.offset = path.startOffset
        end
    else
        if (vehicle.offset >= path.endOffset) then
            vehicle.offset = vehicle.offset - vehicle.image.speed
        else
            vehicle.path = vehicle.path + 1
            if (vehicle.path > #vehicle.points) then
                vehicle.path = 1
            end
            path = vehicle.points[vehicle.path]
            if (path.switchY == true) then
                vehicle.image.yScale = vehicle.image.yScale * (-1)
            end
            vehicle.offset = path.startOffset
        end
    end
end



function loadEnemies()
    groupEnemies = display.newGroup( )

    enemiesData  = auxFunctions:load("enemies.json")  

    print("LOADING ENEMIES")

    enemies  = {}

    --totalEnemies = #enemiesData.enemies
    totalEnemies = 5

    for i=1, totalEnemies, 1 do    
        
        enemy = enemiesData.enemies[i]

        enemy.image  = display.newImageRect(getImage(), enemy.width, enemy.height)
        enemy.image.anchorX = 0.5
        enemy.image.anchorY = 0.5
        enemy.image.x = 0
        enemy.image.y = 0
        enemy.image.myName = enemy.name
        enemy.image.xScale = -1
        enemy.image.type   = CAR_TYPE
        enemy.angle = 0
        enemy.image.speed = getSpeed()
        enemy.previousX, enemy.previousY = setOfLines[enemy.points[1].streetNr](enemy.points[1].startOffset)
        enemyCollisionFilter = { categoryBits = 1, maskBits = 4 } 
        physics.addBody( enemy.image, 
                { density = 3.0, 
                  friction = 0.2, 
                  bounce = 0.8, 
                  filter = enemyCollisionFilter } ) 
        
        groupEnemies:insert(enemy.image)

        enemies[i] = enemy        
    end               

    localGroup:insert(groupEnemies)
end

function getSpeed()    
    local randomSpeed = math.random( 3, 8 ) * 0.001
    return randomSpeed
end


function getImage()    
    local random = math.random( 1, 7 )
    return tableImages[random]
end


-- invoked on create Scene
function enemies:initializeEnemies(groupie) 
    print("Init Enemies")
    localGroup = groupie    

    tableImages = {}

    -- Ttpes of enemies
    table.insert(tableImages, "images/enemies/carro1.png")
    table.insert(tableImages, "images/enemies/carro2.png")
    table.insert(tableImages, "images/enemies/carro3.png")
    table.insert(tableImages, "images/enemies/carro4.png")
    table.insert(tableImages, "images/enemies/carro4.png")
    table.insert(tableImages, "images/enemies/taxi.png")
    table.insert(tableImages, "images/tram.png")

    loadEnemies()
    
	go     = AHEAD    

	-- AMV remove this for collisions
	--physics.addBody( car, { density = 1.0, friction = 0.3, bounce = 0.2} )	
end

function enemies:setAlpha(alpha)
    for i=1, #enemies, 1 do
        enemies[i].image.alpha = alpha
    end
end

-- invoked on EnterScene
function enemies:startEnemies()    

    for i=1, #enemies, 1 do
        enemies[i].path   = 1
        enemies[i].offset = enemies[i].points[1].startOffset
        streetNr          = enemies[i].points[1].streetNr
	    x, y              = setOfLines[streetNr](enemies[i].offset)
	    enemies[i].image.x      = math.floor(x)
        enemies[i].image.y      = math.floor(y)        
        enemies[i].rotateAux = 0
    end
end