--
-- Abstract: Storyboard Sample
--
-- Version: 1.0
-- 
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2011 Corona Labs Inc. All Rights Reserved.
--
-- Demonstrates use of the Storyboard API (scene events, transitioning, etc.)
--
-- Supports Graphics 2.Storyboard0
------------------------------------------------------------

-- hide device status bar
display.setStatusBar( display.HiddenStatusBar )

-- require controller module
local storyboard = require "storyboard"
local widget = require "widget"

-- load first scene
--storyboard.gotoScene( "scene1", "fade", 200 )

-- LOAD DIRECTLY FOR TEST PUROPOSES
local custom = { effect="fadeIn", level="1" }
--storyboard.gotoScene ( "mainLoop", {params=custom} )
--storyboard.gotoScene ( "start" )
--storyboard.gotoScene ( "endlevel", {params=custom} )
storyboard.gotoScene ( "indice" )
--storyboard.gotoScene ( "scenelevel" )

--
-- Display objects added below will not respond to storyboard transitions
--

-- table to setup tabBar buttons
local tabButtons = 
{
	{ 
		width  = 32,
		height = 32,
		defaultFile = "icon1.png",
		overFile = "icon1-down.png",
		label = "First",
		selected = true,
	},
	{ 
		width  = 32,
		height = 32,
		defaultFile = "icon2.png",
		overFile = "icon2-down.png",
		label = "Second",
	},
}

