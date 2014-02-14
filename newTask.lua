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
    
    local taskNameField = native.newTextField( 160, 100, 240, 50)

    taskNameField:addEventListener("userInput",taskNameField)
    
    group:insert(taskNameField)
    native.setKeyboardFocus( taskNameField )
    local categoryText = display.newText(group, "Category?", 75, 150, "Museo Sans 300", 20)
    categoryText:setFillColor(0,0,0)
    -- Handle press events for the checkbox
    local function onSwitchPress( event )
        local switch = event.target
        print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
    end
    
    -- Create onOffSwitch
    local onOffSwitch = widget.newSwitch
    {
        left = 250,
        top = 130,
        style = "onOff",
        id = "onOffSwitch",
        onPress = onSwitchPress
    }
    group:insert(onOffSwitch)
    
    local function addToList()
        globals.basicListT.numRows = globals.basicListT.numRows + 1
        saveTable(basicListT, "basiclistt.json")
        storyboard.gotoScene( "basicList", {effect = "fromLeft"})
        if globals.basicListT.numRows > 7 then
            globals.basicListTableView:scrollToIndex(globals.basicListT.numRows, 700)
        end
        print("new row added to globals.basicListTableView -" .. globals.basicListT.numRows)
        
    end
    checkIcon:addEventListener("tap", addToList)
    
    

    
    local function getListName(event)
        if  ( event.phase == "editing" ) then
         
             itemName = event.target.text        
             print(itemName)

        elseif ( event.phase == "ended" ) then
    	
             itemName = event.target.text     
             print(itemName)
             native.setKeyboardFocus( nil )
        end
    end
    
    
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
    native.setKeyboardFocus(nil)
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