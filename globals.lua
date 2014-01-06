--globals.lua
module("globals", package.seeall)
local globals = {}

globals.color = function(r,g,b) return (r/255), (g/255), (b/255); end

return globals