//
//  LightParticleSystem.swift
//  Nightlight
//
//  Created by Simon Lang on 05.01.23.
//

import SwiftUI

class BetterStarParticleSystem {
    var particles = [Star]()
   
    // how many lights should be made
    let numberOfStars: Int
    
    let edge = 1.0
    
    // how far they might move
    var walkDistance: Double = 0.01
    
    // keeps track of each motion light + hue
    var places = [UnitPoint]()
    var hue = [Double]()
    var sizes = [UnitPoint]()
    
    init(particles: [Star] = [Star](), numberOfStars: Int, walkDistance: Double, places: [UnitPoint] = [UnitPoint](), hue: [Double] = [Double](), sizes: [UnitPoint] = [UnitPoint]()) {
        
        self.particles = Array(repeating: Star(x: edge, y: edge, hue: 1.0, sizeX: 0.1, sizeY: 0.1), count: numberOfStars)
//            .map( { Star(x: $0.x * CGFloat.random(in: 0.0...2 * edge), y: $0.y * CGFloat.random(in: 0.0...edge), hue: 1.0, sizeX: 0.1, sizeY: 0.1) } )
        
        self.numberOfStars = numberOfStars
        self.walkDistance = walkDistance
        self.places = Array(repeating: UnitPoint(x: edge, y: edge), count: numberOfStars).map( { UnitPoint(x: $0.x * CGFloat.random(in: 0.0...2 * edge), y: $0.y * CGFloat.random(in: 0.0...edge)) } )

        self.hue = Array(repeating: 1.0, count: numberOfStars).map( { $0 * Double.random(in: 0.2...1.0) } )
        self.sizes = Array(repeating: UnitPoint(x: 1.0, y: 1.0), count: numberOfStars).map( {
            let random = Double.random(in: 0.3...3.0)
            return UnitPoint(x: $0.x * random, y: $0.x * random) } )
    }
    

    
    func insertAndMoveParticles() {
        
        for (i, place) in places.enumerated() {
            
            let particle = Star(x: place.x , y: place.y, hue: hue[i], sizeX: sizes[i].x, sizeY: sizes[i].y)
            
            particles[i] = particle
            
            
            // a walk to the left.
            var nextPlace = UnitPoint()
            // we use hue as the speed
            // TODO: change this to walkDistance
            nextPlace.x = place.x - walkDistance * particle.hue
            if nextPlace.x < 0 { nextPlace.x += 2 }
            nextPlace.y = place.y
            
            places[i] = nextPlace
            
        }
    }
    

    func update() {
        
        // taking care of the particles
        insertAndMoveParticles()

    }
}
