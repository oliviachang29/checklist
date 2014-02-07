--globals.lua
module("globals", package.seeall)
local widget = require( "widget" )
local data = require("data")

local globals = {}

-- write some fake data to a table to be loaded into a list
local listItems = {}

for i = 1, 40 do
    
    -- set the list item with index i to a certain title.
    listItems[i] = "My Task from JSON " .. i
end

-- TESTING: Can we save the listItems table as json file?
saveTable(listItems,"listitems.json")


--font
globals.font = 
{
  regular = "Museo Sans 300",
  bold = "Museo Sans 500",
}

--for basiclist
globals.basicListTableView = widget.newTableView

-- TESTING: Can we load the listItems2 table from a json file?
globals.listItems2 = loadTable("listitems.json")

return globals
