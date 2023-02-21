//
//  RainView.swift
//  Nightlight
//
//  Created by Simon Lang on 04.01.23.
//

import SwiftUI
import SpriteKit

struct RainView: View {
    
    @State private var visibility = 0.0

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
                .opacity(0.6)
                
            
            // rainfall view
            SpriteView(scene: RainFall(), options: [.allowsTransparency])
            
            // rainfall landing view
            withAnimation(.easeOut(duration: 4.0)) {
                SpriteView(scene:RainFallLanding()
                , options: [.allowsTransparency])
                .opacity(visibility)
            }
            
        }
        .ignoresSafeArea()
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                visibility = 1.0
            }
        }
        
    }
}



class RainFall: SKScene {
    override func sceneDidLoad() {
        
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        
        
        // anchor point
        anchorPoint = CGPoint(x: 0.5, y: 1)
        
        // background color
        backgroundColor = .clear
        
        // creating a node and adding it to scene
        let node = SKEmitterNode(fileNamed: "RainFall.sks")!
        addChild(node)
        
        // making it full width
        node.particlePositionRange.dx = UIScreen.main.bounds.width
    }
}

class RainFallLanding: SKScene {
    
    override func sceneDidLoad() {
        
            
            size = UIScreen.main.bounds.size
            scaleMode = .resizeFill
            
            
            // anchor point
            
            
            anchorPoint = CGPoint(x: 0.5, y: 0.001)
            
            // background color
            backgroundColor = .clear
            
            // creating a node and adding it to scene
            let node = SKEmitterNode(fileNamed: "RainFallLanding.sks")!
            addChild(node)
            
            // making it full width
            node.particlePositionRange.dx = UIScreen.main.bounds.width
        
        
    }
}


struct RainView_Previews: PreviewProvider {
    static var previews: some View {
        RainView()
    }
}
