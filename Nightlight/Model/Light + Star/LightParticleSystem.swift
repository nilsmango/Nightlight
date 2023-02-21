//
//  LightParticleSystem.swift
//  Nightlight
//
//  Created by Simon Lang on 05.01.23.
//

import SwiftUI

class ParticleSystem {
    let image: Image
    var particles = Set<Particle>()
   
    // how many lights should be made
    let numberOfLightMotions: Int
    
    let randomStartHue: Bool
    
    
    // how far they might move
    var walkDistance: Double = 0.01
    var liveTime: Int = 10
    
    // keeps track of each motion light + hue
    var places = [UnitPoint]()
    var hue = [Double]()
    
    init(image: Image, particles: Set<Particle> = Set<Particle>(), numberOfLightMotions: Int, randomStartHue: Bool, walkDistance: Double, liveTime: Int, places: [UnitPoint] = [UnitPoint](), hue: [Double] = [Double]()) {
        self.image = image
        self.particles = particles
        self.numberOfLightMotions = numberOfLightMotions
        self.randomStartHue = randomStartHue
        self.walkDistance = walkDistance
        self.liveTime = liveTime
        self.places = Array(repeating: UnitPoint(x: CGFloat.random(in: 0.0...1.0), y: CGFloat.random(in: 0.0...1.0)), count: numberOfLightMotions)
        
        if randomStartHue {
            self.hue = Array(repeating: 1.0, count: numberOfLightMotions).map( { $0 * Double.random(in: 0.0...1.0) } )
        } else {
            self.hue = Array(repeating: 1.0, count: numberOfLightMotions).enumerated().map( { Double($0.offset + 1) / Double(numberOfLightMotions) } )
        }
        
        
    }
    
    
    
    func insertAndMoveParticles() {
        
        for (i, place) in places.enumerated() {
            
            let particle = Particle(x: place.x , y: place.y, hue: hue[i])
            particles.insert(particle)
            
            // adjust hue to new value
            hue[i] += 0.005
            if hue[i] > 1 { hue[i] -= 1 }
            
            // a random walk with random distance, adjust place to new value
            var nextPlace = UnitPoint()
            nextPlace.x = place.x + Double.random(in: -walkDistance...walkDistance)
//            nextPlace.x = place.x + walkDistance * Double(Int.random(in: -1...1))
            if nextPlace.x > 1 { nextPlace.x -= 1 }
            if nextPlace.x < 0 { nextPlace.x += 1 }
            nextPlace.y = place.y + Double.random(in: -walkDistance...walkDistance)
//            nextPlace.y = place.y + walkDistance * Double(Int.random(in: -1...1))
            if nextPlace.y > 1 { nextPlace.y -= 1 }
            if nextPlace.y < 0 { nextPlace.y += 1 }
            
            places[i] = nextPlace
            
        }
    }
    
    
    
    
    
    func update(date: TimeInterval) {
        let deathDate = date - Double(liveTime) / 3
        
        for particle in particles {
            if particle.creationDate < deathDate {
                particles.remove(particle)
            }
        }
        
        // taking care of the particles
        insertAndMoveParticles()
        
        
        
        
        
    }
}
