//
//  LightStatus.swift
//  Nightlight
//
//  Created by Simon Lang on 30.12.22.
//

import Foundation
import SwiftUI

class LightData: ObservableObject {
    @Published var nightLight: NightLight = NightLight(currentLight: .singleColor, flicker: false, singleLightColor: LightColor(color: Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2), id: UUID()), singleLightColorHistory: [LightColor(color: Color(.sRGB, red: 0.98, green: 0.2, blue: 0.2), id: UUID())], colorChangeColors: [LightColor(color: Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2), id: UUID()), LightColor(color: Color(.sRGB, red: 0.3, green: 0.5, blue: 0.5), id: UUID())], colorChangeHistory: [[LightColor(color: Color(.sRGB, red: 0.8, green: 0.9, blue: 0.5), id: UUID()), LightColor(color: Color(.sRGB, red: 0.98, green: 0.9, blue: 0.6), id: UUID())]], colorChangeSpeed: 11, randomColorChange: false, completeRandom: false, sunIsActive: true, sunStrength: 50)
    
    
   
    
}
