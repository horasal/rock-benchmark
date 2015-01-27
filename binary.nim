import os, strutils

type
    Node = ref BTNode
    BTNode = object
        left, right: Node
        item: int

proc itemCheck(node: Node) : int =
    if node.left == nil:
        return node.item
    return node.item+node.left.itemCheck-node.right.itemCheck


proc newNode(depth: int, item: int) : Node =
    new(result)
    result.item = item
    if depth == 0:
        return
    result.left = newNode(depth-1, 2*item-1)
    result.right = newNode(depth-1, 2*item)

const mindep = 4
if paramCount() > 0 :
    var depth : int = parseInt(paramStr(1))
    var stretch = depth + 1
    var check = newNode(stretch, 0).itemCheck
    var longlived = newnode(depth, 0)
    var i = mindep
    while i<=depth:
        var iterations = 1 shl (depth-i+mindep)
        var check: int = 0
        for j in 1..iterations:
            check += newNode(i, j).itemCheck
            check += newNode(i,-j).itemCheck
        echo iterations*2,"\ttrees of depth ",i,"\t check: ",check
        i += 2
    echo "long lived tree of depth ",depth,"\t check ",longlived.itemCheck
