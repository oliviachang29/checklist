--basicList.lua
--(c) 2014 Olivia Chang

--Require
local widget = require( "widget" ) --widgets supplied by corona
local globals = require("globals") --globals.lua
local constants = require("constants")
local composer = require("composer")

local scene = composer.newScene()

-- Clear previous scene
composer.removeAll()

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
    
    
    -- Insert 40 rows
    for i = 1, 40 do
        
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
    
    
--    local function addToList()
--        globals.basicListTableView:insertRow(
--        {
--            isCategory = false,
--            rowHeight = 36,
--            rowColor = { default={1,1,1} },
--            lineColor = {0.93333333333, 0.93333333333, 0.93333333333}
--        }
--        )
--        globals.basicListTableView:reloadData()
--        local lastRow = globals.basicListTableView:getNumRows()
--        globals.basicListTableView:scrollToIndex( lastRow, 400 )
--        print("row ".. lastRow .." added to globals.basicListTableView")
--    end
    local function gotoNewTask()
        composer.gotoScene( "newTask", {effect = "fromRight"})
    end
    navAddIcon:addEventListener("tap", gotoNewTask)
    
      --put the sidebar here, so that it is under the list & nav
    local sideBarGroup = display.newGroup()
    sceneGroup:insert(sideBarGroup)
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

