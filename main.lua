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
local function createNav()
    local navGroup = display.newGroup()
    local navBar = display.newRect(0, 0, 640, 100)
    navBar:setFillColor(color.darkteal.r, color.darkteal.g, color.darkteal.b)
    navGroup:insert(navBar)
    
    local navArrow = display.newImage("images/navArrow.png")
    navArrow.x, navArrow.y =15, 23
    transition.to(navArrow, {time = 0.00000000000001, xScale = 0.1, yScale = 0.1})
    local navText = display.newText(navGroup, "Lists", 50, 23, "Museo Sans 300", 20) --navText is the hierarchy text "Lists"
    navText:setFillColor(1,1,1)
    
    local listName = "Groceries"
    local listNameText = display.newText(navGroup, listName, centerX, 23, "Museo Sans 300", 20) -- listName Text is the name of the list. In this it is Groceries
    listNameText:setFillColor(0,0,0) 
end

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
            rowTitle = display.newText(row, rowText, 0, 0, "Museo Sans 300", 20)
            rowTitle.x = centerX
        else
            rowText = "CATEGORY " .. row.index % 10 + 1
            rowTitle = display.newText(row, rowText, 0, 0, "Museo Sans 300", 20) 
            rowTitle.x = centerX
        end
    else
        rowText = "Task " .. row.index
        rowTitle = display.newText(row, rowText, 0,0, "Museo Sans 300", 20)
        rowTitle:setFillColor(0,0,0)
        rowTitle.x = centerX
    end
     
     
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
    --these are the white rows
    isCategory = false
    rowHeight = 36
    rowColor = { default={1,1,1} }
    
    
    -- Make some rows categories
    --these are the dark blues
    if ( i == 1 or i % 11 == 0 ) then
        isCategory = true
        rowHeight = 50
        rowColor = { default={color.darkblue.r, color.darkblue.g, color.darkblue.b} }
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

--Blastoff
createNav()
