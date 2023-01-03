//
//  colorChangeTimer.swift
//  Nightlight
//
//  Created by Simon Lang on 02.01.23.
//

import Foundation
import SwiftUI


/// Keeps time for your color changes
class ColorChangeTimer: ObservableObject {
    
    /// The color we are changing to at the moment
    @Published var activeColor = LightColor(color: Color(.sRGB, red: 0.98, green: 0.2, blue: 0.2))
    /// All the colors
    var colors: [LightColor] = []
    
    /// The color change length
    var colorChangeLength: Int

    
    private var timer: Timer?
    
    private var colorIndex: Int = 0
    
    init(colorChangeLength: Int = 10, colors: [LightColor] = LightData().nightLight.colorChangeColors) {
        self.colorChangeLength = colorChangeLength
        self.colors = colors
        self.activeColor = colors.first!
    }
    
    
    
    
    /// Start the timer.
    func startColorChange(length: Int, colors: [LightColor], randomOrder: Bool, completeRandom: Bool) {
        changeToColor(length: length, colors: colors, randomOrder: randomOrder, completeRandom: completeRandom)
        
    }
    /// Stop the timer.
    func stopColorChange() {
        timer?.invalidate()
        timer = nil
//        print("stopped timer")
    }
    
    private func changeToColor(length: Int, colors: [LightColor], randomOrder: Bool, completeRandom: Bool) {
        colorIndex = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(length), repeats: true) { timer in

            withAnimation(.linear(duration: Double(length))) {
                if completeRandom == true {
                    self.activeColor = LightColor(color: Color(.sRGB, red: Double.random(in: 0.00...1.00), green: Double.random(in: 0.00...1.00), blue: Double.random(in: 0.00...1.00)))
                    
                }else if randomOrder == false {
                    if self.activeColor == colors.last {
                        self.activeColor = colors.first!
                        self.colorIndex = 0
                    } else {
                        self.activeColor = colors[self.colorIndex + 1]
                        self.colorIndex += 1
                    }
                    
                } else if randomOrder == true {
                    self.activeColor = colors.randomElement() ?? LightColor(color: Color(.sRGB, red: Double.random(in: 0.00...1.00), green: Double.random(in: 0.00...1.00), blue: Double.random(in: 0.00...1.00)))
                }
                
            }
            
            
        }
    }
}
