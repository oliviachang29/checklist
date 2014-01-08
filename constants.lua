--Constants
local globals = require("globals")

--make sure to make "constants.whatever = {}"" (into a table) before you make it something else, or it won't work'
--constants
local constants = {}

--constants.blue
constants.blue = {}
constants.blue.r = 0
constants.blue.g = 0.81960784313 -- 209/255
constants.blue.b = 0.8 --204/255

--constants.pink
constants.pink = {}
constants.pink.r = 0.95294117647 --243/255
constants.pink.g =0.48235294117 --123/255
constants.pink.b =0.48235294117 --123/255

--constants
constants.orange = {}
constants.orange.r = 0.94901960784
constants.orange.g = 0.69411764705
constants.orange.b = 0.05490196078

--constants.darkteal
constants.darkteal = {}
constants.darkteal.r = 0
constants.darkteal.g = 0.6
constants.darkteal.b = 0.6

--constants.darkblue
constants.darkblue = {}
constants.darkblue.r = 0
constants.darkblue.g = 0.63529411764
constants.darkblue.b= 0.61960784313

--constants.lineColor
constants.lineColor = {}
constants.lineColor = 0.93333333333
--display places
constants.centerX = {}
constants.centerX = display.contentCenterX
constants.centerY = {}
constants.centerY = display.contentCenterY
constants.leftPadding = {}
constants.leftPadding = 10

constants.defaultIconPlace = {}
constants.defaultIconPlace.x = 15
constants.defaultIconPlace.y = 23
return constants
