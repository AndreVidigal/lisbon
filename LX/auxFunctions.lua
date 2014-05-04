module(...,package.seeall)

local bezier = require('bezier')
local json    = require("json")

local stopGlow = false

-- prints the coordinates of mouse click
function printPoint(event)
	print("auxFunctions:printPoint", math.floor(event.x), math.floor(event.y))
end


function auxFunctions:stopShake(image)
	transition.cancel( transShake )
end


function shakeRandom1(e)
	transShake = transition.to(e, { time = 0, delay=500,  rotation = math.random(5, 21) / 10, onComplete = shakeRandom2 } )
end

function shakeRandom2(e)
	transShake = transition.to(e, { time=0,  delay=300, rotation = -1*math.random(2, 19)/10, onComplete = shakeRandom2 } )	
end

function shake1(e)
	transShake = transition.to(e, { time = 0, delay=500,  rotation = 0.7, onComplete = shake2 } )
end

function shake2(e)
	transShake = transition.to(e, { time=0,  delay=300, rotation = -0.8, onComplete = shake1 } )	
end


function auxFunctions:rotateImage(vehicle)
	-- encontrar segmento de recta [AB]
	-- ponto A (previouX, previousY)
	-- ponto B (x, y)
	-- AB = [x-previousX, y-previousY]
	--print("Rotate>", vehicle.name)
	valX = vehicle.image.x - vehicle.previousX
	valY = vehicle.image.y - vehicle.previousY


	if (valX < 0) then		
		vehicle.image.yScale =  1
		vehicle.image.xScale =  1
	else
		vehicle.image.yScale =  1
		vehicle.image.xScale = -1
	end

	if valX == 0 or valY == 0 then
		--return
	end	
	
	angle = math.deg(math.atan2 (valY, valX))
	
	--print(angle, valX, valY)	

	vehicle.previousX = vehicle.image.x
	vehicle.previousY = vehicle.image.y

	 if angle > 90 then
	  	angle = angle -180
	 elseif angle < -90 then
	 	angle = angle + 180
	 end

--	 print("Angle>>", angle)

	transition.to( vehicle.image, { rotation = angle,  time=0} )
end

-- this function rotates the image... but the vehicle has 2 images associated
-- so this is what differes from previous function
function auxFunctions:rotateImage2(vehicle, image)
	-- encontrar segmento de recta [AB]
	-- ponto A (previouX, previousY)
	-- ponto B (x, y)
	-- AB = [x-previousX, y-previousY]
	--print("Rotate>", vehicle.name)
	valX = vehicle.image.x - vehicle.previousX
	valY = vehicle.image.y - vehicle.previousY


	if valX == 0 or valY == 0 then
		return
	end	
	
	angle = math.deg(math.atan2 (valY, valX))
	--print(">", valX, valY, angle)


	vehicle.previousX = vehicle.image.x
	vehicle.previousY = vehicle.image.y

	 -- if (vehicle.angle > 170) then
	 -- 	vehicle.image.yScale = vehicle.image.yScale * (-1)
	 -- end

	transition.to( vehicle.image1, { rotation = angle,  time=0} )
end	


function auxFunctions:stopGlow(image)
	image.alpha = 1.0
	transition.cancel( trans )
end

function auxFunctions:glow(image)
	trans = transition.to(image, { time=500,alpha=0.5, onComplete = function1 } )
end

function function1(e)
  	trans = transition.to(e, { time=500, alpha=1, onComplete=function2 })
end

function function2(e)
  	trans = transition.to(e, {time=500, alpha=0.3, onComplete=function1 })
end

function auxFunctions:stopGlowCircle(image)
	image.alpha = 1.0
	transition.cancel( trans )
end

function auxFunctions:glowCirlce(image)
	trans = transition.to(image, { time=500,alpha=0.5, onComplete = function1 } )
end

function function1_gc(e)
  	trans = transition.to(e, { time=500, alpha=1, onComplete=function2_gc })
end

function function2_gc(e)
  	trans = transition.to(e, {time=500, alpha=0.3, onComplete=function1_gc })
end





-- Loads the File whith map
function auxFunctions:load( filename )
    -- set default base dir if none specified
    local base = system.ResourceDirectory
 
    -- create a file path for corona i/o
    local path = system.pathForFile( filename, base )
 
    -- will hold contents of file
    local contents
 
    -- io.open opens a file at path. returns nil if no file found
    local file = io.open( path, "r" )
    if file then
        -- read all contents of file into a string
        contents = file:read( "*a" )
        io.close( file )    -- close the file after using it
        --return decoded json string
        return json.decode( contents )
    else
        --or return nil if file didn't ex
        return nil
    end
end

function auxFunctions:setImage(img)
	img1 = img
	img1.name = "Troia"
