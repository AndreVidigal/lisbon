module(...,package.seeall)


local commandGo
local commandBrake


--initializes the tram joystick/command 
function initializeCommand()
	commandGo = display.newImageRect( "images/BrakeGo.png", 100, 75)
	commandGo.name = "commandGo"	
	commandGo.x =  display.contentWidth  - 50
	commandGo.y =  display.contentHeight  - 40

	commandBrake = display.newImageRect( "images/BrakeBrake.png", 100, 75)
	commandBrake.name = "commandBrake"	
	commandBrake.x =  display.contentWidth  - 50
	commandBrake.y =  display.contentHeight  - 40

	commandBrake.isVisible = false
	commandGo.isVisible = false

	command_ = display.newRect( display.contentWidth, display.contentHeight, 100, 75)
	command_:setFillColor(0.1, 0.3, 0.5, 0.1)
	command_.name = "COMANDA"
	--command_.isVisible = false
	command_.anchorX = 1
	command_.anchorY = 1		
end

function resetCommand()
	-- START GAME WITH TRAM STOPPED
	command_.stopped = true
	command_.breaked = true
end

function setTram(tram, savedSpeed)
	tram_ = tram	
	savedSpeed_ = savedSpeed
end

function actionCommand(event)
	if command_.breaked then
		--Runtime:addEventListener("enterFrame", moving)		
		--transition.to( command_, { rotation = 15,  time=20} )
		commandGo.isVisible    = false
		commandBrake.isVisible = true
		command_.breaked = false
		command_.stopped = false		
		tram_.speed = savedSpeed_
	else
		--Runtime:removeEventListener("enterFrame", moving)	
		commandGo.isVisible    = true
		commandBrake.isVisible = false
		--transition.to( command_, { rotation = -15,  time=20} )	
		command_.breaked = true
	end  
	-- Next statement avoids propagating Events.
	-- When 
	return true;      
end