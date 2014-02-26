--globals.lua
module("globals", package.seeall)
local widget = require( "widget" )
local data = require("data")

local globals = {}
--font
globals.font = 
{
  regular = "Museo Sans 300",
  bold = "Museo Sans 500",
}

--for basiclist
globals.basicListTableView = widget.newTableView --change name to bLTableView

return globals
