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
globals.lists = loadTable("lists.json")
if globals.blRows == nil then
    globals.blRows = {}
    globals.blRows[1] = "Homework"
    globals.blRows[2] = "Notes"
    globals.blRows[3] = "Grocery List"
    globals.blRows[4] = "Books to Read"
end
if globals.lists == nil then
    globals.lists = {}
    globals.lists[1] = "Homework"
    globals.lists[2] = "Notes"
    globals.lists[3] = "Grocery List"
    globals.lists[4] = "Books to Read"
end

composer.gotoScene("lists")