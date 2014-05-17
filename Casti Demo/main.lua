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
if globals.blRows == nil then
    globals.blRows = {}
    globals.blRows[1] = "  Try adding a task."
    globals.blRows[2] = "  Tap to delete a task."
    globals.blRows[3] = "  You can't delete the top three."
end
if globals.lists == nil then
    globals.lists = {}
    globals.lists[1] = "To Do"
end

composer.gotoScene("basicList")