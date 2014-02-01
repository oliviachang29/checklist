--newTask.lua
--(c) 2014 Olivia Chang

--Require
local widget = require( "widget" ) --widgets supplied by corona
local globals = require("globals") --globals.lua
local constants = require("constants")
local storyboard = require("storyboard")

local scene = storyboard.newScene()

-- Clear previous scene
storyboard.removeAll()

-- local forward references should go here --

-- Called when the scene's view does not exist:
function scene:createScene( event )
        local group = self.view
        --Create navigation things
    local navBar = display.newRect(0, 0, 640, 100)
    navBar:setFillColor(constants.darkteal.r, constants.darkteal.g, constants.darkteal.b)
    group:insert(navBar)
    
    local cancelIcon = display.newImage("images/cancelIcon.png")
    cancelIcon.x, cancelIcon.y =constants.defaultIconPlace.x, constants.defaultIconPlace.y
    cancelIcon:scale(0.1, 0.1)
    group:insert(cancelIcon)
    
    local leftText = display.newText(group, "Cancel", 65, 23, "Museo Sans 300", 20) --navText is the hierarchy text "Cancel"
    leftText:setFillColor(1,1,1)
    
    local function gotoBasicList()
        storyboard.gotoScene( "basicList", {effect = "fromLeft"})
    end
    cancelIcon:addEventListener("tap", gotoBasicList)
    leftText:addEventListener("tap", gotoBasicList)
    local middleText = display.newText(group, "New Task", constants.centerX + 25, 23, "Museo Sans 300", 20)
    middleText:setFillColor(0,0,0) 
    
    local checkIcon = display.newImage("images/checkIcon.png")
    checkIcon.x, checkIcon.y = constants.centerX + 125, 23
    group:insert(checkIcon)
    
    --local newTaskTextField = native.newTextField( centerX, 100, 640, 50 )

    local function addToList()
        storyboard.gotoScene( "basicList", {effect = "fromLeft"})
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


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
        local group = self.view

        --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view

        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
        local group = self.view

        --      INSERT code here (e.g. remove listeners, widgets, save state, etc.)

end



---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )


---------------------------------------------------------------------------------

return scene
