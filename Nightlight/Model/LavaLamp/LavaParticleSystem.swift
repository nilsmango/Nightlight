//
//  LightParticleSystem.swift
//  Nightlight
//
//  Created by Simon Lang on 05.01.23.
//

import SwiftUI
// working with fractions of speed. if if offset x -0.5 then go left and right -0.5...0.5 y, then go up again until x 0.5
// places are offsets. -0.5...0.5
// speed is the speed of offset change etc.

class LavaParticleSystem {

    var particles = [LavaClump]()
   
    // how many lights should be made
    let numberOfClumps: Int
    
    let edge = 1.0
    
    // how far they might move
    var walkDistance: Double = 0.01
    
    // keeps track of each motion light + hue
    var places = [UnitPoint]()
    var speeds = [UnitPoint]()
    var sizes = [UnitPoint]()
    
    init(particles: [LavaClump] = [LavaClump](), numberOfClumps: Int, walkDistance: Double, places: [UnitPoint] = [UnitPoint](), speeds: [UnitPoint] = [UnitPoint](), sizes: [UnitPoint] = [UnitPoint]()) {
        
        self.particles = Array(repeating: LavaClump(offsetX: 1.0, offsetY: CGFloat.random(in: -edge ... -edge), speedX: 0.1, speedY: 0, sizeX: 0.1, sizeY: 0.1), count: numberOfClumps).map( { LavaClump(offsetX: $0.offsetX * CGFloat.random(in: -1.0...1.0), offsetY: -1.0, speedX: 0.1, speedY: 0, sizeX: 0.1, sizeY: 0.1) } )
        
        self.numberOfClumps = numberOfClumps
        self.walkDistance = walkDistance
        
        // start at the bottom
        self.places = Array(repeating: UnitPoint(x: edge, y: edge), count: numberOfClumps).map( { UnitPoint(x: $0.x * Double.random(in: -edge...edge), y: edge)  } )
        
        
        self.speeds = Array(repeating: UnitPoint(x: 1.0, y: 0.0), count: numberOfClumps).map( { UnitPoint(x: $0.x * Double.random(in: -0.1...0.1), y: 0.0)  } )
        
        
        self.sizes = Array(repeating: UnitPoint(x: 0.05, y: 0.05), count: numberOfClumps).map( {
            let random = Double.random(in: 0.6...1.7)
            return UnitPoint(x: $0.x * random, y: $0.x * random) } )
        
        
        
        }
        
    
    
    
    
    
    func insertAndMoveParticles() {
        for (i, place) in places.enumerated() {
            
            let particle = LavaClump(offsetX: place.x, offsetY: place.y, speedX: speeds[i].x, speedY: speeds[i].y, sizeX: sizes[i].x, sizeY: sizes[i].y)
            
            particles[i] = particle
            
           
            // make translate speed into offset and see what happens to the speed
            
            var updatedPlace = UnitPoint()
            updatedPlace.x = place.x + (speeds[i].x / 10)
            updatedPlace.y = place.y + (speeds[i].y / 10)
            
            
            
            // check if updated place + size is at edges
            var edgesOfPlace = UnitPoint()
            
            // let's just go with the point.
            edgesOfPlace = updatedPlace
            
            // ball to ball forces
            if edgesOfPlace.y <= (edge * 0.75) && edgesOfPlace.y >= -(edge * 0.6) {

                let xRange = (edgesOfPlace.x - 0.52)...(edgesOfPlace.x + 0.52)
                let yRange = (edgesOfPlace.y - 0.19)...(edgesOfPlace.y + 0.19)
                
                var filteredList = places.filter( { xRange.contains($0.x) && yRange.contains($0.y) } )
                
                if filteredList.count > 1 {
                    
                    filteredList.removeAll(where: { $0 == place })
                    
                    let random = Int.random(in: 0...104)
                    
                    if random > 76 {
                        
                        
                        if let closePlace = filteredList.first {
                            if let matchIndex = places.firstIndex(of: closePlace) {
                                // IDEA: only do all of this if they are actually really touching
                                
                                // I have no idea why we use those
                                var yFactor = 60.0
                                var xFactor = 50.0
                                
                                
                                
                                // sizes play
                                if sizes[i].x - sizes[matchIndex].x <= -0.02 {
                                    yFactor *= 0.6
                                    xFactor *= 0.6
                                 
                                } else if sizes[i].x - sizes[matchIndex].x <= -0.006 {
                                    yFactor *= 0.9
                                    xFactor *= 0.9
                                   
                                }
                                
                                // Just for y first
                                // wenn beide gleiche richtung ( beide speed positiv oder beide negativ ) -> beide zur durchschnittsgeschwindigkeit 10 proz mehr / weniger als mittelwert beschleunigen
                                // wenn beide unterschiedlich -> speed zusammenrechnen, beide den speed
                                
                                // places angleichen
                                // Idea: only do all of this if they are actually touching
                                
                                if sizes[i].x - sizes[matchIndex].x <= 0.009 {
                                    let averagePlaceY = (updatedPlace.y * yFactor + places[matchIndex].y) / (yFactor + 1)
                                    let averagePlaceX = (updatedPlace.x * xFactor + places[matchIndex].x) / (xFactor + 1)
                                    
                                    
                                    updatedPlace = UnitPoint(x: averagePlaceX, y: averagePlaceY)
                                    
                                }
                                
                               
                                
                                // same direction
                                if ( speeds[matchIndex].y >= 0 && speeds[i].y >= 0 ) || ( speeds[matchIndex].y < 0 && speeds[i].y < 0 ) {
                                    let averageSpeed = ( speeds[matchIndex].y + speeds[i].y * 2 )  / 3
                                    
                                    
                                        
                                    if sizes[i].x - sizes[matchIndex].x >= 0.02 {
                                        speeds[i].y = ( speeds[i].y * 4 + averageSpeed ) / 5
                                        
                                    } else if sizes[i].x - sizes[matchIndex].x >= 0.006 {
                                            speeds[i].y = ( speeds[i].y * 2 + averageSpeed ) / 3
                                        } else {
                                            speeds[i].y = ( speeds[i].y + averageSpeed * 2 ) / 3
                                        }
                                    
                                    // opposite direction
                                } else {
                                    
                                    let newSpeed = ( 2 * speeds[i].y + speeds[matchIndex].y ) / 3
                                    
                                    if speeds[matchIndex].y > 0 {
                                        if sizes[i].x - sizes[matchIndex].x >= 0.02 {
                                            speeds[i].y = ( (speeds[i].y * 2.0) + newSpeed ) / 3
                                        } else if sizes[i].x - sizes[matchIndex].x >= 0.006 {
                                            speeds[i].y = ( speeds[i].y + newSpeed ) / 2
                                        } else {
                                            speeds[i].y = newSpeed
                                        }
                                    }
                                }
                                
                            }
                            
                            
                        }
                        
                    }
            }
            
                
            }
            
            // lava ball at sides stop / reverse
            if edgesOfPlace.x >= edge || edgesOfPlace.x <= -edge {
                if abs(speeds[i].x) < 0.003 {
                    speeds[i].x = -(speeds[i].x * Double.random(in: 0.4...0.6))
                } else {
                    speeds[i].x = -(speeds[i].x * Double.random(in: 0.4...0.6))
                }
                }
            // lava is in center stop from going sideways too fast.
            if (-(edge/2)...(edge/2)).contains(edgesOfPlace.x) == true {
                
                if abs(speeds[i].x) > 0.0001 {
                    speeds[i].x = speeds[i].x * 0.998
                }
                
            }
            
            
            if edgesOfPlace.y >= edge || edgesOfPlace.y <= -edge {
                speeds[i].y = 0
                if speeds[i].x <= 0.003 && speeds[i].x >= -0.003 {
                    speeds[i].x = Double.random(in: -0.009...0.009)
                }
                
            }
            
            // lava going back down sometimes
            if edgesOfPlace.y <= (edge * 0.9) && edgesOfPlace.y > -0.5  {
                let chance = Int.random(in: 1...1000)
                if chance > 996 {
                    speeds[i].y = speeds[i].y + Double.random(in: 0.0005...0.0017)
                }
            }
            
            
            
            // if you are at bottom or top there's a chance you go back down or up (but sideways speed is gone
            let chance = Int.random(in: 1...100000)
            if chance > 99991 {
                
            
            
                // if lava is on floor
                // lava is in center
                if (-(edge/2.2)...(edge/2.2)).contains(edgesOfPlace.x) == true {
                    
                    if edgesOfPlace.y >= edge {
                        speeds[i].y = -(Double.random(in: 0.008...0.018))
                        // less sideways drift
                        speeds[i].x = speeds[i].x * 0.95
                        
                    }
                    
                    
                    
                } else {
                    // trying to get the lave into center
                    if edgesOfPlace.x > edge/2.5 {
                        speeds[i].x = speeds[i].x - Double.random(in: 0.003...0.004)
                    }
                    if edgesOfPlace.x < edge/2.5 {
                        speeds[i].x = speeds[i].x + Double.random(in: 0.003...0.004)
                    }
                    
                    
                    // lava going up from sides
                    if chance > 99999 {
                        if edgesOfPlace.y >= edge {
                            speeds[i].y = -(Double.random(in: 0.003...0.006))
                            speeds[i].x = speeds[i].x * 0.4
                        }
                    }
                }
                
            } else if chance < 142 {
                // lava is up top
                if edgesOfPlace.y <= -edge  {
                    speeds[i].y = Double.random(in: 0.002...0.0035)
                    speeds[i].x = speeds[i].x + Double.random(in: -0.0003...0.0003)
                }
            }
            
            places[i] = updatedPlace
            
        }
    }
    
    
    
    
    
    func update() {
        
        // taking care of the particles
        insertAndMoveParticles()

        

    }
}
