//
//  LightMotion.swift
//  Nightlight
//
//  Created by Simon Lang on 05.01.23.
//

import SwiftUI

struct LightMotionCopy: View {
    
    // @State instead @StateObject because we don't have to look for change, just need to keep ParticleSystem alive and render it.
    @State private var particleSystem = ParticleSystem(image: Image("spark"), numberOfLightMotions: 7, randomStartHue: true, walkDistance: 0.01, liveTime: 60)
    
    let options: [(flipX: Bool, flipY: Bool)] = [
        (false, false),
        (true, false),
        (false, true),
        (true, true)
    ]
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                particleSystem.update(date: timelineDate)
                
                context.blendMode = .plusLighter
                context.addFilter(.blur(radius: 10))
                                
                for particle in particleSystem.particles {
                    var contextCopy = context
                    contextCopy.addFilter(.colorMultiply(Color(hue: particle.hue, saturation: 1, brightness: 1)))
                    contextCopy.opacity = 1 - (timelineDate - particle.creationDate - 0.5) * 120 / 120
                     
                    
                    for option in options {
                        var xPos = particle.x * size.width
                        var yPos = particle.y * size.height
                        
                        if option.flipX {
                            xPos = size.width - xPos
                        }
                        
                        if option.flipY {
                            yPos = size.height - yPos
                        }
                        contextCopy.draw(particleSystem.image, at: CGPoint(x: xPos, y: yPos))
                    }
                    
                    
                    
                    
                    
                }
            }
        }
        .ignoresSafeArea()
        .background(.black)
    }
}

struct LightMotionCopy_Previews: PreviewProvider {
    static var previews: some View {
        LightMotionCopy()
    }
}
