local storyboard = require( "storyboard" )
local widget = require( "widget" )
local scene = storyboard.newScene()


-- local forward references should go here --

--levelProgress = 0
--levelImg = {}
--allLevels = {}


levels = 
{	
1, 2, 3, 4, 5,  --1 means level is open to 	be played (level.png)
6, 2, 3, 4, 1,   --2 means level is locked (locked.png)
2, 3, 4, 6, 2,   -- 3 means level is completed (greenchecked.png)
2, 2, 2, 2, 2,
2, 2, 2, 2, 2
}
	
-- images ={
-- 	{ getFile = "images/level.png", types = "play"   },
-- 	{ getFile = "images/lock.png", types = "locked"},
-- 	{ getFile = "images/greenchecked.png", types = "done"}
-- }

images ={
 	{ getFile = "logos/padariaportuguesa.jpg", types = "play"   },
 	--{ getFile = "logos/corvoazul.jpg", types = "locked"},
 	{ getFile = "logos/corvoazul.jpg", types = "play"},
 	{ getFile = "logos/santini.jpg", types = "done"},
 	{ getFile = "logos/museudofado.jpg", types = "play"   },
 	{ getFile = "logos/lisbonlovers.png", types = "play"},
 	{ getFile = "logos/delidelux.jpg", types = "play"}
}

-- Our ScrollView listener
local function scrollListener( event )
    local phase = event.phase
    local direction = event.direction

    if "began" == phase then
        --print( "Began" )
    elseif "moved" == phase then
        --print( "Moved" )
    elseif "ended" == phase then
        --print( "Ended" )
    end

    -- If the scrollView has reached it's scroll limit
    if event.limitReached then
        if "up" == direction then
            print( "Reached Top Limit" )
        elseif "down" == direction then
            print( "Reached Bottom Limit" )
        elseif "left" == direction then
            print( "Reached Left Limit" )
        elseif "right" == direction then
            print( "Reached Right Limit" )
        end
    end

    return true
end
-- Create a ScrollView
local scrollView = widget.newScrollView
{
    left   = 0,
    top    = 60,
    width  = display.contentWidth,
    height = display.contentHeight - 60,

    --------------------------------------
    bottomPadding = 20,
    topPadding = 10,
    id = "onTop",
    horizontalScrollDisabled = true ,
    verticalScrollDisabled = false ,
    hideBackground = true, 
    listener = scrollListener,
    ---------------------------------------
}


local function buttonHit(event)
	local custom = { effect="slideUp", level=event.target.destination }
	storyboard.gotoScene ( "game", {params=custom} )

	--storyboard.gotoScene ( event.target.destination, {effect = "slideUp"} )	
		return true
end

function printPoint(event)
	print(event.x, event.y)
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view	
	
	local scrollGroup = display.newGroup()
	
	local levelIndex = 0
	xValue = 105

	for i=0,4 do
		for j=1,3 do
			tablePlace =   i*3 + j	
			levelIndex = levelIndex + 1
			print(levelIndex)
			
			local imagesId = levels[levelIndex] 

			levelImg = display.newImageRect (images[imagesId].getFile , 110, 65 )
			levelImg.x = 105 + ((j-1)*135)
			print(levelImg.x)
			levelImg.y  = 30 + (i*75)			
			scrollGroup:insert(levelImg)
			
			leveltxt = display.newText("Level "..tostring(tablePlace), 0,0, "Helvetica", 10)
			leveltxt.anchorX = 0.5
			leveltxt.x = 105 + ((j-1)*135)
			leveltxt.y = 90 + (i*65)
			leveltxt:setFillColor (250, 255, 251)
			scrollGroup:insert (leveltxt)
			
			--levelImg.destination = "level0"..tostring(tablePlace)
			levelImg.destination = tostring(tablePlace)

			if images[imagesId].types ~= "locked" then
				levelImg:addEventListener("tap", buttonHit)
			end
		end		
	end
			
	scrollView:insert(scrollGroup)	
	
	--Runtime:addEventListener("tap", printPoint)

	-- CREATE display objects and add them to 'group' here.
	-- Example use-case: Restore 'group' from previously saved state.

	local title = display.newText( "Level Selection", display.contentCenterX, 0, "Helvetica", 20 )
	title.anchorX = 0.5	
	title.y = 40
	group:insert(title)
	
	local backBtn = display.newText(  "Back", 0, 0, "Helvetica", 20 )
	backBtn.x = display.screenOriginX + 50
	backBtn.y = display.contentHeight  - 30 
	backBtn.destination = "menu" 
	backBtn:addEventListener("tap", buttonHit)
	group:insert(backBtn)


end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view

	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view

	-- INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	-- Remove listeners attached to the Runtime, timers, transitions, audio tracks

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view

	-- INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	-- Remove listeners attached to the Runtime, timers, transitions, audio tracks

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
	



