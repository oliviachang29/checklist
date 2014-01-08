--globals.lua
module("globals", package.seeall)
local widget = require( "widget" )

local globals = {}

globals.color = function(r,g,b) return (r/255), (g/255), (b/255); end

globals.listTitle = "A title"

globals.tableView = widget.newTableView

return globals