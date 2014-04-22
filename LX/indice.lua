---------------------------------------------------------------------------------
--
-- scene1.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

require("auxFunctions")

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

--local centerX = display.contentCenterX
--local centerY = display.contentCenterY

local image

--display.setDefault( "anchorX", 0)
--display.setDefault( "anchorY", 0)


-- Touch event listener for background image
local function onSceneTouch( self, event )
	if event.phase == "began" then			
		storyboard.gotoScene( "scenelevel")	
		return true
	end
end

function loadImages(group)
	if (display.pixelWidth == 1536) and (display.pixelHeight ==  2048) then	
		fundo = display.newImageRect(group, "images/indice/fundo@2x.png", 2048 , 1536  )
		indice = display.newImageRect(group, "images/indice/indice.png", 496, 186)
		tracejado1 = display.newImageRect(group, "images/indice/tracejado.png", 2500, 58)
		tracejado2 = display.newImageRect(group, "images/indice/tracejado.png", 2500, 58)
		_1_ = display.newImageRect(group, "images/indice/1_avidaportuguesa2.png", 647 , 100 )
		_1i_ = display.newImageRect(group, "images/indice/andorinha.png", 112 , 115 )
		_2_ = display.newImageRect(group, "images/indice/2_quiosque2.png", 390 , 106 )
		_2i_ = display.newImageRect(group, "images/indice/quiosque.png", 102 , 123 )
		_3_ = display.newImageRect(group, "images/indice/3_lisbonlovers2.png", 530 , 86)
		_3i_ = display.newImageRect(group, "images/indice/electrico.png", 135 , 59 )
		_4_ = display.newImageRect(group, "images/indice/4_ginginha2.png", 400 , 125 )
		_4i_ = display.newImageRect(group, "images/indice/ginginha.png", 56 , 170)
		_5_ = display.newImageRect(group, "images/indice/5_museus2.png", 306 , 100 )
		_5i_ = display.newImageRect(group, "images/indice/torre.png", 190 , 186 )
		_6_ = display.newImageRect(group, "images/indice/6_santini2.png", 337 , 92 )
		_6i_ = display.newImageRect(group,"images/indice/gelado.png", 51 , 115 )
		_7_ = display.newImageRect(group, "images/indice/7_pasteisbelem2.png", 609 , 114 )
		_7i_ = display.newImageRect(group, "images/indice/pasteisbelem.png", 105 , 108 )
	else
		fundo = display.newImageRect(group, "images/indice/fundo.png", 2048 / 1.4, 1536 / 1.4 )
		indice = display.newImageRect(group, "images/indice/indice.png", 496 / 1.71, 186/1.71)
		tracejado1 = display.newImageRect(group, "images/indice/tracejado.png", 2500 / 1.71, 58 /1.71)
		tracejado2 = display.newImageRect(group, "images/indice/tracejado.png", 2500 / 1.71, 58 /1.71)
		_1_ = display.newImageRect(group, "images/indice/1_avidaportuguesa2.png", 647 / 1.71, 100 /1.71)
		_1i_ = display.newImageRect(group, "images/indice/andorinha.png", 112 / 1.71, 115 /1.71)
		_2_ = display.newImageRect(group, "images/indice/2_quiosque2.png", 390 / 1.71, 106 /1.71)
		_2i_ = display.newImageRect(group, "images/indice/quiosque.png", 102 / 1.71, 123 /1.71)
		_3_ = display.newImageRect(group, "images/indice/3_lisbonlovers2.png", 530 / 1.71, 86/1.71)
		_3i_ = display.newImageRect(group, "images/indice/electrico.png", 135 / 1.71, 59 /1.71)
		_5_ = display.newImageRect(group, "images/indice/5_museus2.png", 306 / 1.71, 100 /1.71)
		_5i_ = display.newImageRect(group, "images/indice/torre.png", 190/1.71 , 186/1.71 )
		_6_ = display.newImageRect(group, "images/indice/6_santini2.png", 337 / 1.71, 92 /1.71)
		_6i_ = display.newImageRect(group,"images/indice/gelado.png", 51 / 1.71, 115 /1.71)
		_7_ = display.newImageRect(group, "images/indice/7_pasteisbelem2.png", 609 / 1.71, 114 /1.71)
		_7i_ = display.newImageRect(group, "images/indice/pasteisbelem.png", 105 / 1.71, 108 /1.71)
	end

	
	fundo.anchorX = 0
	fundo.anchorY = 1
	fundo.y = display.contentHeight


	
	indice.x =  display.contentWidth / 2
	indice.y = -1

	
	tracejado1.y = 180
	tracejado1.anchorX = 0

	
	tracejado2.y = 180
	tracejado2.anchorX = 0
	tracejado2.x = tracejado1.width
	--tracejado2:setFillColor( 0.5 )
	--tracejado2.isVisible = false

	
	_1_.y = display.contentHeight/2 - 200
	_1_.x = 0
	_1_.touch = onSceneTouch
	
	
	_1i_.y = display.contentHeight/2 - 200 + (647 / 1.71)
	_1i_.x = 0
	_1i_.isVisible = false


	
	_2_.y = display.contentHeight/2 - 160
	_2_.x = display.contentWidth

	
	_2i_.y = display.contentHeight/2 - 150 + (372 / 1.71)
	_2i_.x = 0
	_2i_.isVisible = false

	
	_3_.y = display.contentHeight/2 - 70
	_3_.x = display.contentWidth

	
	_3i_.y = display.contentHeight/2 - 60 + (519 / 1.71)
	_3i_.x = 0
	_3i_.isVisible = false

	
	_4_.y = display.contentHeight/2 - 60
	_4_.x = 0

	
	_4i_.y = display.contentHeight/2 - 60 + (393 / 1.71)
	_4i_.x = 0
	_4i_.isVisible = false

    
	_5_.y = display.contentHeight/2 +24
	_5_.x = 0

	
	_5i_.y = display.contentHeight/2 - 60 + (393 / 1.71)
	_5i_.x = 0
	_5i_.isVisible = false

	
	_6_.y = display.contentHeight/2 + 110
	_6_.x = 0

	
	_6i_.y = display.contentHeight/2 - 60 + (393 / 1.71)
	_6i_.x = 0
	_6i_.isVisible = false

	
	_7_.y = display.contentHeight/2 + 175
	_7_.x = display.contentWidth

	
	_7i_.y = display.contentHeight/2 - 60 + (393 / 1.71)
	_7i_.x = 0
	_7i_.isVisible = false

	--auxFunctions:setImage(tracejado)
	imgTimer = Runtime:addEventListener("enterFrame", moveTracejado)

	transition.moveBy( indice, { y = 86, time= 800 } )
	transition.moveBy( _1_, { x = display.contentWidth/2 - 310, time=620 })
	transition.moveBy( _2_, { x = -display.contentWidth/2 + 170 , time=620 })
	transition.moveBy( _3_, { x = -display.contentWidth/2 + 300, time=620 })
	transition.moveBy( _4_, { x = display.contentWidth/2 - 325, time=620 })
	transition.moveBy( _5_, { x = display.contentWidth/2-5, time=620 })
	transition.moveBy( _6_, { x = display.contentWidth/2-310, time=620 })
	transition.moveBy( _7_, { x = -display.contentWidth/2+300, time=620 })
	timer.performWithDelay( 1000, showAndorinha )
	timer.performWithDelay( 1300, showQuiosque )
	timer.performWithDelay( 1600, showElectrico )
	timer.performWithDelay( 1900, showGinginha )
	timer.performWithDelay( 2200, showMuseus )
	timer.performWithDelay( 2500, showSantini )
	timer.performWithDelay( 2800, showPasteisDeBelem )
	-- timer.performWithDelay( 400, listener [, iterations] )
	-- timer.performWithDelay( 400, listener [, iterations] )
	-- timer.performWithDelay( 400, listener [, iterations] )
	-- timer.performWithDelay( 400, listener [, iterations] )
	-- timer.performWithDelay( 400, listener [, iterations] )
	 
	cacilheiro = display.newImageRect(group,    "images/indice/cacilheiro.png", 214/1.65, 140/1.65)
	cruzeiro   = display.newImageRect(group,    "images/indice/cruzeiro.png",   217/1.65, 160/1.65)
	--cruzeiro   = display.newRect( 0,0,  217/1.65, 160/1.65)
	--cruzeiro:setFillColor( 1, 1, 0 )
	cargueiro  = display.newImageRect(group,    "images/indice/cargueiro.png",  298/1.65, 201/1.65)
	

	cargueiro.y  =  display.contentHeight - 70
	cargueiro.x  = 130 
	cacilheiro.y = display.contentHeight - 125
	cacilheiro.x = display.contentWidth - 130
	cruzeiro.y   = display.contentHeight - 100
	cruzeiro.x   = display.contentWidth/2	

    -- foldy1 = cruzeiro.path.y1
    -- foldy2 = cruzeiro.path.y2
    -- foldx3 = cruzeiro.path.x3
    -- foldx4 = cruzeiro.path.x4

    foldShip()

	ship1 = {}
	ship1.image = cargueiro
	ship1.bouncingUp = true
	ship1.angle = 1
	ship1.value = -0.3

	ship2 = {}
	ship2.image = cacilheiro
	ship2.bouncingUp = false
	ship2.angle = -0.2
	ship2.value = 0.2


	ship3 = {}
	ship3.image = cruzeiro
	ship3.bouncingUp = false
	ship3.angle = -0.1
	ship3.value = 0.2
	ship3.direction = RIGHT

	Runtime:addEventListener("enterFrame", bouncingBoat)

	-- fundo = display.newImageRect(group,    "images/indice.png", display.contentWidth, display.contentHeight)
	-- fundo = display.newImageRect(group,    "images/indice.png", display.contentWidth, display.contentHeight)
	-- fundo = display.newImageRect(group,    "images/indice.png", display.contentWidth, display.contentHeight)
	-- fundo = display.newImageRect(group,    "images/indice.png", display.contentWidth, display.contentHeight)
	-- fundo = display.newImageRect(group,    "images/indice.png", display.contentWidth, display.contentHeight)
	-- fundo = display.newImageRect(group,    "images/indice.png", display.contentWidth, display.contentHeight)
	-- fundo = display.newImageRect(group,    "images/indice.png", display.contentWidth, display.contentHeight)
	-- fundo = display.newImageRect(group,    "images/indice.png", display.contentWidth, display.contentHeight)
	-- fundo = display.newImageRect(group,    "images/indice.png", display.contentWidth, display.contentHeight)
	-- fundo = display.newImageRect(group,    "images/indice.png", display.contentWidth, display.contentHeight)
	-- fundo = display.newImageRect(group,    "images/indice.png", display.contentWidth, display.contentHeight)
	-- fundo = display.newImageRect(group,    "images/indice.png", display.contentWidth, display.contentHeight)
