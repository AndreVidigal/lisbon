module(...,package.seeall)

local containerGroup = display.newGroup( )

function createContainer(x, y, width, height)
	
	group:insert(containerGroup)

	container  = display.newRoundedRect( containerGroup, x, y, width, height, 6 )
	--container.strokeWidth = 1
	container:setFillColor( 1.0, 0.9, 0.6, 0.8 )
	container.anchorY = 0
	--container.anchorX = 1
	container.isVisible = false
	--container:setStrokeColor( 0.0, 0.2, 0.5 ) 

	--return container
end

function setPosition(x, y)
	container.x = x
	container.y = y
end

function setWidth(width, height)
	container.width  = width
	container.height = height
end

function setContainersTable(content)
	
	title = content[1].text

	margin_h = 16
	text = display.newText( containerGroup, title, container.x , container.y + margin_h, "Garamond", 24 )
	--text.anchorX = 0.5
	text.align = "center"
	
	--auxFunctions.printFonts()
	margin_h = margin_h + 32
	margin_w = 125
	posx = container.x - container.width/2
	line_height = 30


	for i=2, #content, 1 do
		image = display.newImageRect( containerGroup, content[i].thumb, 100, 100 )
		image.x = posx + margin_w
		image.y = container.y + container.height / 2
		--text = display.newText( content[i].text, container.x + margin_w, container.y + margin_h, container.width - 5, 0, "Garamond", 24 )
		margin_w = margin_w + 130
    	text:setFillColor( 0.1, 0.1, 0.2)
	end

	--setWidth(140, #content * 36)
	container.isVisible = true

end