end	

function auxFunctions:moveImage(obj)
	if (obj.x < -100 ) then
   		move_ = 1
   	end
   	if (obj.x > display.contentWidth + 100 ) then
   		move_ = -1
   	end
   	
   	obj.x = obj.x + (move_*2)		

end


function auxFunctions:moveImage()
-- 	img1 = display.newImageRect( "images/indice/tracejado.png", 2048 / 1.71, 58 /1.71)
-- 	img1.anchorX = 0
-- 	sw = img1.width + 10
-- 	imgTimer = Runtime:addEventListener("enterFrame", moveImage)
-- end

-- local function moveImage()
	
	--img1 = display.newImageRect( "images/indice/tracejado.png", 2048 / 1.71, 58 /1.71)
	
	--tracejado.y = 180
	--tracejado.anchorX = 0
	img1.x = img1.x - 1
	img1.y = 180

	restart = display.contentWidth

	if (img1.x < restart) then
		img1.x = display.contentWidth
		
	end
	
	--transition.to( img1, { x = sw*-1, time=15000, 
	--	  onComplete = function(self) self.parent:remove(self); self = nil; end })
end



-- xc - center of the circle (x)
-- yc - center of the circle (y)
-- radius - the radius of the circle
function createCircle(xc, yc, radius)	
	
	a = 0
	circle = display.newLine(-1, -1, -1, -1)
	circle:setStrokeColor(0, 0, 255, 255 )
	--circle.isVisible = false
	circle.isVisible = true
	circle.strokeWidth = 3    

	for i=0, 20 * math.pi, 1 do
		x = xc + radius * math.cos(a)
		y = yc + radius * math.sin(a)
		--print(x, y)
		circle:append(x,y)
		a = a + 0.1
	end

	
end


-- xc - center of the elipse (x)
-- yc - center of the elipse (y)
-- a - the width of the elipse
-- b - the height of the elipse

function auxFunctions:createElipse(xc, yc, a, b)	

	print(xc, yc, a, b)

	elipse = display.newLine(-1, -1, -1, -1)
	elipse:setStrokeColor(0, 0, 255, 255 )
	elipse.isVisible = false
	elipse.strokeWidth = 3    

	ang = 0
	
	-- formula (x,y)=(p+tcosα,q+tsinα)
	--x = h + a cos t
	--y = k + b sin t 
	path = {}

	for i=0, 40 * math.pi, 1 do
		x = xc + a * math.cos(ang)
		y = yc + b * math.sin(ang)	
		elipse:append(x,y)

		point = {}
		point.x = x
		point.y = y
		point.angle = ang

		path[i] = point
      
		--xa, ya = xa+1, ya+1
		ang = ang + 0.05
	end

	return elipse
end

-- creates a bezier line based on x coordinates.
-- a1(x) and a2(y)
function auxFunctions:createBezier(a1, a2)	
	xCoordinates = {}
	yCoordinates = {}

	for i=1, #a1, 1 do
		table.insert(xCoordinates, a1[i])
		table.insert(yCoordinates, a2[i])		
	end
	curve =  bezier:curve(xCoordinates, yCoordinates)
		
	x1, y1 = curve(0.01)

	--line = display.newLine( group, x1, y1, x1+1, y1+1)
	line = display.newLine(  x1, y1, x1+1, y1+1)
	--line = display.newLine(  x1, y1, x1+1, y1+1)
	line:setStrokeColor(0, 0, 255, 255 )
	line.isVisible = false
	line.strokeWidth = 3
	
	-- each line has 100 coordinates	
	for i=0.02, 1.01, 0.01 do
		local x, y = curve(i)		
		line:append(x, y)			
	end

	return curve

	-- curve =  bezier:curve({a1[1], a1[2], a1[3], a1[4], a1[5], a1[6]}, {a2[1], a2[2], a2[3], a2[4], a2[5], a2[6]})
	-- x1, y1 = curve(0.01)
end

function printFonts()
	local g = display.newGroup()
	local fonts = native.getFontNames()
	local count, found_count = 0,0
	for i,fontname in ipairs( fonts ) do
	    count = count+1
	    j, k = string.find( fontname, "Times" )
	    if ( j ~= nil ) then
	        found_count = found_count + 1
	        print( "found font: " .. fontname )
	        --local obj = display.newText( fontname, 40, 40 + (found_count - 1) * 40, fontname, 24 )
	        --obj.anchorX = 0
	        --g:insert( obj )
	    end
	end

	print( "Font count: " .. count )
end

Runtime:addEventListener( "tap", printPoint )


--createCircle(200,200, 50)
--createElipse(300, 800, 90, 55)
--circle.isVisible = true
--elipse.isVisible = true



