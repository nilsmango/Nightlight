//
//  Light.swift
//  Nightlight
//
//  Created by Simon Lang on 29.12.22.
//

import Foundation


enum Light: CaseIterable, Identifiable {
    case singleColor, candleLight, fire, colorChange
    var id: Self { self }
    
    
    func stringValue() -> String {
        switch(self) {
        case .singleColor:
            return "Single Color"
            
        case .candleLight:
            return "Candle Light"
            
        case .fire:
            return "Fire"
            
        case .colorChange:
            return "Color Change"
            
        }
    }
    
}
