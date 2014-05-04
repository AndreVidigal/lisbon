--------------------------------------------------------------------------------
--
-- scene1.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local auxFunctions = require("auxFunctions")
local scene      = storyboard.newScene()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local options =
{
    effect = "fade",
    time = 200,
}

-- Touch event listener for background image
local function onSceneTouch( self, event )
	if event.phase == "began" then			
		options.params =   { day=self.day }
		storyboard.gotoScene( "mainLoop", options)	
		--storyboard.gotoScene( "endLevel", options )	
		return true
	end
end

function displayFonts()
	local fonts = native.getFontNames()

	for i, fontname in ipairs(fonts) do
    	print( "fontname = " .. tostring( fontname ) )
	end
end


function loadChosenDay(group, day)
	if (display.pixelWidth == 1536) and (display.pixelHeight ==  2048) then			
		day_img1 = display.newText( group, tableDays_Eng[day],   190 , 130,  font_4, 320 )
		day_img2 = display.newText( group, tableDays_Eng[day+7], 190 , 130,  font_4, 320 )
	else 
		day_img1 = display.newText( group, tableDays_Eng[day],   60 , 100,  font_4, 175 )
		day_img2 = display.newText( group, tableDays_Eng[day+7], 60 , 100,  font_4, 175 )
	end

	day_img1:setFillColor( 245/255, 1, 88/255 )
	day_img1.anchorX = 0
	day_img1.anchorY = 0
	day_img2:setFillColor( 245/255, 1, 88/255 )
	--day_img2:setFillColor( 225/255, 0.1, 88/255 )
	day_img2.anchorX = 0
	day_img2.anchorY = 0
	auxFunctions.shakeRandom1(day_img2)
	auxFunctions.shakeRandom2(day_img1)
end


function loadImages(group)

	font_1 = "MountainRetreat"
	font_2 = "Belta Light"
	font_3 = "Windsor Hand"
	font_4 = "Belta Regular"
	font_5 = "Aracne Regular"
	font_6 = "Windsor Hand"

	tableDays_Eng = {}
	table.insert(tableDays_Eng, "M ND Y")
	table.insert(tableDays_Eng, "TU SDA ")
	table.insert(tableDays_Eng, "WE     AY")
	table.insert(tableDays_Eng, "T UR D Y")
	table.insert(tableDays_Eng, "  ID Y")
	table.insert(tableDays_Eng, "S TURD Y")
	table.insert(tableDays_Eng, "S ND Y")

	table.insert(tableDays_Eng, " O  A")
	table.insert(tableDays_Eng, "  E    Y")
	table.insert(tableDays_Eng, "   DNSD")
	table.insert(tableDays_Eng, " H  S   ")
	table.insert(tableDays_Eng, "FR A")
	table.insert(tableDays_Eng, " A    A")
	table.insert(tableDays_Eng, " U  A ")
	
	goal_1 = "1- See the Torre de Belem"
	goal_2 = "2- Have a pizza at Casanova"
	goal_3 = "3- Checkout the Bullfight Arena"
	goal_4 = "4- Jazz time at the Hot Club"

	--displayFonts()		

	if (display.pixelWidth == 1536) and (display.pixelHeight ==  2048) then	
		back_img = display.newImageRect( group, "images/level/monday@2x.png", 2048, 1536 )	
		t1 = display.newText( group, goal_1, 945, 640,  font_6, 100 )
		t2 = display.newText( group, goal_2, 960, 790,  font_6, 100 )
		t3 = display.newText( group, goal_3, 975, 940,  font_6, 100 )
		t4 = display.newText( group, goal_4, 990, 1090, font_6, 100 )
	else
		back_img = display.newImageRect( group, "images/level/monday.png", 1280, 960 )		
		t1 = display.newText( group, goal_1, 565 , 300,  font_6, 65 )
		t2 = display.newText( group, goal_2, 570 , 420,  font_6, 65 )
		t3 = display.newText( group, goal_3, 570 , 538,  font_6, 65 )
		t4 = display.newText( group, goal_4, 590 , 658 , font_6, 65 )
	end

	

	--back_img = display.newImageRect( group, "images/level/monday.png", 1180, 900 )	
	
	-- CENTER IMAGE ON SCREEN must use these 4 statements
	back_img.anchorX = 0.5
	back_img.anchorY = 0.5
	back_img.x = display.contentCenterX
	back_img.y = display.contentCenterY

	back_img.touch = onSceneTouch

	--displayFonts()
	t1.anchorX = 0
	t2.anchorX = 0
	t3.anchorX = 0
	t4.anchorX = 0
	t1:setFillColor( 0, 0, 0.1 )
	t2:setFillColor( 0, 0, 0.1 )
	t3:setFillColor( 0, 0, 0.1 )
	t4:setFillColor( 0, 0, 0.1 )
	-- end of center image --

	--back_img.y = display.contentHeight

	--auxFunctions:setImage(tracejado)
	--imgTimer = Runtime:addEventListener("enterFrame", moveTracejado)

	--transition.moveBy( indice, { y = 86, time= 800 } )
	--transition.moveBy( _1_, { x = display.contentWidth/2 - 310, time=620 })

	--Runtime:addEventListener("enterFrame", bouncingBoat)

end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local groupSceneLevel = self.view		
	loadImages(groupSceneLevel)
	print( "\Level Intro: createScene event")

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	
	local groupSceneLevel = self.view
	day = tonumber(event.params.day)

	loadChosenDay(groupSceneLevel, day)

	print( "Level Intro: enterScene event" )
	--print("purging indice")
	--storyboard.purgeScene( "indice" )
	
	--storyboard.purgeScene( prior_scene )
	--storyboard.removeScene( prior_scene )
	
	-- remove previous scene's view
	--storyboard.purgeScene( "scene4" )

	-- Entrar no jogo
	back_img.day = day
	local goGame = function()		
		back_img:addEventListener( "touch", back_img )
	end

	timer.performWithDelay( 1000, goGame, 1 )
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local groupSceneLevel = self.view
	
	print( "Scene Level: exitScene event" )
	
	-- remove touch listener for image
	back_img:removeEventListener( "touch", back_img )
	day_img1:removeSelf()
	day_img2:removeSelf()
	day_img1 = nil
	day_img2 = nil
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local groupSceneLevel = self.view
	print( "SceneLevel:((destroying scene Level Intro view))" )
end


function scene:didExitScene( event )
	local groupSceneLevel = self.view
	storyboard.purgeScene( "scenelevel" )
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

--scene:addEventListener( "didExitScene" )


---------------------------------------------------------------------------------

return scene