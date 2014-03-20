--Checklist: main.lua
--(c) 2014 Olivia Chang
--require "CiderDebugger";


display.setStatusBar(display.HiddenStatusBar)
--system.activate( "multitouch" )
local json = require("json")
local composer = require("composer") --so it can go to scenes

local background = display.newRect( display.screenOriginX,
display.screenOriginY, 
display.pixelWidth, 
display.pixelHeight)

background.x, background.y = display.contentCenterX,  display.contentCenterY
background:setFillColor(238/255, 238/255, 238/255)

background:toBack()

globals = require ("globals")

--Find environment - uncomment if needed
-- "simulator" if on simulator
-- "device" if on iOS, Android or Xcode Simulator
--globals.environment = system.getInfo( "environment" )
--print("Environment: " .. globals.environment)

globals.blRows = {}
globals.blRows[1] = "Row name"

--globals.blRows = loadTable("blrows.json")
--if globals.blRows == nil then
--	globals.blRows = {}
--end

composer.gotoScene("basicList")