--Checklist

display.setStatusBar(display.HiddenStatusBar)

--Require widget
local widget = require( "widget" )

local navBar = display.newRect(0, 0, 640, 80)

local widgetGroup = display.newGroup()

-- The "onRowRender" function may go here (see example under "Inserting Rows", above)
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
            rowText = "Category 1"
        else
            rowText = "Category " .. row.index % 10 + 1
        end
    else
        rowText = "Pancakes " .. row.index
    end
    
    rowTitle = display.newText( row, rowText, 0, 0, nil, 14 )
    
    rowTitle:setFillColor( 0 )

    -- Align the label left and vertically centered
    rowTitle.anchorX = 0
    rowTitle.x = 0
    rowTitle.y = rowHeight * 0.5
end

-- Create the widget
local tableView = widget.newTableView
{
    left = 0,
    top = 40,
    height = 440,
    width = 320,
    noLines = true,
    hideScrollBar = true,
    onRowRender = onRowRender,
    onRowTouch = onRowTouch
}

widgetGroup:insert( tableView )

-- Insert 40 rows
for i = 1, 40 do
    
    -- default is that row isn't a category
    isCategory = false
    rowHeight = 36
    rowColor = { default={ 0.87, 0.7, 0.1, 0.93} }
    
    
    -- Make some rows categories
    if ( i == 1 or i % 11 == 0 ) then
        isCategory = true
        rowHeight = 40
        rowColor = { default={ 0.9, 0.5, 0.56 } }
    end
    
     -- Insert a row into the tableView
    tableView:insertRow(
        {
            noLines = true,
            isCategory = isCategory,
            rowHeight = rowHeight,
            rowColor = rowColor,
            lineColor = lineColor
        }
    )
end