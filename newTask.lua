--newTask.lua
--(c) 2014 Olivia Chang

--Require
local widget = require( "widget" ) --widgets supplied by corona
local globals = require("globals") --globals.lua
local constants = require("constants")
local composer = require("composer")

local scene = composer.newScene()


-- local forward references should go here --

-- Called when the scene's view does not exist:
function scene:create( event )
    local sceneGroup = self.view
    
    --NAVIGATION BAR--
    local navBar = display.newRect(0, 0, 640, 100)
    navBar:setFillColor(constants.darkteal.r, constants.darkteal.g, constants.darkteal.b)
    sceneGroup:insert(navBar)
    
    local cancelIcon = display.newImage("images/cancelIcon.png")
    cancelIcon.x, cancelIcon.y =constants.defaultIconPlace.x, constants.defaultIconPlace.y
    cancelIcon:scale(0.1, 0.1)
    sceneGroup:insert(cancelIcon)
    
    local leftText = display.newText(sceneGroup, "Cancel", 65, 23, "Museo Sans 300", 20)
    leftText:setFillColor(1,1,1)
    
    local function gotoBasicList()
        composer.gotoScene( "basicList", {effect = "slideDown"})
    end
    cancelIcon:addEventListener("tap", gotoBasicList)
    leftText:addEventListener("tap", gotoBasicList)
    local middleText = display.newText(sceneGroup, "New Task", constants.centerX + 25, 23, "Museo Sans 300", 20)
    middleText:setFillColor(0,0,0) 
    
    local checkIcon = display.newImage("images/checkIcon.png")
    checkIcon.x, checkIcon.y = constants.centerX + 125, 23
    sceneGroup:insert(checkIcon)
    
    --TEXT FIELD--
    local taskNameField = native.newTextField( 160, 100, 240, 50)
    local listName = "Basic List"
--    taskNameField.placeholder = "Add an item into " .. listName
    native.setKeyboardFocus( taskNameField )
    
    --CATEGORY TEXT
    local categoryText = display.newText(sceneGroup, "Category?", 75, 150, "Museo Sans 300", 20)
    categoryText:setFillColor(0,0,0)
    
    --CATEGORY SWITCh
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
    sceneGroup:insert(onOffSwitch)
    
    local function goToBL()
        print("Going to BL!")
        taskNameField:removeSelf()
        composer.gotoScene( "basicList", {effect = "fromLeft"})
        if #globals.blRows > 7 then
            globals.basicListTableView:scrollToIndex(#globals.blRows, 700)
        end
    end
    
    checkIcon:addEventListener("tap", goToBL)

    local function getListName(event)
        if ( event.phase == "ended" ) or (event.phase == "submitted") then
             globals.blRows[#globals.blRows+1] = event.target.text    
             --saveTable(globals.blRows,"blrows.json") 
             print("New row: " .. globals.blRows[#globals.blRows])
             native.setKeyboardFocus( nil )
        end
    end

    -- taskNameField:addEventListener("userInput",taskNameField)
    taskNameField:addEventListener("userInput",getListName)
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