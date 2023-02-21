//
//  Light.swift
//  Nightlight
//
//  Created by Simon Lang on 29.12.22.
//

import Foundation
import SwiftUI


enum Light: CaseIterable, Identifiable {
    case singleColor, colorChange, lavaLamp, rain, fire, lightMotion, lightMotion2, sun
    var id: Self { self }
    
    
    func stringValue() -> String {
        switch(self) {
        case .singleColor:
            return "Single Color"
            
        case .lavaLamp:
            return "Lava Lamp"
            
        case .fire:
            return "Fire"
            
        case .colorChange:
            return "Color Change"
            
        case .rain:
            return "Rain"
            
        case .lightMotion:
            return "Light Motion"
            
        case .lightMotion2:
            return "Light Motion 2"
            
        case .sun:
            return "Sun"
        }
    }
    
}

struct LightColor: Identifiable, Hashable {
    var color: Color
    var id = UUID()
}

extension LightColor: Equatable {
    static func == (lhs: LightColor, rhs: LightColor) -> Bool {
        return lhs.color == rhs.color
    }
}
