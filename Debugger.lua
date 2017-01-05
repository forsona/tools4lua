Debugger = Debugger or {}
--------------------------------

-- @module Debugger

--[[

一个用于cocos2d-x lua quick框架的调试类

]]

--[[--

给节点添加一个边框以显示位置

~~~ lua

Debugger:NodeBorder(layerNode, 1)

~~~

@param node node 节点
@param number 颜色，取值1~7，对应彩虹七色

]]
function Debugger:NodeBorder(node, colorOrder)
    if nil == colorOrder then colorOrder = 1 end
    local colorList = {
        [1] = cc.c4f(1, 0, 0, 1),
        [2] = cc.c4f(1, 0.5, 0, 1),
        [3] = cc.c4f(1, 1, 0, 1),
        [4] = cc.c4f(0, 1, 0, 1),
        [5] = cc.c4f(0, 1, 1, 1),
        [6] = cc.c4f(0, 0, 1, 1),
        [7] = cc.c4f(0.55, 0, 1, 1),
    }
    local draw = cc.DrawNode:create()
    local size = node:getContentSize()
    draw:drawPolygon({
            cc.p(0, 0),
            cc.p(size.width, 0),
            cc.p(size.width, size.height),
            cc.p(0, size.height),
        },
        {
            fillColor = cc.c4f(1,1,1,0),
            borderWidth  = 1,
            borderColor  = colorList[colorOrder]
        })
    node:addChild(draw)
end
