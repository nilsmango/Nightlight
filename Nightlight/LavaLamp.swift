//
//  LavaLamp.swift
//  Nightlight
//
//  Created by Simon Lang on 05.01.23.
//

import SwiftUI

struct LavaLamp: View {
    // animation
    @State private var dragOffset: CGSize = .zero
    @State private var opacity = 0.0

    @State private var lavaParticleSystem = LavaParticleSystem(numberOfClumps: 61, walkDistance: 0.01)
    
    var body: some View {
        ZStack {
            
            LavaView()
                
        }
        
        .background(.black.opacity(0.6))
        .ignoresSafeArea()
        
    }
    
    
    // lava metaball
    @ViewBuilder
    func LavaView() -> some View {
        GeometryReader { geo in
            
            Rectangle()
                        .fill(.linearGradient(colors: [.orange, .red], startPoint: .bottom, endPoint: .top))
                        .mask {
                            TimelineView(.animation(minimumInterval: 1, paused: false)) { time in
                                
                                Canvas { context, size in
                                    // try to update our position of the clumps
                                    lavaParticleSystem.update()
                                    // filters
                                    context.addFilter(.alphaThreshold(min: 0.5, color: .white))
                                    // blur radius determines the elasticity between the balls
            //                        context.addFilter(.blur(radius: 12))
                                    
                                    // draw the shit
                                    context.drawLayer { ctx in
                                        for (index, _) in lavaParticleSystem.places.enumerated() {
                                            if let resolvedView = context.resolveSymbol(id: index) {
                                                ctx.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                                            }
                                        }
                 
                                    }
                                    
                                    
                                } symbols: {
                                    // make the particle index be the tag!
                                    ForEach(0...(lavaParticleSystem.numberOfClumps - 1), id: \.self) { index in
                                        
                                        // we start in the center
                                        let offset = CGSize(width: lavaParticleSystem.places[index].x * ( geo.size.width * 0.9 / 2 ), height: lavaParticleSystem.places[index].y * ( geo.size.height * 0.9 / 2 ))
                                        
                                        let size = CGSize(width: lavaParticleSystem.sizes[index].x * 10  * ( geo.size.width * 0.9 / 2 ), height: lavaParticleSystem.sizes[index].x * 10  * ( geo.size.width * 0.9 / 2 ))
                                        
                                        LavaRoundedRectangle(offset: offset, size: size)
                                            .tag(index)
                                    }

                                }
                                
                            }
                        }
                        
        }
        
                
            }
        
    
    @ViewBuilder
    func LavaRoundedRectangle(offset: CGSize, size: CGSize) -> some View {
        RoundedRectangle(cornerRadius: 70, style: .continuous)
            .fill(.white)
            .frame(width: size.width, height: size.height)
            .offset(offset)
            .blur(radius: size.width * 0.1)
            .animation(.linear(duration: 1), value: offset)
            
    }
 
}

struct LavaLamp_Previews: PreviewProvider {
    static var previews: some View {
        LavaLamp()
    }
}
