--basicList.lua

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
        
        -- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as 
        local rowHeight = row.contentHeight
        local rowWidth = row.contentWidth
        
        local rowTitle
        local rowText
        
        if (row.isCategory) then
            if row.index == 1 then
                rowText = "CATEGORY 1"
                rowTitle = display.newText(row, rowText, 0, 0, 310, rowHeight, globals.font.regular, 20)
                rowTitle.x = constants.leftPadding
            else
                rowText = "CATEGORY " .. row.index % 10 + 1
                rowTitle = display.newText(row, rowText, 0, 0, 310, rowHeight, globals.font.regular, 20) 
                rowTitle.x = constants.leftPadding
            end
        else
            rowTitle = display.newText(row, globals.blRows[row.index], 0,0, 310, rowHeight, globals.font.regular, 20, left)
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
        print( "Tapped to rename row: " .. row.index )
        if row.index > 3 then
            globals.basicListTableView:deleteRow( row.index )
            table.remove(globals.blRows, row.index)
            saveTable(globals.blRows, "blRows.json")
        end
    end
    -- Create the widget
    globals.basicListTableView = widget.newTableView
    {
        left = 0,
        top = 125, --50
        height = 440,
        width = 320,
        hideScrollBar = true,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch
    }
    listGroup:insert(globals.basicListTableView)
    
    -- Insert globals.basicListT.numRows rows
    for i = 1, #globals.blRows do
        
        -- default is that row isn't a category
        --these are the white rows
        isCategory = false
        rowHeight = 36
        rowColor = { default={1,1,1} }
        
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
    local navBar = display.newRect(320, 20, 640, 100)
    navBar:setFillColor(constants.darkteal.r, constants.darkteal.g, constants.darkteal.b)
    listGroup:insert(navBar)
    
    local toSideMenuIcon = display.newImage("images/toSideMenuIcon.png")
    toSideMenuIcon.x, toSideMenuIcon.y =constants.defaultIconPlace.x, constants.defaultIconPlace.y
    listGroup:insert(toSideMenuIcon)
    
    globals.middleText = display.newText(listGroup, globals.listName, constants.centerX, 43, globals.font.regular, 20) -- middleText is the name of the list  
    globals.middleText:setFillColor(0,0,0) 
    
    local function getListName(event)
        if (event.phase == "submitted") then
            local rowName = globals.textWrap(event.target.text, 40, "  ", nil)
            if string.len(event.target.text) > 28 then rowHeight = 64 else rowHeight = 36 end
            globals.blRows[#globals.blRows+1] = rowName
            native.setKeyboardFocus( event.target )
            print ("User added row #" .. #globals.blRows .. globals.blRows[#globals.blRows])
            -- Insert a row into the tableView
            globals.basicListTableView:insertRow(
            {
                isCategory = false,
                rowHeight = rowHeight,
                rowColor = { default={1,1,1} },
                lineColor = {0.93333333333, 0.93333333333, 0.93333333333}
            }
            )
            if #globals.blRows > 5 then
                globals.basicListTableView:scrollToIndex(#globals.blRows - 4, 700)
            end
            event.target.text = '' --clear textfield
            saveTable(globals.blRows, "blRows.json")
        end
    end
    --Create text field
    globals.taskNameField = native.newTextField( 160, 97, 322, 55) --centerX, centerY, width, height
    globals.taskNameField.placeholder = "Tap to add an item in To Do"
    --if touched, go to getListName
    globals.taskNameField:addEventListener("userInput",getListName)
    
    local icon = display.newImage("Icon.png")
    icon.x, icon.y = 130, constants.centerY
    icon:toBack()
    function openSideMenu( )
        timer.performWithDelay(300,icon:toFront())
        transition.to(listGroup, {time = 300, x = constants.centerX + 100 })
        transition.to(globals.taskNameField, {time = 300, x = 421})
        timer.performWithDelay(1,addCloseEventWithDelay)
        print("Side Menu Opened.")
        
    end
    
    function closeSideMenu()
        transition.to(listGroup, {time = 300, x = 0 })
        transition.to(globals.taskNameField, {time = 300, x = 160})
        print("Side Menu Closed.")
        timer.performWithDelay(1,addOpenEventWithDelay)
        icon:toBack()
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
        globals.taskNameField:toBack()
        
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