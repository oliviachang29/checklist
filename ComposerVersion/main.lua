--Checklist: main.lua
--(c) 2014 Olivia Chang

display.setStatusBar(display.HiddenStatusBar)
--system.activate( "multitouch" )

local composer = require("composer") --so it can go to scenes

local background = display.newRect( display.screenOriginX,
                            display.screenOriginY, 
                            display.pixelWidth, 
                            display.pixelHeight)
 
background.x, background.y = display.contentCenterX,  display.contentCenterY
background:setFillColor(238/255, 238/255, 238/255)
 
background:toBack()

composer.gotoScene( "basicList")