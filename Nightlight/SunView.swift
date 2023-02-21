//
//  SunView.swift
//  Nightlight
//
//  Created by Simon Lang on 06.01.23.
//

import SwiftUI
import SpriteKit

struct SunView: View {
    var sunActive: Bool
    var sunStrength: Int
    
    
    @State var dragOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
            
            BetterStarMotion()
            
            if sunActive {
                SpriteView(scene: Sun(particleSpeed: sunStrength), options: [.allowsTransparency])
                    .gesture(
                        DragGesture()
                            .onChanged( { value in
                            dragOffset = value.translation
                        }))
    //                .blur(radius: 2)
            }
            
            SpriteView(scene: ShootingStars(), options: [.allowsTransparency])
            
        }
        .ignoresSafeArea()
    }
}

class Sun: SKScene {
    var particleSpeed: Int = 50

    
    init(particleSpeed: Int) {
        self.particleSpeed = particleSpeed
        super.init(size: UIScreen.main.bounds.size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        
        
        // anchor point
        anchorPoint = CGPoint(x: 0.5, y: 0.53)
        
        // background color
        backgroundColor = .clear
        
        // creating a node and adding it to scene
        let node = SKEmitterNode(fileNamed: "Sun.sks")!
        addChild(node)
        
        // this is how we change the parameter values:
        node.particleSpeed = CGFloat(particleSpeed)
        
    }
    
    
}

class ShootingStars: SKScene {

    
    override func sceneDidLoad() {
        
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        
        
        // anchor point
        anchorPoint = CGPoint(x: 0.5, y: 1)
        
        // background color
        backgroundColor = .clear
        
        // creating a node and adding it to scene
        let node = SKEmitterNode(fileNamed: "ShootingStars.sks")!
        addChild(node)
        
        // making it full width
        node.particlePositionRange.dx = UIScreen.main.bounds.width
    }
    
    
}


struct SunView_Previews: PreviewProvider {
    static var previews: some View {
        SunView(sunActive: true, sunStrength: 50)
    }
}
