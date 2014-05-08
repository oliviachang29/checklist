--Checklist: main.lua
--(c) 2014 Olivia Chang
--require "CiderDebugger";


display.setStatusBar(display.TranslucentStatusBar)
--system.activate( "multitouch" )
local json = require("json")
local composer = require("composer") --so it can go to scenes
system.setTapDelay( 0.5 )

local background = display.newRect( display.screenOriginX,
display.screenOriginY, 
display.pixelWidth, 
display.pixelHeight)

background.x, background.y = display.contentCenterX,  display.contentCenterY
background:setFillColor(238/255, 238/255, 238/255)

background:toBack()

globals = require ("globals")

globals.blRows = loadTable("blRows.json")
globals.blRows = nil
globals.lists = loadTable("lists.json")
if globals.blRows == nil then
    globals.blRows = {}
    globals.lists = {}
    globals.lists[1] = "basicList"
    globals.lists[2] = "basicList"
    globals.lists[3] = "basicList"
    globals.lists[4] = "basicList"
end

composer.gotoScene("lists")