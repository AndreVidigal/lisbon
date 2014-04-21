local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

--display.setStatusBar( display.HiddenStatusBar )

-- Example of bezier curve module on how to use it
-- Author: Rajendra Pondel (@neostar20)

-- main.lua
require( "myUtil" )
require( "auxFunctions" )
require( "physics" )
require( "game")

local enemies   = require('enemies')
local trams     = require('trams')
local container = require('container')
local play      = require('play')
local command   = require('command')

CAR_TYPE    = 1
TRAM_TYPE   = 2
BONUS_TYPE  = 3



local index_
local tempTable_
local offset_
-- local commandGo
-- local commandBrake
local pause_
local text_ 


-- GLOBAL and available on other modules
setOfLines = {}
tableInfo  = {}
map        = nil

AHEAD  =  1
BEHIND =  2
----------------------------------------------

local rotateTram             = {}
local levelComplete_YouWin   = {}
local levelComplete_YouLoosw = {}
local moving               	 = {}
local initializeTram    	 = {}
local initializeStreets 	 = {}
local loadLevel         	 = {}
local moveBezier        	 = {}


local previousX
local previousY
local paused

-- this flag controls the stop/go of the tram
local stopped
local breaked

--tram = display.newCircle( 120, 0, 12 ) 
--tram = display.newRect( 0,0, 14, 20 )

--group = display.newGroup()

--physics.setDrawMode("debug")

print(display.contentWidth, display.contentHeight)


function createContainer()

	contX      = display.contentWidth/2
	contY      = display.contentHeight - display.contentHeight / 9
	contWidth  = display.contentWidth / 1.5
	contHeight = display.contentHeight / 9

	container.createContainer(contX, contY, contWidth, contHeight)
	content = { }
	
	tuple = {}
	tuple.text  = ""
	tuple.thumb = nil
	content[1] = tuple

	tuple = {}
	tuple.text  = "b"
	tuple.thumb = "images/icons/icon1.png"
	content[2] = tuple

	tuple = {}
	tuple.text  = "c"
	tuple.thumb =  "images/icons/icon2.png"
	content[3] = tuple

	tuple = {}
	tuple.text  = "d"
	tuple.thumb =  "images/icons/icon3.png"
	content[4] = tuple

	tuple = {}
	tuple.text  = "e"
	tuple.thumb =  "images/icons/icon4.png"
	content[5] = tuple
	
	container.setContainersTable(content)
end


------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------  INIT FUNCTIONS -------------------------------------------------------

function initializeMap()

	map = display.newImageRect( "images/mapa_layer0.png", 2048, 1536)	
	--map = display.newRect(  0,0,2048, 1536)	
	--map = display.newImage( group, "images/mapa_layer0.png")	
	--map.isVisible = false
	map.anchorX = 0
	map.anchorY = 0

	map1 = display.newImageRect( "images/mapa_layer2.png", 2048, 1536)
	--map1 = display.newRect( 0,0, 2048, 1536)
	--map1 = display.newImage( "images/mapa_layer2.png")
	map1.anchorX = 0
	map1.anchorY = 0		
end	


-- initializes the tram joystick/command 
function initializePauseCommand()
	pause_ = display.newImageRect( "images/pause_icon.png", 45, 45)
	pause_.name = "pause"
	pause_.anchorX = 80
	pause_.anchorY = 80
	pause_.x = 50
	pause_.y = 50
	--pause_.y =   50
end


----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

-- 30 frames per second from configuration
function moving()	
	-- Loopinng... dont' forget
	enemies:moveEnemies()
	--trams:moveTrams()
	play.moveLisbonTram()
end


-- On Level Complete remove listeners and shows restart msg
function levelComplete_YouWin()
	removeListeners()
	print("Level Complete")
	--text_.isVisible = true	
end


-- On Level Complete remove listeners and shows restart msg
function levelComplete_YouLoose()
	---
end


-- PAUSE ACTION : Adds / Removes listeners
function actionPause()
	if (paused == true) then
		addListeners()		
		paused = false
	else
		removeListeners()
		paused = true
	end
end



-- ADDS ALL LISTENERS
function addListeners()		
	play.releaseTram()
	play.lisbonTram.image:addEventListener("tap", command.actionCommand)
	Runtime:addEventListener("enterFrame", moving)
	Runtime:addEventListener( "collision", onCollision )				
end


-- REMOVES ALL LISTENERS
function removeListeners()
	Runtime:removeEventListener("enterFrame", moving)
	Runtime:removeEventListener( "collision", onCollision )			
	play.lisbonTram.image:removeEventListener("tap", command.actionCommand)
end





