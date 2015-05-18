import math
import os, strutils

proc eval(i,j : float64) : float64 =
    result = ((i+j)*(i+j+1) / 2 + i + 1)

type
    Vector = ref object of TObject
        content: seq[float64]

proc newVec(len: int) : Vector =
    new(result)
    result.content=newSeq[float64](len)
    for i in 0..len(result.content)-1:
        result.content[i] = 0'f64

proc times(v:Vector, u: Vector) =
    for i in 0..len(v.content)-1:
        v.content[i] = 0
        for j in 0..len(u.content)-1:
            v.content[i] += u.content[j] / eval(float64 i,float64 j)
            
proc timesTrans(v:Vector, u:Vector) =
    for i in 0..len(v.content)-1:
        v.content[i] = 0
        for j in 0..len(u.content)-1:
            v.content[i] += u.content[j] / eval(float64 j,float64 i)

proc AtimesTrans(v,u: Vector) = 
    var x = newVec(len(v.content))
    x.times(u)
    v.timesTrans(x)
    
if paramCount() > 0 :
    let steps = parseInt(paramStr(1))
    var u = newVec(steps)
    for i in 0..len(u.content)-1:
        u.content[i] = 1
    var v = newVec(steps)
    for i in 0..9:
        v.AtimesTrans(u)
        u.AtimesTrans(v)
    var vbv, vv : float64
    for i in 0..steps-1:
        vbv += u.content[i] * v.content[i]
        vv += v.content[i] * v.content[i]
    echo sqrt(vbv/vv)