module(...,package.seeall)

-- prints the coordinates of mouse click
function myUtil:printPoint(event)
	print(math.floor(event.x), math.floor(event.y))
end

function myUtil:paralax(element_x, element_y)		
	--print("->", display.actualContentWidth, display.actualContentHeight, map.width, map.height, element_x, element_y)

	-- if (element_x < display.actualContentHeight / 2)	then	
	-- 	panX = 0		
	-- else
	-- 	if (element_x > map.width - display.actualContentHeight / 2) then
	-- 		panX = -1 * (map.width - display.actualContentHeight)
	-- 		print("--->-")
	-- 	else
	-- 		px = element_x - display.actualContentHeight / 2
	-- 		if( px < 0) then
	-- 			panX =  px
	-- 		else
	-- 			panX = -1 * px
	-- 		end
	-- 	end
	-- end

	-- if (element_y < display.actualContentWidth / 2) then
	-- 	panY = 0
	-- else
	-- 	if (element_y > map.height  - display.actualContentWidth / 2) then
	-- 		panY = -1 * (map.height - display.actualContentWidth)
	-- 	else
	-- 		py = element_y - (display.actualContentWidth / 2)
	-- 		if( py < 0) then 
	-- 			panY = py
	-- 		else
	-- 			panY = -1 * py	
	-- 		end
	-- 	end
	-- end
	-- print("panning ", panX, panY)

	if (element_x < display.actualContentWidth / 2)	then	
		panX = 0				
	else
		if (element_x > map.width - display.actualContentWidth / 2) then
			panX = -1 * (map.width - display.actualContentWidth)
			--print("--",panX)
		else
			px = element_x - (display.actualContentWidth / 2)
			if( px < 0) then
				panX =-1 *px
			else
				panX = -1 * px
			end
		end
	end

	if (element_y < display.actualContentHeight / 2) then
		panY = 0
	else
		if (element_y > map.height  - display.actualContentHeight / 2) then
			panY = -1 * (map.height - display.actualContentHeight)
		else
			py = element_y - (display.actualContentHeight / 2)
			if( py < 0) then 
				panY = py
			else
				panY = -1 * py	
			end
		end
	end
	
	-- if (element_y < display.actualContentWidth / 2)	then
	-- 	panY = 0		
	-- else
	-- 	if (element_y > map.height - display.actualContentWidth / 2) then
	-- 		panY = -1 * (map.height - display.actualContentWidth)
	-- 		print("--",panY)
	-- 	else
	-- 		py = element_y - (display.actualContentWidth / 2)
	-- 		if( py < 0) then
	-- 			panY = -1 *py
	-- 		else
	-- 			panY = -1 * py
	-- 		end
	-- 	end
	-- end

	-- if (element_x < display.actualContentHeight / 2) then
	-- 	panX = 0
	-- else
	-- 	if (element_x > map.width  - display.actualContentHeight / 2) then
	-- 		panX = -1 * (map.width - display.actualContentHeight)
	-- 	else
	-- 		px = element_x - (display.actualContentHeight / 2)
	-- 		if( px < 0) then
	-- 			panX = px
	-- 		else
	-- 			panX = -1 * px	
	-- 		end
	-- 	end
	-- end

	return panX, panY

end