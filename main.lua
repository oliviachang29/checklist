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
background:setFillColor(1, 1, 1) --238/255

background:toBack()

globals = require ("globals")

--globals.blRows = loadTable("blRows.json")
globals.data = loadTable("data.json")
if globals.data == nil then
    globals.data = {}
    globals.data.lists = {}
    globals.data.lists[1] = {}
    globals.data.lists[1]["name"] = "To Do"
    globals.data.lists[1][1] = "Homework"
    globals.data.lists[1][2] = "Piano"
end

composer.gotoScene("lists")