--reset level
function youLoose()
    -- simply go to level1.lua scene
    enemies:setAlpha(0)
    storyboard.gotoScene( "reset", "fade", 250 )     
    return true -- indicates successful touch
end

--reset level
function youWin()
    -- simply go to level1.lua scene
    storyboard.gotoScene( "endlevel", "fade", 250 )     
    return true -- indicates successful touch
end


function onCollision( event )

    if ( event.phase == "began" ) then

    	if event.object1.myName ~= "LisbonTram" then
    		return 
    	end

        print( "began: " .. event.object1.myName .. " and " .. event.object2.myName )
        -- animate catch object
        -- sound catching...
        -- destriy object
        if event.object2.type == TRAM_TYPE or event.object2.type == CAR_TYPE then
        	--event.object2:removeSelf();
	        --event.object2 = nil;
	        -- crash	        	        
	        print("Crashed")
	        removeListeners()
	        timer.performWithDelay( 100, youLoose, 1)
        elseif event.object2.type == BONUS_TYPE then
        	game.addBonus(event.object2.myName)
        	event.object2:removeSelf()
	        event.object2 = nil
        else
        	nrObjectives = game.catchObjective(event.object2.id)

	        if nrObjectives == game.totalObjectives then
	        	event.object2:removeSelf()
	        	event.object2 = nil;
	        	timer.performWithDelay( 200, youWin, 1) 
	        	return
	        end
	        event.object2:removeSelf()
	        event.object2 = nil;

	    end

    elseif ( event.phase == "ended" ) then    	    		    	
        print( "ended: " .. event.object1.myName .. " and " .. event.object2.myName )
    end
end
------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-----------------------------      MAIN PROGRAM     ---------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
local levelLoaded = -1

function scene:createScene( event )
	local groupie = self.view		
	
	--groupie:insert(group)
	print("create Scene MAINLOOP")

	-- Initializes the streets
	gameData = auxFunctions:load("ruas.json")

	connection = {}
	xCoords    = {}
	yCoords    = {}

	-- initializa streets
	for i=1, 35, 1 do
		line = gameData.streets[i].street.line
		for j=1, #line, 1 do
			xCoords[j] = line[j].x 
			yCoords[j] = line[j].y 
		end	
		local curve = auxFunctions:createBezier(xCoords, yCoords) 
		            --{line[1].y, line[2].y, line[3].y, line[4].y, line[5].y, line[6].y})	
		table.insert(setOfLines, curve)
		connection[i] = gameData.streets[i].street.inter	
	end	

	-- Initializes the Lisbon Map Image
	initializeMap()

	groupie:insert(map)

	-- Initializes Physics
	physics.start()								
	physics.setGravity( 0, 0 )

	-- initialize all the crossings and events over crossings
	play.loadConnectionsAndCrossroads()

	-- create the Lisbon Tram and its physics
	play.initLisbonTram(groupie)

	-- level Loaded coming from parameter
	levelLoaded = tonumber(event.params.level)

	-- Loads the objectives to "catch"
	game.loadLevel(levelLoaded)

	-- Init Enemies
	enemies:initializeEnemies(groupie)
	
	--trams:initializeTrams()	
	--initializeText()
	-- Add a new Layer Of Maps, so the tram can pass behind trees and stuff        
    groupie:insert(play.crossGroup)
    groupie:insert(play.lisbonTramGroup)
    groupie:insert(game.bonusGroup)
    groupie:insert(map1)
    groupie:insert(game.goalsGroup)

	-- Initialize Pause command
	initializePauseCommand()
	groupie:insert(pause_)	

    --createContainer()
end
	

function scene:enterScene( event )
	local groupie = self.view	

	paused = false	

	--add Pause 
	pause_:addEventListener("tap", actionPause)

	-- START other cars / charactes positioning	
	enemies:startEnemies()	

	-- START TRAMS 
	--trams:startTrams()
	play.resetTram(groupie)	

	--Start timer
	--timer.performWithDelay( 10000, youLoose, 1 )

	-- START GAME (adds the movement!!)	
	timer.performWithDelay(1500, addListeners, 1)
	timer.performWithDelay(1500, enemies:setAlpha(1))		
	
end

function scene:exitScene( event )		
	local groupie = self.view	
	removeListeners()
	pause_:removeEventListener("tap", actionPause)
	print("Exit Scene Main Loop")
end

function scene:destroyScene( event )
	local groupie = self.view	
	removeListeners()
	pause_:removeEventListener("tap", actionPause)
	print("destroy Scene Main Loop")
end

function scene:didExitScene( event )
	--storyboard.purgeScene( "mainLoop" )
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
scene:addEventListener( "didExitScene" )

return scene
