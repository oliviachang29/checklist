--lists.lua
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

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view
    --Navigation
    local navBar = display.newRect(0, 0, 640, 100)
    navBar:setFillColor(constants.darkteal.r, constants.darkteal.g, constants.darkteal.b)
    group:insert(navBar)
    
    local toSideMenuIcon = display.newImage("images/toSideMenuIcon.png")
    toSideMenuIcon.x, toSideMenuIcon.y = 20, constants.defaultIconPlace.y
    toSideMenuIcon:scale(0.09, 0.09)
    
    local navText = display.newText(group, "Menu", 65, 23, "Museo Sans 300", 20) --navText is the menu text "Menu"
    navText:setFillColor(1,1,1)
    local listNameText = display.newText(group, "Lists", constants.centerX, 23, "Museo Sans 300", 20) --listNameText is the title text Menu
    listNameText:setFillColor(0,0,0)
    
    --Segmented Control
    -- Listen for segmented control events      
    local function onSegmentPress( event )
        local target = event.target
        if target.segmentNumber == 1 then
            rowText = "Basic List"
        else if target.segmentNumber == 2 then
            rowText = "Task List"
        else if target.segmentNumber == 3 then
            rowText = "Grocery List"
        else
            print("rowText not changing on segment press")
        end
        end
        end

        print( "Segment Label is:", target.segmentLabel )
        print( "Segment Number is:", target.segmentNumber )
    end
    
    -- Create a default segmented control
    local segmentedControl = widget.newSegmentedControl
    {
        left = constants.centerX - 125,
        top = 75,
        segmentWidth = 85,
        segments = { "Basic Lists", "Task Lists", "Grocery Lists"},
        defaultSegment = 2,
        onPress = onSegmentPress
    }
    
    --LIST (with no categories)
    local function onRowRender( event )
        
        -- Get reference to the row group
        local row = event.row
        
        -- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
        local rowHeight = row.contentHeight
        local rowWidth = row.contentWidth
        
        local rowTitle = display.newText( row, rowText  .. row.index, 0, 0, "Museo Sans 300", 20 ) --"List"" will be "rowText"
        rowTitle:setFillColor( 0 )
        
        -- Align the label left and vertically centered
        rowTitle.anchorX = 0
        rowTitle.x = 0
        rowTitle.y = rowHeight * 0.5
    end
    
    -- Create the widget
    local tableView = widget.newTableView
    {
        left = 1,
        top = 125,
        height = 440,
        width = 320,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch,
        listener = scrollListener
    }
    
    -- Insert 40 rows
    for i = 1, 2 do
        -- Insert a row into the tableView
          -- Insert a row into the tableView
        tableView:insertRow(
        {
            isCategory = false,
            rowHeight = 36,
            rowColor = { default={1,1,1} },
            lineColor = {0.93333333333, 0.93333333333, 0.93333333333}
        }
        )
    end
end

-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
    local group = self.view
    
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
--    if listNameText != nil then
--        print "listNameText is not nil"
--    end
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view
    
end

-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
    local group = self.view
    
end

-- Called prior to the removal of scene's "view" (display view)
function scene:destroyScene( event )
    local group = self.view
    
end

-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
    local group = self.view
    local overlay_name = event.sceneName  -- name of the overlay scene
    
end

-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
    local group = self.view
    local overlay_name = event.sceneName  -- name of the overlay scene
    
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )

-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )

---------------------------------------------------------------------------------

return scene


