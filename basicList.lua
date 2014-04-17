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
        local phase = event.phase
 
        if "press" == phase then
            --print( "Touched row:", event.target.index )
            local row = event.target
            print( "Tapped to delete row: " .. row.index )
            globals.basicListTableView:deleteRow( row.index )

            table.remove(globals.blRows,row.index)
        end
        
        --then delete the globals.blRows[row.index] and move all the blRows down one
    end
    
    -- Create the widget
    globals.basicListTableView = widget.newTableView
    {
        left = 0,
        top = 100, --50
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
    
--    local navAddIcon = display.newImage("images/navAddIcon.png")
--    navAddIcon.x, navAddIcon.y = constants.centerX + 125, 23
--    listGroup:insert(navAddIcon)
    
    local function getListName(event)
        if (event.phase == "submitted") then
            local function textWrap( str, limit, indent, indent1 )
                 
                 limit = limit
                 indent = indent
                 indent1 = indent
                 
                 local here = 1 - #indent1
                 return indent1..str:gsub( "(%s+)()(%S+)()",
                 function( sp, st, word, fi )
                     if fi-here > limit then
                         here = st - #indent
                         return "\n"..indent..word
                     end
                 end )
             end
             local rowName = textWrap( event.target.text, 36, "    ", nil )
            if string.len(event.target.text) > 36 then 
                rowHeight = 72
            else 
                rowHeight = 36 
            end
            print ("i am in getListName")
            globals.blRows[#globals.blRows+1] = "     " .. event.target.text    
            print("New row: " .. globals.blRows[#globals.blRows])
            native.setKeyboardFocus( nil )
            -- Insert a row into the tableView
            --globals.basicListTableView:reloadData()

            globals.basicListTableView:insertRow(
            {
                isCategory = false,
                rowHeight = 36,
                rowColor = { default={1,1,1} },
                lineColor = {0.93333333333, 0.93333333333, 0.93333333333}
            }
            )
            print ("test test" .. #globals.blRows)

            --globals.basicListTableView:deleteRow( #globals.blRows - 1 )
            if #globals.blRows > 4 then

                globals.basicListTableView:scrollToIndex(#globals.blRows - 4, 700)
            else
                globals.basicListTableView:scrollToIndex(#globals.blRows, 700)
            end
            event.target.text = '' --clear textfield
        end
    end
    --Create text field
        local taskNameField = native.newTextField( 160, 75, 320, 53) --centerX, centerY, width, height
        taskNameField.placeholder = "Tap to add an item into " .. listName
        -- if touched, go to getListName
        taskNameField:addEventListener("userInput",getListName)
    
    --Fix scope!
    function openSideMenu( )
        transition.to(listGroup, {time = 300, x = constants.centerX + 100 })
        transition.to(taskNameField, {time = 300, x = 420})
        -- Need this so that we don't immediately call the next event listener
        timer.performWithDelay(1,addCloseEventWithDelay)
        print("Side Menu Opened.")
    end
    
    function closeSideMenu()
        transition.to(listGroup, {time = 300, x = 0 })
        transition.to(taskNameField, {time = 300, x = 160})
        print("Side Menu Closed.")
        timer.performWithDelay(1,addOpenEventWithDelay)
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
        native.setKeyboardFocus( nil )
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