--basicList.lua
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
    --Create navigation things
    local navBar = display.newRect(0, 0, 640, 100)
    navBar:setFillColor(constants.darkteal.r, constants.darkteal.g, constants.darkteal.b)
    group:insert(navBar)
    
    local navArrowIcon = display.newImage("images/navArrowIcon.png")
    navArrowIcon.x, navArrowIcon.y =15, 23
    navArrowIcon:scale(0.1, 0.1)
    group:insert(navArrowIcon)
    --    
    --    local function onNavArrowTap()
    --        storyboard.gotoScene("lists", {effect = "fromLeft"})
    --    end
    --    navArrowIcon:addEventListener("tap", onNavArrowTouch)
    local navText = display.newText(group, "Lists", 50, 23, "Museo Sans 300", 20) --navText is the hierarchy text "Lists"
    navText:setFillColor(1,1,1)
    
    local listName = "Groceries"
    local listNameText = display.newText(group, listName, constants.centerX, 23, "Museo Sans 300", 20) -- listName Text is the name of the list. Example name is Groceries
    listNameText:setFillColor(0,0,0) 
    
    local function onRowRender( event )
        
        -- Get reference to the row group
        local row = event.row
        
        -- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
        local rowHeight = row.contentHeight
        local rowWidth = row.contentWidth
        
        local rowTitle
        local rowText
        
        if (row.isCategory) then
            if row.index == 1 then
                rowText = "CATEGORY 1"
                rowTitle = display.newText(row, rowText, 0, 0, "Museo Sans 300", 20)
                rowTitle.x = constants.leftPadding
            else
                rowText = "CATEGORY " .. row.index % 10 + 1
                rowTitle = display.newText(row, rowText, 0, 0, "Museo Sans 300", 20) 
                rowTitle.x = constants.leftPadding
            end
        else
            rowText = "Task " .. row.index
            rowTitle = display.newText(row, rowText, 0,0, "Museo Sans 300", 20)
            rowTitle:setFillColor(0,0,0)
            rowTitle.x = constants.leftPadding
        end
        
        
        -- Align the label left and vertically centered
        rowTitle.anchorX = 0
        rowTitle.x = 0
        rowTitle.y = rowHeight * 0.5
    end
    
    -- Create the widget
    local tableView = widget.newTableView
    {
        left = 0,
        top = 50,
        height = 440,
        width = 320,
        hideScrollBar = true,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch
    }
    
    group:insert( tableView )
    
    -- Insert 40 rows
    for i = 1, 40 do
        
        -- default is that row isn't a category
        --these are the white rows
        isCategory = false
        rowHeight = 36
        rowColor = { default={1,1,1} }
        
        -- Make some rows categories
        --these are the dark blues
        if ( i == 1 or i % 11 == 0 ) then
            isCategory = true
            rowHeight = 50
            rowColor = { default={constants.darkblue.r, constants.darkblue.g, constants.darkblue.b} }
        end
        
        -- Insert a row into the tableView
        tableView:insertRow(
        {
            isCategory = isCategory,
            rowHeight = rowHeight,
            rowColor = rowColor,
            lineColor = {0.93333333333, 0.93333333333, 0.93333333333}
        }
        )
    end
    local function onTap( event )
        storyboard.gotoScene( "lists", {effect = "fromLeft"})
    end
    navArrowIcon:addEventListener( "tap", onTap )
end

-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
    local group = self.view
    
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
    
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


