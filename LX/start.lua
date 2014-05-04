---------------------------------------------------------------------------------
--
-- scene1.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
require("auxFunctions")
local scene = storyboard.newScene()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

--local centerX = display.contentCenterX
--local centerY = display.contentCenterY

local image
local PT = 1
local EN = 2
local SOUND_ON  = 1
local SOUND_OFF = 2

local lan_sel = PT
local sound   = SOUND_ON

local custom
local started = true

--display.setDefault( "anchorX", 0)
--display.setDefault( "anchorY", 0)

local options =
{
    --effect = "fade",
    --time = 100,
}


-- Touch event listener for background image
local function onSceneTouch( self, event )
	if event.phase == "began" then						
		if started == true then			
			options.params = { start = true }			
		else 			
			options.params = { start = false }						
		end
		storyboard.gotoScene( "indice", options)			
		return true
	end
end


function changeLanguage(event)
	if event.phase == "began" then				
		if (lan_sel == EN and event.target.id == PT) then
			lan_sel = PT
			language_pt:setFillColor( 232/255,197/255,11/255 )
			language_en:setFillColor( 1 )
			entrarImage.text = "entrar"
		end
		if (lan_sel == PT and event.target.id == EN) then 
			lan_sel = EN
			language_en:setFillColor( 232/255,197/255,11/255 )		
			language_pt:setFillColor( 1 )
			entrarImage.text = "enter"
		end
	end
end

function changeSound(event)	
	if sound == SOUND_ON then
		print("Put sound off")
		sound = SOUND_OFF
		noSound.alpha = 0.7
		audio.setVolume( 0.0 )			
	else		
		sound = SOUND_ON
		print("Put sound on")
		noSound.alpha = 0.0			
		audio.setVolume( 1.0 )			
	end	
end

function loadImages(group)
	grupo  = display.newGroup( )
	grupo2 = display.newGroup( )

	group:insert(grupo)
	group:insert(grupo2)

	local font_2 = "Belta Bold"
		
	if (display.pixelWidth == 1536) and (display.pixelHeight ==  2048) then	
		fundo       	= display.newImageRect( grupo, "images/start/lxcapa_fundo@2x.png", 2048, 3071)	
		cloudsImage 	= display.newImageRect( grupo2,"images/start/farAwayClouds.png", 1200, 579 )	
		shipImage       = display.newImageRect( grupo, "images/start/ship.png", 298/2, 334/2)
		cacilheiroImage = display.newImageRect( grupo, "images/start/cacilheiro.png", 110/2, 139/2)
		aviaoImage 		= display.newImageRect( grupo, "images/start/aviao.png", 468/2, 280/2)	
		electricoImage 	= display.newImageRect( grupo, "images/start/electrico.png", 290/2, 195/2)
		--entrarImage 	= display.newImageRect( grupo, "images/start/entrar.png", 190, 66)		
		language_pt     = display.newText( grupo, "local (PT) | ", display.contentWidth/2 - 120 , 3000,  font_2, 64 )
		language_en     = display.newText( grupo, "tourist (EN) ", display.contentWidth/2 + 120 , 3000,  font_2, 64 )
		soundArea       = display.newCircle( display.contentWidth -81,  display.contentHeight - 76 , 50)			
		noSound	   		= display.newImageRect( grupo, "images/start/nosound.png", 100, 100)
		noSound.x       = display.contentWidth - 83
		noSound.y       = 3000 - 22
	else 
		fundo       	= display.newImageRect( grupo, "images/start/lxcapa_fundo.png", 1200, 1799 )	
		cloudsImage 	= display.newImageRect( grupo2,"images/start/farAwayClouds.png", 1200, 579 )	
		shipImage       = display.newImageRect( grupo, "images/start/ship.png", 298/2, 334/2)
		cacilheiroImage = display.newImageRect( grupo, "images/start/cacilheiro.png", 110/2, 139/2)
		aviaoImage 		= display.newImageRect( grupo, "images/start/aviao.png", 468/2, 280/2)	
		electricoImage 	= display.newImageRect( grupo, "images/start/electrico.png", 290/2, 195/2)		
		--entrarImage 	= display.newImageRect( grupo, "images/start/entrar.png", 190, 66)	
		language_pt     = display.newText( grupo, "local (PT)  | ", display.contentWidth/2 - 120 , 1744,  font_2, 58 )
		language_en     = display.newText( grupo, " tourist (EN) ", display.contentWidth/2 + 120 , 1744,  font_2, 58 )
		soundArea    	= display.newCircle( display.contentWidth -52, display.contentHeight - 52 , 40)			
		noSound	   		= display.newImageRect( grupo, "images/start/nosound.png", 60,  60)			
		noSound.x       = display.contentWidth - 53
		noSound.y       = 1744
	end

	language_pt:setFillColor(232/255,197/255,11/255)
	language_pt.id = PT
	language_en.id = EN
	language_pt:addEventListener("touch", changeLanguage)
	language_en:addEventListener("touch", changeLanguage)
	

	fundo.anchorX = 0
	fundo.anchorY = 0
	fundo.y = 0
	

	cloudsImage.anchorX = 0	
	cloudsImage.anchorY = 0
	cloudsImage.y = 80

	--- Aviao --
	aviaoImage.y = display.contentHeight / 1.5
	aviaoImage.x = 0

	--- Electrico --
	electricoImage.y = fundo.height - (display.contentHeight / 2)
	electricoImage.x = display.contentWidth

	--- SHIP  ---
	shipImage.y = fundo.height - 140
	shipImage.x = display.contentWidth / 4
	shipImage.isVisible = false

	ship1 = {}
	ship1.image = shipImage
	ship1.bouncingUp = true
	ship1.angle = 1
	ship1.value = -0.3

	--- Cacilheiro ---
	cacilheiroImage.y = fundo.height - (display.contentHeight / 1.5)
	cacilheiroImage.x = display.contentWidth / 3
	cacilheiroImage.isVisible = false

	cacilheiro1 = {}
	cacilheiro1.image = cacilheiroImage
	cacilheiro1.bouncingUp = false
	cacilheiro1.angle = 1
	cacilheiro1.value = -0.1

	--- create an array of ships for Boucing event Listener ---
	ships = {}
	ships[0] = ship1
	ships[1] = cacilheiro1

	--- Entrar only appears after scrolling ---
	entrarImage 	= display.newText( grupo, "entrar", 0, 0, font_2, 60)
	entrarImage.isVisible = false
	entrarImage.anchorX = 0.5
	entrarImage.x = display.contentWidth / 2
	entrarImage.y = fundo.height / 1.6
	entrarImage.touch = onSceneTouch
	entrarImage:setFillColor(134/255,163/255,156/255)

	-- SOUND			
	soundArea.alpha = 0.0
	noSound.alpha = 0.0
	soundArea.isHitTestable = true			
