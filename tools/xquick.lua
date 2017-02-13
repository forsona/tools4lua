---
-- quick框架的一些扩展函数以及自定义函数
--
-- - xquick = require("xquick")
-- - 需要socket模块支持
--
-- @module xquick

require("socket")

------------------------------------------------------------------------------------------------------------------------
--- xquick 模块函数
-- @type xquick
------------------------------------------------------------------------------------------------------------------------
local xquick = {}

--- 为节点画上边框
-- @function nodeBorder
-- @param node 节点
-- @param colorOrder 颜色值，1~7，对应彩虹色，默认红色
-- @return nil
-- @usage xquick:nodeBorder(layerNode, 3)
function xquick:nodeBorder(node, colorOrder)
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

--- 创建一个带背景遮罩的层
-- @function maskLayer
-- @param layerName 层名字
-- return 层
function xquick:maskLayer(layerName)
    return class(layerName, function()
        local maskLayer = display.newColorLayer(cc.c4b(0, 0, 0, 128));
        local mainLayer = display.newLayer()
        mainLayer:addChild(maskLayer)
        return mainLayer
    end)
end

------------------------------------------------------------------------------------------------------------------------
--- cc.Node
-- @section cc.Node
------------------------------------------------------------------------------------------------------------------------
local Node = cc.Node

--- 设置至屏幕中心
-- @function displayCenter
-- @return cc.Node
-- @usage node:displayCenter()
function Node:displayCenter()
    self:align(display.CENTER, display.cx, display.cy)
    return self
end

--- 设置至屏幕上面
-- @function displayTop
-- @param offsetPosition 距离对应方向边缘的像素值，不设置则紧贴
-- @return cc.Node
-- @usage node:displayTop()
function Node:displayTop(offsetPosition)
    if nil == offsetPosition then offsetPosition = 0 end
    self:align(display.CENTER_TOP, display.cx, display.top - offsetPosition)
    return self
end

--- 设置至屏幕下面
-- @function displayBottom
-- @param offsetPosition 距离对应方向边缘的像素值，不设置则紧贴
-- @return cc.Node
-- @usage node:displayBottom()
function Node:displayBottom(offsetPosition)
    if nil == offsetPosition then offsetPosition = 0 end
    self:align(display.CENTER_BOTTOM, display.cx, display.bottom + offsetPosition)
    return self
end

--- 设置至屏幕左边
-- @function displayLeft
-- @param offsetPosition 距离对应方向边缘的像素值，不设置则紧贴
-- @return cc.Node
-- @usage node:displayLeft()
function Node:displayLeft(offsetPosition)
    if nil == offsetPosition then offsetPosition = 0 end
    self:align(display.CENTER_LEFT, display.left + offsetPosition, display.cy)
    return self
end

--- 设置至屏幕右边
-- @function displayRight
-- @param offsetPosition 距离对应方向边缘的像素值，不设置则紧贴
-- @return cc.Node
-- @usage node:displayRight()
function Node:displayRight(offsetPosition)
    if nil == offsetPosition then offsetPosition = 0 end
    self:align(display.CENTER_RIGHT, display.right - offsetPosition, display.cy)
    return self
end

--- 设置至屏幕左上
-- @function displayLeftTop
-- @param offsetPositionX X轴距离对应方向的像素值，不设置则紧贴
-- @param offsetPositionY Y轴距离对应方向的像素值，不设置则紧贴
-- @return cc.Node
-- @usage node:displayLeftTop()
function Node:displayLeftTop(offsetPositionX, offsetPositionY)
    if nil == offsetPositionX then offsetPositionX = 0 end
    if nil == offsetPositionY then offsetPositionY = 0 end
    self:align(display.TOP_LEFT, display.left + offsetPositionX, display.top - offsetPositionY)
    return self
end

--- 同displayLeftTop
-- @function displayTopLeft
-- @param offsetPositionX X轴距离对应方向的像素值，不设置则紧贴
-- @param offsetPositionY Y轴距离对应方向的像素值，不设置则紧贴
-- @return cc.Node
-- @usage node:displayTopLeft()
function Node:displayTopLeft(offsetPositionx, offsetPositionY)
    return self:displayLeftTop(offsetPositionX, offsetPositionY)
end

--- 设置至屏幕右上
-- @function displayRightTop
-- @param offsetPositionX X轴距离对应方向的像素值，不设置则紧贴
-- @param offsetPositionY Y轴距离对应方向的像素值，不设置则紧贴
-- @return cc.Node
-- @usage node:displayRightTop()
function Node:displayRightTop(offsetPositionX, offsetPositionY)
    if nil == offsetPositionX then offsetPositionX = 0 end
    if nil == offsetPositionY then offsetPositionY = 0 end
    self:align(display.TOP_RIGHT, display.right - offsetPositionX, display.top - offsetPositionY)
    return self
end

--- 同displayRightTop
-- @function displayTopRight
-- @param offsetPositionX X轴距离对应方向的像素值，不设置则紧贴
-- @param offsetPositionY Y轴距离对应方向的像素值，不设置则紧贴
-- @return cc.Node
-- @usage node:displayTopRight()
function Node:displayTopRight(offsetPositionX, offsetPositionY)
    return self:displayRightTop(offsetPositionX, offsetPositionY)
