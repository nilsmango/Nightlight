//
//  flickerTimer.swift
//  Nightlight
//
//  Created by Simon Lang on 03.01.23.
//


import Foundation
import SwiftUI


/// Keeps time for your color changes
class FlickerTimer: ObservableObject {
    
    /// The color we are changing to at the moment
    @Published var opacity = 1.00
   
    

    
    private var timer: Timer?
    
    
    
    init(opacity: Double = 1.00) {
        self.opacity = opacity
    }
    
    
    
    
    /// Start the timer.
    func startFlicker() {
        makeFlicker()

    }
    /// Stop the timer.
    func stopFlicker() {
        timer?.invalidate()
        timer = nil
//        print("stopped flicker")
    }
    
    private func makeFlicker() {

        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(Double.random(in: 0.20...1.2)), repeats: false) { timer in
//            print("run flicker timer")
            let number = Int.random(in: 1...5)
            
            if number > 3 {
                withAnimation(.linear(duration: Double.random(in: 0.14...0.4))) {
          
                    self.opacity = Double.random(in: 0.50...1.0)

                        
                    }
                
                withAnimation(.linear(duration: Double.random(in: 0.20...0.4))) {
                    
                    self.opacity = Double.random(in: 0.94...1.00)

                    
                }
            }
            self.makeFlickerTwo()
                
            }
            
            
        }
    
    private func makeFlickerTwo() {
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(Double.random(in: 0.10...1.5)), repeats: false) { timer in
            let number = Int.random(in: 1...5)
            
            if number >= 3 {
                withAnimation(.linear(duration: Double.random(in: 0.60...1))) {
          
                    self.opacity = Double.random(in: 0.2...1.0)

                        
                    }
                
                withAnimation(.linear(duration: Double.random(in: 0.20...0.4))) {
                    
                    self.opacity = Double.random(in: 0.94...1.00)
                    
                }
            } else {
                withAnimation(.linear(duration: Double.random(in: 0.20...0.4))) {
                    
                    self.opacity = 1.0
                    
                }
            }
            self.makeFlicker()
            
            
        }
    }
    
    }

