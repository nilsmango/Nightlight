//
//  LightParticle.swift
//  Nightlight
//
//  Created by Simon Lang on 05.01.23.
//

import Foundation

struct Particle: Hashable {
    let x: Double
    let y: Double
    let creationDate = Date.now.timeIntervalSinceReferenceDate
    let hue: Double
}
