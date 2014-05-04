---------------------------------------------------------------------------------
--
-- scene1.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local centerX = display.contentCenterX
local centerY = display.contentCenterY

local image, text1, text2, text3, memTimer

--display.setDefault( "anchorX", 0.5)
--display.setDefault( "anchorY", 0.5)


-- Touch event listener for background image
local function onSceneTouch( self, event )
	if event.phase == "began" then
		
		storyboard.gotoScene( "scene2", "slideLeft", 800  )
		
		return true
	end
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	
	print("CW and CH", display.contentWidth, display.contentHeight)
	--image = display.newImageRect( "images/Sardinha.jpg",  display.contentWidth, display.contentHeight )
	image = display.newImageRect( "images/indice.png", 1410, 900)


	image.anchorX = 0.5
	image.anchorY = 0
	image.x = centerX
	
	screenGroup:insert( image )
	
	image.touch = onSceneTouch
	
	-- text1 = display.newText( "enter Scene", centerX, 50, native.systemFontBold, 24 )
	-- text1:setFillColor( 1 )
	-- screenGroup:insert( text1 )
	
	-- text2 = display.newText( "MemUsage: ", centerX, centerY, native.systemFont, 16 )
	-- text2:setFillColor( 1 )
	-- screenGroup:insert( text2 )
	
	text3 = display.newText( "Dream applications", centerX, display.contentHeight - 100, native.systemFontBold, 30 )
	text3.anchorX = 0.5
	text3:setFillColor( 0.2 ); 
	text3.isVisible = false
	screenGroup:insert( text3 )
	
	print( "\n1: createScene event")
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	
	print( "1: enterScene event" )
	
	-- remove previous scene's view
	storyboard.purgeScene( "scene4" )
	
	-- Update Lua memory text display
	local showMem = function()
		--image:addEventListener( "touch", image )
		text3.isVisible = true
		--text2.text = text2.text .. collectgarbage("count")/1000 .. "MB"
		--text2.x = centerX
	end
	local nextScene = function()
		storyboard.gotoScene( "scene2", "fade", 200  )
	end
	memTimer = timer.performWithDelay( 2000, showMem, 1 )
	--transition.from( image, { xScale=2.0, yScale=2.5, time=400 } )
	timer.performWithDelay(3000, nextScene, 1)
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	
	print( "1: exitScene event" )
	
	-- remove touch listener for image
	image:removeEventListener( "touch", image )
	
	-- cancel timer
	timer.cancel( memTimer ); memTimer = nil;
	
	-- reset label text
	--text2.text = "MemUsage: "
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	
	print( "((destroying scene 1's view))" )
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

---------------------------------------------------------------------------------

return scene