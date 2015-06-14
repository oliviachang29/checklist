--Checklist: main.lua
--(c) 2014 Olivia Chang
--require "CiderDebugger";


display.setStatusBar(display.TranslucentStatusBar)
--system.activate( "multitouch" )
local json = require("json")
local composer = require("composer") --so it can go to scenes
system.setTapDelay( 0.5 )


---
local background = display.newRect( display.screenOriginX,
display.screenOriginY, 
display.pixelWidth, 
display.pixelHeight)

background.x, background.y = display.contentCenterX,  display.contentCenterY
background:setFillColor(1,1,1) --238/255

background:toBack()

globals = require ("globals")
globals.lists = loadTable("lists.json")
if globals.lists == nil then
    globals.lists = {}
    globals.lists[1] = "Test"
    globals.lists[2] = "Test"
    globals.lists[3] = "Test"
end

composer.gotoScene("list")