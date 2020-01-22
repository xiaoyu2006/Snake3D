//
//  Snake3D.swift
//  Snake3D
//
//  Created by Nemo on 2020/1/20.
//  Copyright © 2020 Nemo. All rights reserved.
//


// Main game logic here!

// https://en.wikipedia.org/wiki/Snake_(video_game_genre)


import Foundation


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

// Operators
func +(first: Vector3DInt, second: Vector3DInt) -> Vector3DInt {
    return Vector3DInt(
        x: first.x + second.x,
        y: first.y + second.y,
        z: first.z + second.z
    )
}

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
class Snake: NSObject {
    private var segments: [SnakeSeg]
    
    var lenx: Int
    var leny: Int
    var lenz: Int
    
    var score: Int = 0
    
    var heading: Direction3D = .right
    
    init(stagex: Int, stagey: Int, stagez: Int) {
        self.lenx = stagex
        self.leny = stagey
        self.lenz = stagez
        self.segments = [
            SnakeSeg(dir: .right, pos: Vector3DInt(x: 0, y: 0, z: 0))
        ]
        self.score = 0
        heading = .right
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
    
    func update(gotApple: Bool = false) -> (append: SnakeSeg, deleted: SnakeSeg?)? {
        guard let next = self.step() else {
            return nil
        }
        let append: SnakeSeg = next
        var deleted: SnakeSeg?
        if !gotApple {
            deleted = self.segments.last
            self.segments.removeLast()
        }
        self.segments.insert(append, at: 0)
        return (
            append: append,
            deleted: deleted
        )
    }
    
    func getSnake() -> [SnakeSeg] {
        return self.segments
    }
}