end

function initBoat()
	shipImage.isVisible = true
	cacilheiroImage.isVisible = true
	move_ = -1
	Runtime:addEventListener("enterFrame", bouncingBoat)	
end

function bouncingBoat()
	moveTram()
	for i=0, #ships, 1 do 
		if (ships[i].bouncingUp) then
    		ships[i].angle = ships[i].angle + 0.04
	    	if (ships[i].angle > 3) then
	    		ships[i].bouncingUp = false
	    	end
	    else
	    	ships[i].angle = ships[i].angle - 0.04
	    	if (ships[i].angle < -0.4) then
	    		ships[i].bouncingUp = true
	    	end
	    end
	    transition.to( ships[i].image, { rotation=ships[i].angle, time=0, x = ships[i].image.x -ships[i].value, transition=easing.inOutCubic } )
	end
end


function moveTram()
	if (electricoImage.x < -100 ) then
   		move_ = 1
   	end
   	if (electricoImage.x > display.contentWidth + 100 ) then
   		move_ = -1
   	end
   	
   	electricoImage.x = electricoImage.x + (move_*2)		

end
-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	--local screenGroup = self.view
	
	print(display.contentWidth, display.contentHeight)
	print("CW and CH", display.contentWidth, display.contentHeight)	

	loadImages(group)
	
	print( "\n1: createScene event")


end

function displayFonts()
	-- Code to have Corona display the font names found
	--
	local fonts = native.getFontNames()

	count = 0

	-- Count the number of total fonts
	for i,fontname in ipairs(fonts) do
	    count = count+1
	end

	print( "\rFont count = " .. count )

	local name = "M"     -- part of the Font name we are looking for

	name = string.lower( name )

	-- Display each font in the terminal console
	for i, fontname in ipairs(fonts) do
	    j, k = string.find( string.lower( fontname ), name )

	    if( j ~= nil ) then

	        print( "fontname = " .. tostring( fontname ) )

	    end
	end
	---------------------------------------------------------
end



-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view

	print( "1: enterScene event", event.params.start, event.params.effect )

	if event.params.start == true then			
		local backgroundMusic = audio.loadStream( "audio/deolinda.mp3" )
		--audio.play( backgroundMusic, {channel=1, loop=-1} )

		
		-- remove previous scene's view
		--storyboard.purgeScene( "scene4" )
		
		-- aviao flies by
		transition.to( aviaoImage, { y = display.contentHeight / 4, x = display.contentWidth + 200,  time=3700, transition = easing.linear } )
		-- image pans down
		timer.performWithDelay(3200, panImage, 1)
		
		-- hide the Whale
		--timer.performWithDelay(6000, hideWhale, 1)

		-- Boats and ships start cruising...
		initBoat()
		
		-- Entrar menu goes in!
		local nextScene = function()
			entrarImage:addEventListener( "touch", entrarImage )
			entrarImage.isVisible = true
		end

		local soundCommand = function()
			soundArea:addEventListener("tap", changeSound)				
		end

		timer.performWithDelay( 8000, soundCommand, 1 )
		timer.performWithDelay( 9000, nextScene, 1 )
		print(display.contentHeight, display.viewableContentHeight, fundo.height)
		
		--timer.performWithDelay(3000, nextScene, 1)
	else
		entrarImage:addEventListener( "touch", entrarImage )
		started = false
	end
end

function panImage()
	panningY = display.viewableContentHeight - fundo.height
	print("panning", panningY)
	transition.to( grupo, { y = panningY, time=5000, transition = easing.inOutQuad } )
	transition.to( cloudsImage, { y = -570, time=5000, transition = easing.inOutQuad } )
end
	
function hideWhale()
	whaleImage.isVisible = false
end



-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	print( "1: exitScene event" )
	
	-- remove touch listener for image
	entrarImage:removeEventListener( "touch", entrarImage )

	-- removes this scene
	--storyboard.removeScene( "start" )
	
	-- cancel timer
	--timer.cancel( memTimer ); memTimer = nil;
	
	-- reset label text
	--text2.text = "MemUsage: "
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	print( "((destroying scene 1's view))" )
end

function scene:didExitScene( event )
	local group = self.view
	--storyboard.purgeScene( "start" )
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