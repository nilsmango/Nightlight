//
//  NightLight.swift
//  Nightlight
//
//  Created by Simon Lang on 30.12.22.
//

import Foundation
import SwiftUI

struct NightLight {
    var currentLight: Light
    
    var singleLightColor: LightColor
    var singleLightColorHistory: [LightColor]
    
    var colorChangeColors: [LightColor]
    var colorChangeHistory: [[LightColor]]
    var colorChangeSpeed: Int
    var randomColorChange: Bool
    var completeRandom: Bool
    
    
    mutating func updateHistory() {
        if singleLightColorHistory.last?.color != singleLightColor.color {
            singleLightColorHistory.removeAll(where: { $0 == singleLightColor })
            singleLightColorHistory.append(LightColor(color: singleLightColor.color))
            
            let count = singleLightColorHistory.count
            
            if count > 7 {
                singleLightColorHistory.removeFirst()
            }
        }
    }
    
    
    
    
    
}


extension Array: Identifiable where Element: Hashable {
   public var id: Self { self }
}
