--basicList.lua
--(c) 2014 Olivia Chang

--Require
local widget = require( "widget" ) --widgets supplied by corona, not in a file
local globals = require("globals")
local constants = require("constants")
local composer = require("composer")

local scene = composer.newScene()

-- local forward references should go here --globals

-- Called when the scene's view does not exist:
function scene:create( event )
    
    local sceneGroup = self.view
    
  
    local listGroup = display.newGroup()
    sceneGroup:insert(listGroup)
    
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
            rowTitle = display.newText(row, globals.blRows[row.index], 0,0, globals.font.regular, 20)
            rowTitle:setFillColor(0,0,0)
            rowTitle.x = constants.leftPadding
        end
        
        -- Align the label left and vertically centered
        rowTitle.anchorX = 0
        rowTitle.x = 0
        rowTitle.y = rowHeight * 0.5
    end
    
    local function onRowTouch(event)
        local row = event.target
        print( "Tapped to delete row: " .. row.index )
        globals.basicListTableView:deleteRow( row.index )
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
    for i = 1, #globals.blRows do
        
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
    local navBar = display.newRect(320, 0, 640, 100)

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
        composer.gotoScene("newTask", {effect = "fromBottom"})
    end
    navAddIcon:addEventListener("tap", gotoNewTask)

    --Fix scope!
    function openSideMenu( )
        --OPEN--
        --local function toFront()
        --    sideBarGroup:toFront()
        --end

        --local function toBack()
        --    sideBarGroup:toBack()
        --end
        transition.to(listGroup, {time = 300, x = constants.centerX + 100 })
        -- Need this so that we don't immediately call the next event listener
        timer.performWithDelay(2,addCloseEventWithDelay)
        print("Side Menu Opened.")
    end
    
    function closeSideMenu()
        transition.to(listGroup, {time = 300, x = 0 })
        print("Side Menu Closed.")
        timer.performWithDelay(2,addOpenEventWithDelay)
    end
    
    function addCloseEventWithDelay() -- Called First
        toSideMenuIcon:addEventListener("tap",closeSideMenu)
    end
    
    function addOpenEventWithDelay() -- Called Second
        toSideMenuIcon:addEventListener("tap",openSideMenu)
    end
    
    toSideMenuIcon:addEventListener("tap", openSideMenu)
    
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

-- "scene:hide()"
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

-- "scene:destroy()"
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