end

--- 设置至屏幕左下
-- @function displayLeftBottom
-- @param offsetPositionX X轴距离对应方向的像素值，不设置则紧贴
-- @param offsetPositionY Y轴距离对应方向的像素值，不设置则紧贴
-- @return cc.Node
-- @usage node:displayLeftBottom()
function Node:displayLeftBottom(offsetPositionX, offsetPositionY)
    if nil == offsetPositionX then offsetPositionX = 0 end
    if nil == offsetPositionY then offsetPositionY = 0 end
    self:align(display.BOTTOM_LEFT, display.left + offsetPositionX, display.bottom + offsetPositionY)
    return self
end

--- 同displayLeftBottom
-- @function displayBottomLeft
-- @param offsetPositionX X轴距离对应方向的像素值，不设置则紧贴
-- @param offsetPositionY Y轴距离对应方向的像素值，不设置则紧贴
-- @return cc.Node
-- @usage node:displayBottomLeft()
function Node:displayBottomLeft(offsetPositionX, offsetPositionY)
    return self:displayLeftBottom(offsetPositionX, offsetPositionY)
end

--- 设置至屏幕右下
-- @function displayRightBottom
-- @param offsetPositionX X轴距离对应方向的像素值，不设置则紧贴
-- @param offsetPositionY Y轴距离对应方向的像素值，不设置则紧贴
-- @return cc.Node
-- @usage node:displayRightBottom()
function Node:displayRightBottom(offsetPositionX, offsetPositionY)
    if nil == offsetPositionX then offsetPositionX = 0 end
    if nil == offsetPositionY then offsetPositionY = 0 end
    self:align(display.BOTTOM_RIGHT, display.right - offsetPositionX, display.bottom + offsetPositionY)
    return self
end

--- 同displayRightBottom
-- @function displayBottomRight
-- @param offsetPositionX X轴距离对应方向的像素值，不设置则紧贴
-- @param offsetPositionY Y轴距离对应方向的像素值，不设置则紧贴
-- @return cc.Node
-- @usage node:displayBottomRight()
function Node:displayBottomRight(offsetPositionX, offsetPositionY)
    return self:displayRightBottom(offsetPositionX, offsetPositionY)
end

--- 设置至节点中心
-- @function nodeCenter
-- @param node 父节点
-- @return cc.Node
-- @usage node:nodeCenter(node)
function Node:nodeCenter(node)
    local size = node:getContentSize()
    self:align(display.CENTER, size.width / 2, size.height / 2)
    return self
end

--- 设置至节点上面
-- @function nodeTop
-- @param node 父节点
-- @return cc.Node
-- @usage node:nodeTop(node)
function Node:nodeTop(node)
    local size = node:getContentSize()
    self:align(display.CENTER_TOP, size.width / 2, size.height)
    return self
end

--- 设置至节点下面
-- @function nodeBottom
-- @param node 父节点
-- @return cc.Node
-- @usage node:nodeBottom(node)
function Node:nodeBottom(node)
    local size = node:getContentSize()
    self:align(display.CENTER_BOTTOM, size.width / 2, 0)
    return self
end

--- 设置至节点左边
-- @function nodeLeft
-- @param node 父节点
-- @return cc.Node
-- @usage node:nodeLeft(node)
function Node:nodeLeft(node)
    local size = node:getContentSize()
    self:align(display.CENTER_LEFT, 0, size.height / 2)
    return self
end

--- 设置至节点右边
-- @function nodeRight
-- @param node 父节点
-- @return cc.Node
-- @usage node:nodeRight(node)
function Node:nodeRight(node)
    local size = node:getContentSize()
    self:align(display.CENTER_RIGHT, size.width, size.height / 2)
    return self
end

--- 对node:size函数的扩展
--
-- 和size不同的是，size必须指定宽高，这个可以指定宽或者高
--
-- @function xsize
-- @param newSize 新的节点大小，table
-- @return cc.Node
-- @usage node:xsize({width = 100, height = 200})
-- 对比size
-- node:size(100, 200)
function Node:xsize(newSize)
    local size = self:getContentSize()
    if nil == newSize.width then newSize.width = size.width end
    if nil == newSize.height then newSize.height = size.height end
    self:size(newSize)
    return self
end

--- 普通节点的点击模拟事件
-- @function click
-- @param callback 点击之后的回调
-- @return nil
-- @usage node:click(function print("clicked!") end)
function Node:click(callback)
    self:setTouchEnabled(true)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
        if event.name == 'began' then
            self.beginTime = socket.gettime()
            self.beginPosition = cc.p(event.x, event.y)
            return true
        end
        if event.name == 'ended' then
            if isEventClicked(self.beginTime, socket.gettime(), self.beginPosition, cc.p(event.x, event.y)) then
                callback(event)
            end
        end
    end)
end

-- 根据接触时间和位置判断是否是点击
function isEventClicked(beginTime, endTime, beginPosition, endPosition)
    return math.abs(endTime - beginTime) < 0.5 and cc.pGetDistance(endPosition, beginPosition) < 10
end

return xquick
