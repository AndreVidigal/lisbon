module(...,package.seeall)

function trams:moveTrams()

    local var = #trams

    rotateVar = rotateVar + 1
 
    for ind = 1, var, 1 do
    
        if (trams[ind].name ~= crashed) then
            moveTram(trams[ind])
        
            if (rotateVar == 5) then
                 auxFunctions:rotateImage2(trams[ind], trams[ind].image1) 
            end
        end
    end
    if (rotateVar == 5) then
        rotateVar = 0
    end
end


function startTram(vehicle)
    --print("vehicle starting ", vehicle.name)
    vehicle.isStarting = true
end 


function tramStop(vehicle, path)
    
    -- returns false, the tram is accelerating!!
    if vehicle.isStarting == true then
        vehicle.image.speed = vehicle.image.speed * 1.3
        
        if vehicle.image.speed > 0.006 then
            vehicle.image.speed = 0.006
            vehicle.isStarting = false            
        end
        return false
    end

    -- returns true, the tram is stopeed, dont move tram
    if (vehicle.image.speed < 0.0001) then
        vehicle.tramHasStopped = true -- one stop for each segment
        -- the tram is stopped
        return true
    end

    if vehicle.tramHasStopped == true then
        -- keep going, dont check if there's a stop on next lines
        -- code, exit here! 
        return false
    end    

    value = vehicle.offset - path.stop
    --print(vehicle.offset, value)
    
    -- module of value
    if (value < 0) then
        value = value * (-1)
    end
    if value < 0.05 then  -- slowing down
        if vehicle.isStarting == false then        	
            vehicle.image.speed= vehicle.image.speed / 1.1
            if (vehicle.image.speed < 0.0001) then  -- stoped
                --print(vehicle.name, " STOPPED")
                local myClosure2 = function() return startTram( vehicle ) end
                timer.performWithDelay( 2000, myClosure2)
                return true 
            end
        end
    end
    return false
end

function moveTram(vehicle)

    path      = vehicle.points[vehicle.path]  
    streetNr  = path.streetNr  -- streetNumber to be fetched on ruas.json
    x, y      = setOfLines[streetNr](vehicle.offset)    

    -- IS THIS THE TRAM OUR TOURIST IS ON??
    -- if so, then let's have the screen following it!
    if vehicle.image.hasTourist == true then
        a, b = myUtil:paralax(x, y)  
        group.x = a
        group.y = b
        person.x = math.floor( x )
        person.y = math.floor( y )

        if command.command_.stopped == false then
        	if command.command_.breaked == true then
        		-- BREAK, BREAK!!!
        		vehicle.image.speed = vehicle.image.speed / 1.1				
				if (vehicle.image.speed < 0.0001) then
					command.command_.stopped = true 
					return
				end			
			end
    	end 
    end
    
    vehicle.image.x = math.floor( x )
    vehicle.image.y = math.floor( y )
    
    
    if (path.go == AHEAD) then
        if (vehicle.offset <= path.endOffset) then
            if tramStop(vehicle, path) == false then
                vehicle.offset = vehicle.offset + vehicle.image.speed
            end
        else
            vehicle.path = vehicle.path + 1
            -- resets flag to distinguish getting to tram stop from
            -- moving away from tram stop
            vehicle.tramHasStopped = false
            if (vehicle.path > #vehicle.points) then
                vehicle.path = 1
            end
            path = vehicle.points[vehicle.path]
            if (path.switchY == true) then
                vehicle.image1.yScale = vehicle.image1.yScale * (-1)
            end
            vehicle.offset = path.startOffset
        end
    else
        if (vehicle.offset >= path.endOffset) then
            if tramStop(vehicle, path) == false then
                vehicle.offset = vehicle.offset - vehicle.image.speed
            end
        else
            vehicle.path = vehicle.path + 1
            -- resets flag to distinguish getting to tram stop from
            -- moving away from tram stop
            vehicle.tramHasStopped = false
            if (vehicle.path > #vehicle.points) then
                vehicle.path = 1
            end
            path = vehicle.points[vehicle.path]
            if (path.switchY == true) then
                vehicle.image1.yScale = vehicle.image1.yScale * (-1)
            end
            vehicle.offset = path.startOffset
        end
    end
end



function spawnTrams(params)
    
    tram_ = tramsData.tramsFile[params.type]

    spawnedTram      = createTram(tram_)
    spawnedTram.path = params.startPath
    
    table.insert(trams, spawnedTram)

end

function createTram(tram)
    
    tram.image1   = display.newImageRect( tram.imageName, tram.width, tram.height)
    tram.image1.anchorX = 0.5
    tram.image1.anchorY = 0.5    

    tram.image2   = display.newImageRect( tram.im_number, tram.im_width, tram.im_height)
    tram.image2.anchorY = 1.0
    tram.image2.anchorX = 0.3
    tram.image2.y = -10
    
    tram.image    = display.newGroup( )

    tram.image:insert(tram.image1)
    tram.image:insert(tram.image2)        
    tram.image.myName = tram.name
    tram.image.type   = TRAM_TYPE
    tram.image.speed  = tram.speed

    groupTram:insert(tram.image)    

    tramsCollisionFilter = { categoryBits = 1, maskBits = 4 } 
    shapeTram = {-27,-12, 27,-12, 27, 12, -27, 12}
    physics.addBody( tram.image, { density = 3.0, friction = 0.2, bounce = 0.8, filter = tramsCollisionFilter, shape= shapeTram} ) 

    tram.image2:setFillColor(1.0, 1.0, 1.0, 0.4)        
    
    tram.path  = 1        
    tram.isStarting = false
    
    tram.previousX, tram.previousY = setOfLines[tram.points[1].streetNr](tram.points[1].startOffset)

    -- on collisions, we want to know if trams are on same street, because sometimes bodies colide on ~= streets
    --tramGroup.street = tram.path
    
end

function loadTrams()

    tramsData = auxFunctions:load("trams.json")  

    trams = {}

    for i=1, #tramsData.tramsFile, 1 do
    --for i=1, 7, 1 do

        tram = tramsData.tramsFile[i]

        createTram(tram)
        -- Add to trams table, a brand new Enemy!
        trams[i] = tram
    end

    -- We have read the paths and the possible types of trams
    -- lets spawn lots of them based on the previous ones
    -- SPAWN LOTS of motherFu#$" enemies!!!
    --params = { type=5, startPath=4, yScale=1}
    --spawnTrams(params)
end

------------------------------------------
-- invoked on create Scene
------------------------------------------
function trams:initializeTrams() 
    
    groupTram = display.newGroup( )    
    group:insert(groupTram)

    loadTrams()        
    -- Now Load Map Over (already done in mainLoop)
    --group:insert(map1)
end

------------------------------------
-- invoked on EnterScene
------------------------------------
function trams:startTrams()

    for i=1, #trams, 1 do
        trams[i].offset = trams[i].points[1].startOffset
        streetNr        = trams[i].points[1].streetNr
        x, y            = setOfLines[streetNr](trams[i].offset)
        trams[i].image.x      = math.floor(x)
        trams[i].image.y      = math.floor(y)
        trams[i].isVisible = true        

        trams[i].previousX, trams[i].previousY = setOfLines[trams[i].points[1].streetNr](trams[i].points[1].startOffset)
        trams[i].angle = 0
    end

    rotateVar = 0
    
    --trams[1].image.hasTourist = true        
   
    -- SPAWN LOTS of motherFu#$" trams!!!
    --timer.performWithDelay(5000, spawnEnemies, 4)
end       