end

function showAndorinha()
	_1i_.x = _1_.x + _1_.width/2 + 50
	_1i_.y = _1_.y
	_1i_.isVisible = true
end


function showQuiosque()
	_2i_.x = _2_.x + _2_.width/2 + 50
	_2i_.y = _2_.y
	_2i_.isVisible = true
end


function showElectrico()
	_3i_.x = _3_.x + _3_.width/2 + 50
	_3i_.y = _3_.y
	_3i_.isVisible = true
end


function showGinginha()
	_4i_.x = _4_.x + _4_.width/2 + 50
	_4i_.y = _4_.y
	_4i_.isVisible = true
end

function showMuseus()
	_5i_.x = _5_.x + _5_.width/2 + 50
	_5i_.y = _5_.y
	_5i_.isVisible = true
end

function showSantini()
	_4i_.x = _4_.x + _4_.width/2 + 50
	_4i_.y = _4_.y
	_4i_.isVisible = true
end

function showPasteisDeBelem()
	_5i_.x = _5_.x + _5_.width/2 + 50
	_5i_.y = _5_.y
	_5i_.isVisible = true
end

function showSantini()
	_6i_.x = _6_.x + _6_.width/2 + 50
	_6i_.y = _6_.y
	_6i_.isVisible = true
end

function showPasteisDeBelem()
	_7i_.x = _7_.x + _7_.width/2 + 50
	_7i_.y = _7_.y
	_7i_.isVisible = true
