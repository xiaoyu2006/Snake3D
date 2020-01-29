//
//  Snake3D.swift
//  Snake3D
//
//  Created by Nemo on 2020/1/20.
//  Copyright © 2020 Nemo. All rights reserved.
//


// Main game logic here!

// https://en.wikipedia.org/wiki/Snake_(video_game_genre)

import SceneKit

// MARK: - Vector3DInt
struct Vector3DInt {
    var x: Int
    var y: Int
    var z: Int
    
    init(x: Int, y: Int, z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    func toString() -> String {
        return "(\(self.x),\(self.y),\(self.z))"
    }
    
    func toSCNVector3() -> SCNVector3 {
        return SCNVector3(
            CGFloat(self.x), CGFloat(self.y), CGFloat(self.z)
        )
    }
    
    static func +(first: Vector3DInt, second: Vector3DInt) -> Vector3DInt {
        return Vector3DInt(x: first.x + second.x, y: first.y + second.y, z: first.z + second.z)
    }
    
    static func -(first: Vector3DInt, second: Vector3DInt) -> Vector3DInt {
        return Vector3DInt(x: first.x - second.x, y: first.y - second.y, z: first.z - second.z)
    }
    
    static func *(first: Vector3DInt, second: Vector3DInt) -> Vector3DInt {
        return Vector3DInt(x: first.x * second.x, y: first.y * second.y, z: first.z * second.z)
    }
}

// MARK: - Direction3D
enum Direction3D {
    case up
    case down
    case left
    case right
    case forward
    case backward
}

// Operator+
func +(first: Vector3DInt, second: Direction3D) -> Vector3DInt {
    switch second {
    case .up:
        return first + Vector3DInt(x: 0, y: 1, z: 0)
    case .down:
        return first + Vector3DInt(x: 0, y: -1, z: 0)
    case .left:
        return first + Vector3DInt(x: -1, y: 0, z: 0)
    case .right:
        return first + Vector3DInt(x: 1, y: 0, z: 0)
    case .forward:
        return first + Vector3DInt(x: 0, y: 0, z: -1)
    case .backward:
        return first + Vector3DInt(x: 0, y: 0, z: 1)
    }
}

func ==(first: Vector3DInt, second: Vector3DInt) -> Bool {
    return first.x == second.x && first.y == second.y && first.z == second.z
}

// MARK: - SnakeSegment
struct SnakeSeg {
    var dir: Direction3D
    var pos: Vector3DInt
    
    init(dir: Direction3D, pos: Vector3DInt) {
        self.dir = dir
        self.pos = pos
    }
}

// MARK: - Snake
class Snake {
    private var segments: [SnakeSeg]
    
    var lenx: Int
    var leny: Int
    var lenz: Int
    
    var score: Int = 0
    
    var heading: Direction3D = .right
    
    var apple: Vector3DInt!
    
    private func snakeAt(pos: Vector3DInt) -> Bool {
        for s in self.segments {
            if s.pos == pos {
                return true
            }
        }
        return false
    }
    
    private func genApple() {
        if self.segments.count == self.lenx * self.leny * self.lenz {
            return
        }
        self.apple = Vector3DInt(x: Int.random(in: 0..<self.lenx), y: Int.random(in: 0..<self.leny), z: Int.random(in: 0..<self.lenz))
        while snakeAt(pos: self.apple) {
            self.apple = Vector3DInt(x: Int.random(in: 0..<self.lenx), y: Int.random(in: 0..<self.leny), z: Int.random(in: 0..<self.lenz))
        }
    }
    
    init(stagex: Int, stagey: Int, stagez: Int) {
        self.lenx = stagex
        self.leny = stagey
        self.lenz = stagez
        self.segments = [
            SnakeSeg(dir: .right, pos: Vector3DInt(x: 0, y: 0, z: 0))
        ]
        self.score = 0
        heading = .right
        self.genApple()
    }
    
    func getHead() -> SnakeSeg {
        return self.segments[0]
    }
    
    func setHeading(heading: Direction3D) {
        self.heading = heading
    }
    
    private func isOut(pos: Vector3DInt) -> Bool {
        return (
            pos.x < 0 || pos.y < 0 || pos.z < 0 ||
            pos.x >= self.lenx || pos.y >= self.leny || pos.z >= self.lenz
        )
    }
    
    private func step() -> SnakeSeg? {
        let pos: Vector3DInt = self.getHead().pos
        var next: Vector3DInt = pos + self.heading
        
        // Precheck
        if self.isOut(pos: next) {
            if next.x < 0 {
                next.x = self.lenx - 1
            } else if next.x >= self.lenx {
                next.x = 0
            }
            if next.y < 0 {
                next.y = self.leny - 1
            } else if next.y >= self.leny {
                next.y = 0
            }
            if next.z < 0 {
                next.z = self.lenz - 1
            } else if next.z >= self.lenz {
                next.z  = 0
            }
        }
        
        for s in self.segments {
            if s.pos == next {
                // Remember Nokia. It's always a bug there.
                return nil
            }
        }
        
        return SnakeSeg(dir: heading, pos: next)
    }
    
    func update() -> (append: SnakeSeg, delete: SnakeSeg?)? {
        guard let next = self.step() else {
            return nil
        }
        let append: SnakeSeg = next
        self.segments.insert(append, at: 0)
        var deleted: SnakeSeg?
        let gotApple = (append.pos == self.apple)
        if !gotApple {
            deleted = self.segments.last
            self.segments.removeLast()
        } else {
            self.score += 1
            self.genApple()
        }
        return (
            append: append,
            delete: deleted
        )
    }
    
    func getSnake() -> [SnakeSeg] {
        return self.segments
    }
    
    func getScore() -> Int {
        return self.score
    }
    
    func getApple() -> Vector3DInt {
        return self.apple
    }
}
