//
//  LightMotion.swift
//  Nightlight
//
//  Created by Simon Lang on 05.01.23.
//

import SwiftUI

struct BetterStarMotion: View {
    
    // @State instead @StateObject because we don't have to look for change, just need to keep ParticleSystem alive and render it.
    @State private var starParticleSystem = BetterStarParticleSystem(numberOfStars: 1073, walkDistance: 0.0003)
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                
                starParticleSystem.update()
                
                
                
                // draw the shit
                context.drawLayer { ctx in
                    for (index, star) in starParticleSystem.places.enumerated() {
                        if let resolvedView = context.resolveSymbol(id: index) {
                            let xPos = star.x * size.width
                            let yPos = star.y * size.height
                            
                            ctx.draw(resolvedView, at: CGPoint(x: xPos, y: yPos))
                        }
                    }

                }

            } symbols: {
                // make the particle index be the tag!
                ForEach(0...(starParticleSystem.numberOfStars - 1), id: \.self) { index in
                    
                    
                    let size = CGSize(width: starParticleSystem.sizes[index].x, height: starParticleSystem.sizes[index].y)
                    let hue = starParticleSystem.hue[index]
                    
                    StarDrawing(size: size, hue: hue)
                        .tag(index)
                }
            }
            
            
            
        }
        
        .ignoresSafeArea()
        .background(.black)
    }
    
    @ViewBuilder
    func StarDrawing(size: CGSize, hue: Double) -> some View {
        Circle()
            .fill(.white)
            .opacity(hue + 0.2)
            .frame(width: size.width, height: size.height)
            .blur(radius: size.width * 0.2 * ( hue * 2 ))
    }
    
}

struct BetterStarMotion_Previews: PreviewProvider {
    static var previews: some View {
        BetterStarMotion()
    }
}
