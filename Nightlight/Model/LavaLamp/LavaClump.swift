//
//  LavaClump.swift
//  Nightlight
//
//  Created by Simon Lang on 07.01.23.
//

import Foundation

struct LavaClump: Hashable {
    // all in fractions of size (of view) 0...1 (offset will be -0.5...+0.5, speed a fraction of that, size a fraction of that)
    let offsetX: Double
    let offsetY: Double
    
    let speedX: Double
    let speedY: Double
    
    let sizeX: Double
    let sizeY: Double
}
