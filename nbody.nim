import math
import os,strutils

const solarMass = 4*PI*PI
const daysPerYear = 365.24

type
    Body = ref object of TObject
        x,y,z,vx,vy,vz,mass : float64
        
proc offsetMomentum(body: Body, px, py, pz: float64) =
    body.vx = -px / solarMass
    body.vy = -py / solarMass
    body.vz = -pz / solarMass

type
    System = ref object of TObject
        bodies: seq[Body]

proc init(s: System) =
    var px = 0'f64
    var py = 0'f64
    var pz = 0'f64
    for i in s.bodies:
        px += i.vx * i.mass
        py += i.vy * i.mass
        pz += i.vz * i.mass
    s.bodies[0].offsetMomentum(px, py, pz)

proc energy(s:System) : float64 =
    var e = 0'f64
    for ind in 0..len(s.bodies)-1:
        var i = s.bodies[ind]
        e += 0.5'f64 * i.mass * (i.vx*i.vx+i.vy*i.vy+i.vz*i.vz)
        for j in ind+1..len(s.bodies)-1:
            let dx = i.x-s.bodies[j].x
            let dy = i.y-s.bodies[j].y
            let dz = i.z-s.bodies[j].z
            let distance = sqrt(dx*dx+dy*dy+dz*dz)
            e -= (i.mass * s.bodies[j].mass) / distance
    result = e

proc advance(s:System, dt: float64) =
    for ind in 0..len(s.bodies)-1:
        var i = s.bodies[ind]
        for j in ind+1..len(s.bodies)-1:
            let dx = i.x-s.bodies[j].x
            let dy = i.y-s.bodies[j].y
            let dz = i.z-s.bodies[j].z
            let distance = sqrt(dx*dx+dy*dy+dz*dz)
            let mag = dt / (distance * distance * distance)

            i.vx -= dx * s.bodies[j].mass * mag
            i.vy -= dy * s.bodies[j].mass * mag
            i.vz -= dz * s.bodies[j].mass * mag

            s.bodies[j].vx += dx * i.mass * mag
            s.bodies[j].vy += dy * i.mass * mag
            s.bodies[j].vz += dz * i.mass * mag

    for i in s.bodies:
        i.x += dt*i.vx
        i.y += dt*i.vy
        i.z += dt*i.vz


var data = System(bodies: @[Body(x:0,y:0,z:0,vx:0,vy:0,vz:0,mass:solarMass),
    Body(x:4.84143144246472090e+00,
    y: -1.16032004402742839e+00,
    z: -1.03622044471123109e-01,
    vx: 1.66007664274403694e-03 * daysPerYear,
    vy: 7.69901118419740425e-03 * daysPerYear,
    vz: -6.90460016972063023e-05 * daysPerYear,
    mass: 9.54791938424326609e-04 * solarMass),
    Body(x: 8.34336671824457987e+00,
    y: 4.12479856412430479e+00,
    z: -4.03523417114321381e-01,
    vx: -2.76742510726862411e-03 * daysPerYear,
    vy: 4.99852801234917238e-03 * daysPerYear,
    vz: 2.30417297573763929e-05 * daysPerYear,
    mass:2.85885980666130812e-04 * solarMass),
    Body(x: 1.28943695621391310e+01,
    y: -1.51111514016986312e+01,
    z: -2.23307578892655734e-01,
    vx: 2.96460137564761618e-03 * daysPerYear,
    vy: 2.37847173959480950e-03 * daysPerYear,
    vz: -2.96589568540237556e-05 * daysPerYear,
    mass: 4.36624404335156298e-05 * solarMass),
    Body(x: 1.53796971148509165e+01,
    y: -2.59193146099879641e+01,
    z: 1.79258772950371181e-01,
    vx: 2.68067772490389322e-03 * daysPerYear,
    vy: 1.62824170038242295e-03 * daysPerYear,
    vz: -9.51592254519715870e-05 * daysPerYear,
    mass: 5.15138902046611451e-05 * solarMass)])


if paramCount() > 0 :
    let steps = parseInt(paramStr(1))
    data.init
    echo formatFloat(data.energy, ffDefault, 9)
    for i in 0..steps-1: data.advance(0.01)
    echo formatFloat(data.energy, ffDefault, 9)
