
local aspectRatio = display.pixelHeight / display.pixelWidth
print(aspectRatio)

if (display.pixelWidth == 1536) and (display.pixelHeight ==  2048) then

	print("ipad retina")
	application = {   
		content = {
			--width = aspectRatio > 1.5 and 800 or math.ceil( 1200 / aspectRatio ),
	      	--height = aspectRatio < 1.5 and 1200 or math.ceil( 800 * aspectRatio ),
            --width = 900,
            --height = 1200,
            width = 1536,
            height = 2048,
            scale = "zoomEven",
            --fps = 60,
            --antialias = true,
            imageSuffix =
            {
                ["@2x"] = 0.5,
            },
			-- width = 1536,
			-- height = 2048,
			-- width = 320,
			-- height = 480,
			-- scale = "zoomEven",						
	  --     	fps = 30,      
	  --     	imageSuffix = 
   --          {
   --              ["@2x"] = 1.5,
   --              ["@4x"] = 3.0,
   --          },
		},
	}
elseif (display.pixelWidth == 640) and (display.pixelHeight ==  1136) then
	print("iphone 5")
		application = {
   
		content = {      
	      width = 640,
	      height = 1136,	      
	      scale = "zoomEven",	      
	      fps = 30,
		},
	}
else

	print("regular ipad")
	application = {
   
		content = {      
	      width = aspectRatio > 1.5 and 800 or math.ceil( 1200 / aspectRatio ),
	      --width = 900,
	      height = aspectRatio < 1.5 and 1200 or math.ceil( 800 * aspectRatio ),
	      --scale = "zoomEven",
	      scale = "zoomEven", 
	      fps = 30,

	      -- imageSuffix = 
       --      {
       --          ["@2x"] = 1.3,
       --      },
		},
	}
end