end




function bouncingBoat()
	
	if (ship1.bouncingUp) then
    	ship1.angle = ship1.angle + 0.04
    	if (ship1.angle > 3) then
    		ship1.bouncingUp = false
    	end
    else
    	ship1.angle = ship1.angle - 0.04
    	if (ship1.angle < -0.4) then
    		ship1.bouncingUp = true
    	end
    end
    
    if (ship2.bouncingUp) then
    	ship2.angle = ship2.angle + 0.04
    	if (ship2.angle > 3) then
    		ship2.bouncingUp = false
    	end
    else
    	ship2.angle = ship2.angle - 0.04
    	if (ship2.angle < -0.4) then
    		ship2.bouncingUp = true
    	end
    end

    
    -- if (cruzeiro.x > display.contentWidth/2 + 100) then  
     	--foldShip()	
    -- else
    -- 	cruzeiro.x = cruzeiro.x + 0.6
    -- 	transition.to( cruzeiro, { time=0, x = cruzeiro.x, transition=easing.inOutCubic } )    	
    -- end    
    --transition.to( cruzeiro, { time=0, x = cruzeiro.x, transition=easing.inOutCubic } )    	
    
	    
    transition.to( cargueiro, { rotation=ship1.angle, time=0, x = ship1.image.x -ship1.value, transition=easing.inOutCubic } )
    transition.to( cacilheiro,{ rotation=ship2.angle, time=0, x = ship2.image.x -ship2.value, transition=easing.inOutCubic } )
