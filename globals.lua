--globals.lua
local widget = require( "widget" )
local data = require("data")

local globals = {}
--font
globals.font = 
{
    regular = "Museo Sans 300",
    bold = "Museo Sans 500"
}

globals.listName = "To Do"
globals.listsTV = widget.newTableView --change name to bLTableView
globals.basicListTableView = widget.newTableView
globals.middleText = nil

function globals.textWrap( str, limit, indent, indent1 )
    
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


return globals
