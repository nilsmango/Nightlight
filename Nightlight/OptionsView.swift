//
//  OptionsView.swift
//  Nightlight
//
//  Created by Simon Lang on 29.12.22.
//

import SwiftUI

struct OptionsView: View {
    
    @State var light: Light = .singleColor
    
    @Binding var nightLight: NightLight
    
    let CCstep = 1
    let CCrange = 1...60
    
    var body: some View {
        
        List {
            
            Section(header: Text("NightLight Light Style")) {
                
                Picker("Style", selection: $nightLight.currentLight) {
                    ForEach(Light.allCases) { mode in
                        let string = mode.stringValue()
                        Text(string)
                    }
                }
            }
            
            // SINGLE COLOR LIGHT
            
            if nightLight.currentLight == .singleColor {
                Section(header: Text("Light Color")) {
                    ColorPicker("Color", selection: $nightLight.singleLightColor.color)
                    Toggle("Flicker", isOn: $nightLight.flicker)
                }
                
                Section {
                    Button(action: {
                        
                        nightLight.singleLightColor = LightColor(color: Color(.sRGB, red: Double.random(in: 0.00...1.00), green: Double.random(in: 0.00...1.00), blue: Double.random(in: 0.00...1.00)))
                        
                    }) {
                        Label("New Random Color", systemImage: "wand.and.stars")
                        
                    }
                    
                    
                }
                Section {
                    
                    HStack {
                        Text("History")
                        Spacer()
                        ForEach(nightLight.singleLightColorHistory) { nightColor in
                            
                            Button(action: {
                                nightLight.singleLightColor = nightColor
                            }) {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(nightColor.color)
                                    .font(.title2)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .accessibilityLabel(Text("Choose this color"))
                        }
                    }
                }
            }
            
            // COLOR CHANGE LIGHT
            
            if nightLight.currentLight == .colorChange {
                
                Section(header: Text("Color Change Options")) {
                    Stepper("Change Time: \(nightLight.colorChangeSpeed) s", value: $nightLight.colorChangeSpeed, in: CCrange, step: CCstep)
                    
                    Toggle("Flicker", isOn: $nightLight.flicker)
                    
                    Toggle("Random Colors", isOn: $nightLight.completeRandom)
                    
                    if nightLight.completeRandom == false {
                        Toggle("Random Change Order", isOn: $nightLight.randomColorChange)
                    }
                }
                
                if nightLight.completeRandom == false {
                    
                    Section(header: Text("Color Change Colors")) {
                        
                        ForEach($nightLight.colorChangeColors) { $nightColor in
                            
                            let count = nightLight.colorChangeColors.firstIndex(where: { $0.id == $nightColor.id } )! + 1
                            
                            ColorPicker("Color \(String(count))", selection: $nightColor.color)
                            
                        }
                        .onMove { indexSet, offset in
                            nightLight.colorChangeColors.move(fromOffsets: indexSet, toOffset: offset)
                        }
                        .onDelete { indexSet in
                            nightLight.colorChangeColors.remove(atOffsets: indexSet)
                        }
                        
                        if nightLight.colorChangeColors.count < 9 {
                            
                            HStack {
                                Text("Add Color")
                                Spacer()
                                
                                Button(action: {
                                    // add a random color
                                    nightLight.colorChangeColors.append(LightColor(color: Color(.sRGB, red: Double.random(in: 0.00...1.00), green: Double.random(in: 0.00...1.00), blue: Double.random(in: 0.00...1.00))))
                                    
                                }) {
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(.secondary)
                                        .font(.title2)
                                }
                            }
                        }
                    }
                    
                    Section {
                        Button(action: {
                            // save to colorChangeHistory
                            nightLight.colorChangeColors = [LightColor(color: Color(.sRGB, red: Double.random(in: 0.00...1.00), green: Double.random(in: 0.00...1.00), blue: Double.random(in: 0.00...1.00)))]
                            
                        }) {
                            Label("New Color Change", systemImage: "eraser")
                            
                        }
                        
                        if nightLight.colorChangeColors.count > 1 && nightLight.colorChangeHistory.contains(nightLight.colorChangeColors) == false {
                            Button(action: {
                                // save to colorChangeHistory
                                nightLight.colorChangeHistory.append(nightLight.colorChangeColors)
                                
                            }) {
                                Label("Save Color Change to Favorites", systemImage: "star")
                                
                            }
                        }
                    }
                    
                    Section(header: Text("Favorite Color Changes")) {
                        
                        ForEach(nightLight.colorChangeHistory) { colorArray in
                            Button(action: {
                                // save to colorChangeHistory
                                nightLight.colorChangeColors = colorArray
                                
                            }) {
                                HStack {
                                    ForEach(colorArray) { lightColor in
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(lightColor.color)
                                            .font(.title2)
                                    }
                                }
                                
                            }
                        }
                    }
                }
                
                
                
                
                
                
            }
        }
        
    }
    
    
    
}



struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView(nightLight: .constant(NightLight(currentLight: .colorChange, flicker: false, singleLightColor: LightColor(color: Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2), id: UUID()), singleLightColorHistory: [LightColor(color: Color(.sRGB, red: 0.98, green: 0.2, blue: 0.2), id: UUID())], colorChangeColors: [LightColor(color: Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2), id: UUID()), LightColor(color: Color(.sRGB, red: 0.3, green: 0.5, blue: 0.5), id: UUID()), LightColor(color: Color(.sRGB, red: 0.92, green: 0.2, blue: 0.3), id: UUID())], colorChangeHistory: [[LightColor(color: Color(.sRGB, red: 0.8, green: 0.9, blue: 0.5), id: UUID()), LightColor(color: Color(.sRGB, red: 0.98, green: 0.9, blue: 0.6), id: UUID()), LightColor(color: Color(.sRGB, red: 0.98, green: 0.9, blue: 0.6), id: UUID()), LightColor(color: Color(.sRGB, red: 0.98, green: 0.9, blue: 0.6), id: UUID())]], colorChangeSpeed: 1, randomColorChange: false, completeRandom: false)))
    }
}