end

function foldShip()
    	
  --   	if (cruzeiro.path.x2 > cruzeiro.path.x4) then
  --   	-- 	foldx3 = foldx3 + 2.5
  --   	-- 	foldx4 = foldx4 + 2.5    	
  --   	-- 	foldy1 = foldy1 + 0.5
  --   	-- 	foldy2 = foldy2 - 0.5    	
  --   	else
  --   	    foldy1 = foldy1 - 10.5
  --   		foldy2 = foldy2 + 10.5 
  --   		foldx3 = foldx3 - (217*2)/1.65
  --   		foldx4 = foldx4 - (217*2)/1.65    	
    		   	
		-- end
  --   	transition.to( cruzeiro.path,  { time=3000, y1=foldy1, y2 =foldy2, x3=foldx3, x4 = foldx4  } )
end


function moveTracejado()

-- 	img1 = display.newImageRect(group,    "images/indice/tracejado.png", 2048 / 1.71, 58 /1.71)
-- 	img1.anchorX = 0
-- 	sw = img1.width + 10
-- 	imgTimer = Runtime:addEventListener("enterFrame", moveImage)
-- end

-- local function moveImage()
	
	--img1 = display.newImageRect(group,    "images/indice/tracejado.png", 2048 / 1.71, 58 /1.71)
	
	--tracejado.y = 180
	--tracejado.anchorX = 0
	
	tracejado1.x = tracejado1.x - 5
	tracejado2.x = tracejado2.x - 5
	


	if (tracejado1.x + tracejado1.width < 0) then
		tracejado1.x = tracejado2.x + tracejado2.width
	end
	if (tracejado2.x + tracejado2.width < 0) then
		tracejado2.x = tracejado1.x + tracejado1.width
	end
	
	--transition.to( img1, { x = sw*-1, time=15000, 
	--	  onComplete = function(self) self.parent:remove(self); self = nil; end })
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	--local screenGroup = self.view
	local group = self.view
	
	print(display.contentWidth, display.contentHeight)
	print("CW and CH", display.contentWidth, display.contentHeight)	
	loadImages(group)
	print( "\nindice: createScene event")
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	print( "indice: enterScene event" )
	
	-- remove previous scene's view
	--storyboard.purgeScene( "scene4" )

	-- Entrar mo jogo
	local nextScene = function()
		_1_:addEventListener( "touch", _1_ )
	end

	timer.performWithDelay( 3000, nextScene, 1 )
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view

	print( "indice: exitScene event" )
	
	-- remove touch listener for image
	_1_:removeEventListener( "touch", _1_ )


	-- removes this scene
	--storyboard.removeScene( "indice" )
	
	-- cancel timer
	--timer.cancel( memTimer ); memTimer = nil;
	
	-- reset label text
	--text2.text = "MemUsage: "
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	print( "((destroying scene INdice view))" )
	--storyboard.removeScene( "indice" )	
end

-- function scene:didExitScene( event )
-- 	print("purging Start")
-- 	storyboard.purgeScene( "indice" )
-- end

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