--globals.lua
module("globals", package.seeall)
local widget = require( "widget" )
local data = require("data")

-- write some fake data to a table to be loaded into a list
local listItems = {}

for i = 1, 40 do
    
    -- set the list item with index i to a certain title.
    listItems[i] = "My Task from JSON " .. i
end

-- TESTING: Can we save the listItems table as json file?
saveTable(listItems,"listitems.json")

local globals = {}

globals.font = 
{
  regular = "Museo Sans 300",
  bold = "Museo Sans 500",
}

globals.basicListTableView = widget.newTableView
globals.listsTableView = widget.newTableView
-- TESTING: Can we load the listItems2 table from a json file?
globals.listItems2 = loadTable("listitems.json")

function globals.createSideBar()
    local sideBackground = display.newRect(0, 0, 550, 1000)
    sideBackground:setFillColor(0.93333333333, 0.93333333333, 0.93333333333)
    sideBackground:toBack()
    
    --to do icon and how many to do - this needs to be in the list
    local toDoIcon = display.newImage("images/toDoIcon.png")
    toDoIcon.x, toDoIcon.y = x, y
    group:insert(toDoIcon)
    
    local toDoText = display.newText(group, rowText, 0, 0, globals.font.regular, 20)
    --list of lists
    --settings
end

return globals
