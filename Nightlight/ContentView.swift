//
//  ContentView.swift
//  Nightlight
//
//  Created by Simon Lang on 28.12.22.
//

import SwiftUI




struct ContentView: View {
    
    @Binding var nightLight: NightLight
    
    @StateObject var colorTimer = ColorChangeTimer()
    
    @StateObject var flickerTimer = FlickerTimer()
    
    @State private var showOptions = true

    var body: some View {
        ZStack {
            
            
                switch nightLight.currentLight {
                case .singleColor:
                    SingleColorView(color: nightLight.singleLightColor.color, opacity: flickerTimer.opacity)
                        .ignoresSafeArea()
                        .onDisappear() {
                            flickerTimer.stopFlicker()
                        }
                    
                case .colorChange:
                    SingleColorView(color: colorTimer.activeColor.color, opacity: flickerTimer.opacity)
                            .ignoresSafeArea()
                            .onDisappear() {
                                colorTimer.stopColorChange()
                            }
                          

                case .rain:
                    RainView()
                
                case .fire:
                    SingleColorView(color: nightLight.singleLightColor.color, opacity: 1.0)
                        .ignoresSafeArea()
               
                case .lavaLamp:
                    LavaLamp()
                        
                    
                case .lightMotion:
                    LightMotion()
                    
                case .sun:
                    SunView(sunActive: nightLight.sunIsActive, sunStrength: nightLight.sunStrength)
                    
                case .lightMotion2:
                    LightMotionCopy()
                }
            
            
            
            
                
        }
        .onTapGesture {
            nightLight.updateHistory()
            showOptions.toggle()
        }
        
        
        .sheet(isPresented: $showOptions) {
            OptionsView(nightLight: $nightLight)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.hidden)
                .onDisappear() {
                    if nightLight.currentLight == .colorChange {
                        colorTimer.stopColorChange()
                        
                        colorTimer.startColorChange(length: nightLight.colorChangeSpeed, colors: nightLight.colorChangeColors, randomOrder: nightLight.randomColorChange, completeRandom: nightLight.completeRandom)
                    }
                    if nightLight.flicker == true {
                        flickerTimer.stopFlicker()
                        flickerTimer.startFlicker()
                    }
                    if nightLight.flicker == false {
                        flickerTimer.stopFlicker()
                    }
                    
                    
                }
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(nightLight: .constant(NightLight(currentLight: .singleColor, flicker: true, singleLightColor: LightColor(color: Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2), id: UUID()), singleLightColorHistory: [LightColor(color: Color(.sRGB, red: 0.98, green: 0.2, blue: 0.2), id: UUID())], colorChangeColors: [LightColor(color: Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2), id: UUID()), LightColor(color: Color(.sRGB, red: 0.3, green: 0.5, blue: 0.5), id: UUID())], colorChangeHistory: [[LightColor(color: Color(.sRGB, red: 0.8, green: 0.9, blue: 0.5), id: UUID()), LightColor(color: Color(.sRGB, red: 0.98, green: 0.9, blue: 0.6), id: UUID())]], colorChangeSpeed: 1, randomColorChange: false, completeRandom: false, sunIsActive: true, sunStrength: 50)))
    }
}
