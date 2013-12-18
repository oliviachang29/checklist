--Checklist: main.lua
--(c) 2013 Olivia Chang
display.setStatusBar(display.HiddenStatusBar)

--Require
local widget = require( "widget" ) --widgets supplied by corona
local globalData = require("globalData") --globalData.lua
local color = require("color")

--constants
local centerX = display.contentWidth * .5
local centerY = display.contentHeight * .5
--Create navigation things
local navGroup = display.newGroup()
local navBar = display.newRect(0, 0, 640, 100)
navBar:setFillColor(0, 0.6, 0.6)
navGroup:insert(navBar)
local listName = "Groceries"
local navText = display.newText(navGroup, "Lists", 30, 23, native.systemFont, 20)
navText:setFillColor(1,1,1)
local listNameText = display.newText(navGroup, listName, centerX, 23, native.systemFont, 20)
listNameText:setFillColor(0,0,0) 
local widgetGroup = display.newGroup()

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
            rowText = "CATEGORY 1"
        else
            rowText = "CATEGORY " .. row.index % 10 + 1
        end
    else
        rowText = "Gingerbread " .. row.index
    end
    
--    if (row.isCateogry == true) then
--        rowTitle = display.newText( row, rowText, centerX, 0, "Museo Sans 300", 20 )
--    else
--        rowTitle = display.newText( row, rowText, centerX, 0, native.systemFont, 14 )
--    end
    local rowTitle = display.newText( row, rowText, centerX, 0, "Museo Sans 300", 18 )
    rowTitle:setFillColor(0, 0.6, 0.6)

    -- Align the label left and vertically centered
    rowTitle.anchorX = 0
    rowTitle.x = 0
    rowTitle.y = rowHeight * 0.5
end

-- Create the widget
local tableView = widget.newTableView
{
    left = 0,
    top = 50,
    height = 440,
    width = 320,
    hideScrollBar = true,
    onRowRender = onRowRender,
    onRowTouch = onRowTouch
}

widgetGroup:insert( tableView )

-- Insert 40 rows
for i = 1, 40 do
    
    -- default is that row isn't a category
    --this is the white rows
    isCategory = false
    rowHeight = 36
    rowColor = { default={1,1,1} }
    
    
    -- Make some rows categories
    if ( i == 1 or i % 11 == 0 ) then
        isCategory = true
        rowHeight = 50
        rowColor = { default={ 1,1,1} }
    end
    
     -- Insert a row into the tableView
    tableView:insertRow(
        {
            isCategory = isCategory,
            rowHeight = rowHeight,
            rowColor = rowColor,
            lineColor = lineColor
        }
    )
end