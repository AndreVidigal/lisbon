--------------------------------------------------------------------------------
--
-- scene1.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene      = storyboard.newScene()
local game       = require('game') 
require( "auxFunctions" )

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------


local options =
{
    --effect = "fade",
    --time = 100,
}

-- Touch event listener for background image
local function onSceneTouch( self, event )
	local group = self.view
	if event.phase == "began" then			
		--local custom = { effect="fadeIn"  }
		options.params = { start = false }			
		storyboard.gotoScene( "indice", options )	
		return true
	end
end

function loadImages(group, day)

	tramGroup = display.newGroup( )

	if (display.pixelWidth == 1536) and (display.pixelHeight ==  2048) then	
		endLevel_img = display.newImageRect(group,  "images/level/endlevel@2x.png", 2048, 1536 )	
		endTram_img  = display.newImageRect(tramGroup,  "images/level/endlevel_tram@2x.png", 1799, 893 )	
		tramTitle = display.newText(tramGroup,  "", 0, 0,  "MountainRetreat", 190 )
		tramTitle.y = 1100		
	else 
		endLevel_img = display.newImageRect(group,  "images/level/endlevel.png", 1280, 960 )	
		endTram_img  = display.newImageRect(tramGroup,  "images/level/endlevel_tram.png", 1125, 559 )	
		tramTitle = display.newText(tramGroup,  "", 0, 0,  "MountainRetreat", 120 )		
		tramTitle.y = 720
	end

	group:insert(tramGroup)

	
	-- CENTER IMAGE ON SCREEN must use these 4 statements
	endLevel_img.anchorX = 0.5
	endLevel_img.anchorY = 0.5
	endLevel_img.x = display.contentCenterX
	endLevel_img.y = display.contentCenterY

	endTram_img.x = display.contentCenterX
	endTram_img.y = display.contentCenterY + 140	

	endLevel_img.touch = onSceneTouch

	
	points = game.getPoints()	

	
	if points < 50 then
		title_1 = "*"			
	elseif points < 100 then
		title_1 = "**"
	elseif points < 250 then
		title_1 = "***"
	elseif points < 500 then
		title_1 = "****"
	else 
		title_1 = "*****"
	end 			

	--title_2 = "points"..tostring(game.getPoints())	

	t1 = display.newText(group,  title_1, display.contentWidth /2 + 100, 160,  "MountainRetreat", 140 )		
	t1.anchorX = 0	
	t1:setFillColor( 0.85, 0.95, 0.0 )	

	tramTitle.anchorX = 0.5	
	tramTitle:setFillColor( 0.1, 0.0, 0.1 )	
	tramTitle.x = display.contentWidth / 2

end

function loadDay( day)
	
	if (day == 1) then
		dayisover = "Monday is over!!"
	end
	if (day == 2) then
		dayisover = "Tuesday is over!!"
	end
	if (day == 3) then
		dayisover = "Wednesday is over!!"
	end
	if (day == 4) then
		dayisover = "Thursday is over!!"
	end
	if (day == 5) then
		dayisover = "Friday is over!!"
	end
	if (day == 6) then
		dayisover = "Saturday is over!!"
	end
	if (day == 7) then
		dayisover = "Sunday is over!!"
	end

	tramTitle.text = dayisover

	
end



-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	loadImages(group)
	print( "\Level Intro: createScene event")

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	print( "-------------------------------")
	print( "End Level: enterScene event" )
	day = tonumber(event.params.day)
	loadDay( day)

	tramGroup.name = "tt"
	tramGroup.anchorX = 0.5
	tramGroup.anchorY = 0.5
	auxFunctions.shake1(tramGroup)
	--storyboard.purgeScene( prior_scene )
	--storyboard.removeScene( prior_scene )
	-- remove previous scene's view
	--storyboard.purgeScene( "scene4" )
	-- Entrar mo jogo	
	local goGame = function()
		print("list")
		endLevel_img:addEventListener( "touch", endLevel_img )
	end

	goGame()
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	print( "End Level: exitScene event" )
	auxFunctions:stopShake()
	
	-- remove touch listener for image
	endLevel_img:removeEventListener( "touch", endLevel_img )
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	print( "((destroying scene Level Intro view))" )
end

function scene:didExitScene( event )
	local group = self.view
	print("did Exit Scene")
	storyboard.purgeScene( "endLevel" )
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

scene:addEventListener( "didExitScene" )


---------------------------------------------------------------------------------

return scene