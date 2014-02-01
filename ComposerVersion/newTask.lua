--newTask.lua
--(c) 2014 Olivia Chang

--Require
local widget = require( "widget" ) --widgets supplied by corona
local globals = require("globals") --globals.lua
local constants = require("constants")
local composer = require("composer")

local scene = composer.newScene()

-- Clear previous scene
composer.removeAll()

-- local forward references should go here --

-- Called when the scene's view does not exist:
function scene:createScene( event )
     local sceneGroup = self.view
        --Create navigation things
    local navBar = display.newRect(0, 0, 640, 100)
    navBar:setFillColor(constants.darkteal.r, constants.darkteal.g, constants.darkteal.b)
    sceneGroup:insert(navBar)
    
    local cancelIcon = display.newImage("images/cancelIcon.png")
    cancelIcon.x, cancelIcon.y =constants.defaultIconPlace.x, constants.defaultIconPlace.y
    cancelIcon:scale(0.1, 0.1)
    sceneGroup:insert(cancelIcon)
    
    local leftText = display.newText(sceneGroup, "Cancel", 65, 23, "Museo Sans 300", 20) --navText is the hierarchy text "Cancel"
    leftText:setFillColor(1,1,1)
    
    local function gotoBasicList()
        composer.gotoScene( "basicList", {effect = "fromLeft"})
    end
    cancelIcon:addEventListener("tap", gotoBasicList)
    leftText:addEventListener("tap", gotoBasicList)
    local middleText = display.newText(sceneGroup, "New Task", constants.centerX + 25, 23, "Museo Sans 300", 20)
    middleText:setFillColor(0,0,0) 
    
    local checkIcon = display.newImage("images/checkIcon.png")
    checkIcon.x, checkIcon.y = constants.centerX + 125, 23
    sceneGroup:insert(checkIcon)
    
    local function addToList()
        composer.gotoScene( "basicList", {effect = "fromLeft"})
        globals.basicListTableView:insertRow(
        {
            isCategory = false,
            rowHeight = 36,
            rowColor = { default={1,1,1} },
            lineColor = {0.93333333333, 0.93333333333, 0.93333333333}
        }
        )
        globals.basicListTableView:reloadData()
        local lastRow = globals.basicListTableView:getNumRows()
        globals.basicListTableView:scrollToIndex( lastRow, 400 )
        print("new row added to globals.basicListTableView -" .. lastRow)
    
    end
    checkIcon:addEventListener("tap", addToList)
end

function scene:show( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
   end
end

function scene:hide( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   end
end

function scene:destroy( event )

   local sceneGroup = self.view

   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene

