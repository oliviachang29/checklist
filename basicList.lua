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

-- local forward references should go here --globals

-- Called when the scene's view does not exist:
function scene:createScene( event )
    
    local group = self.view
    
  
    local listGroup = display.newGroup()
    group:insert(listGroup)
    
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
                rowTitle = display.newText(row, rowText, 0, 0, globals.font.regular, 20)
                rowTitle.x = constants.leftPadding
            else
                rowText = "CATEGORY " .. row.index % 10 + 1
                rowTitle = display.newText(row, rowText, 0, 0, globals.font.regular, 20) 
                rowTitle.x = constants.leftPadding
            end
        else
            rowText = "Task " --globals.listItems2[row.index]
            
            rowTitle = display.newText(row, rowText .. row.index, 0,0, globals.font.regular, 20)
            rowTitle:setFillColor(0,0,0)
            rowTitle.x = constants.leftPadding
        end
        
        -- Align the label left and vertically centered
        rowTitle.anchorX = 0
        rowTitle.x = 0
        rowTitle.y = rowHeight * 0.5
    end
    
    -- Create the widget
    globals.basicListTableView = widget.newTableView
    {
        left = 0,
        top = 50,
        height = 440,
        width = 320,
        hideScrollBar = true,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch
    }
    
    listGroup:insert( globals.basicListTableView )
    
    
    -- Insert globals.basicListT.numRows rows
    for i = 1, globals.basicListT.numRows do
        
        -- default is that row isn't a category
        --these are the white rows
        isCategory = false
        rowHeight = 36
        rowColor = { default={1,1,1} }
        
--        -- Make some rows categories
--        --these are the dark blues
--        if ( i == 1 or i % 11 == 0 ) then
--            isCategory = true
--            rowHeight = 50
--            rowColor = { default={constants.darkblue.r, constants.darkblue.g, constants.darkblue.b} }
--        end
        
        -- Insert a row into the tableView
        globals.basicListTableView:insertRow(
        {
            isCategory = isCategory,
            rowHeight = rowHeight,
            rowColor = rowColor,
            lineColor = {0.93333333333, 0.93333333333, 0.93333333333}
        }
        )
        
    end
    --Create navigation things
    
    local navBar = display.newRect(0, 0, 640, 100)
    navBar:setFillColor(constants.darkteal.r, constants.darkteal.g, constants.darkteal.b)
    listGroup:insert(navBar)
    
    local toSideMenuIcon = display.newImage("images/toSideMenuIcon.png")
    toSideMenuIcon.x, toSideMenuIcon.y =constants.defaultIconPlace.x, constants.defaultIconPlace.y
    listGroup:insert(toSideMenuIcon)
    
    local listName = "To Do"
    local middleText = display.newText(listGroup, listName, constants.centerX, 23, globals.font.regular, 20) -- middleText is the name of the list. It is in the middle
    middleText:setFillColor(0,0,0) 
    
    local navAddIcon = display.newImage("images/navAddIcon.png")
    navAddIcon.x, navAddIcon.y = constants.centerX + 125, 23
    listGroup:insert(navAddIcon)
    

    local function gotoNewTask()
        storyboard.gotoScene("newTask", {effect = "fromRight"})
    end
    navAddIcon:addEventListener("tap", gotoNewTask)
    
      --put the sidebar here, so that it is under the list & nav
    local sideBarGroup = display.newGroup()
    group:insert(sideBarGroup)
    local tasksToDoIcon = display.newImage("images/tasksToDoIcon.png")
    sideBarGroup:insert(tasksToDoIcon)
    tasksToDoIcon.x, tasksToDoIcon.y = constants.centerX - 30, 65

    local tasksToDoText = display.newText(sideBarGroup, "To Do: \n    "..globals.basicListTableView:getNumRows(),constants.centerX - 20, 150, globals.font.regular, 20)
    tasksToDoText:setFillColor(0,0,0)

    sideBarGroup:toBack()
    --    local beginX 
    --    local beginY  
    --    local endX  
    --    local endY 
    --    
    --    local xDistance  
    --    local yDistance  
    --    
    --    function checkSwipeDirection()
    --        
    --        xDistance =  math.abs(endX - beginX) -- math.abs will return the absolute, or non-negative value, of a given value. 
    --        yDistance =  math.abs(endY - beginY)
    --        
    --        if xDistance > yDistance then
    --            if beginX > endX then
    --                print("swipe left")
    --            else
    --                --if swipe right, then pull out side menu
    --                print("swipe right")
    --            end
    --        else 
    --            if beginY > endY then
    --                print("swipe up")
    --            else 
    --                print("swipe down")
    --            end
    --        end
    --        
    --    end
    --    
    --    
    --    function swipe(event)
    --        if event.phase == "began" then
    --            beginX = event.x
    --            beginY = event.y
    --        end
    --        
    --        if event.phase == "ended"  then
    --            endX = event.x
    --            endY = event.y
    --            checkSwipeDirection();
    --        end
    --    end
    --    
    --    Runtime:addEventListener("touch", swipe)
    
    local function gotoSideMenu( )
        local function toFront()
            sideBarGroup:toFront()
        end
        --open sideMenu
        transition.to(listGroup, {time = 300, x = constants.centerX + 100, onComplete = toFront})
        print("Side Menu Opened.")
        
        
        --        local function outOfSideMenu()
        --            transition.to(listGroup, {time = 500, x = 0})
        --            navBar:removeEventListener("tap", outOfSideMenu)
        --            print("Side Menu Closed.")
        --        end
        --        navBar:addEventListener("tap", outOfSideMenu)
    end
    
    toSideMenuIcon:addEventListener("tap", gotoSideMenu)
    
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
