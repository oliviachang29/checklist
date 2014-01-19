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

globals.color = function(r,g,b) return (r/255), (g/255), (b/255); end

globals.listTitle = "List"

globals.tableView = widget.newTableView
globals.basicListTableView = widget.newTableView

-- TESTING: Can we load the listItems2 table from a json file?
globals.listItems2 = loadTable("listitems.json")


return globals