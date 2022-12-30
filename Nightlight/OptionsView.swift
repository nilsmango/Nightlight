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
    
    var body: some View {
        
            List {
                
                Section(header: Text("NightLight Options")) {
                    
                    Picker("Style", selection: $nightLight.currentLight) {
                                            ForEach(Light.allCases) { mode in
                                                let string = mode.stringValue()
                                                Text(string)
                                            }
                                        }
                                        if light == .singleColor {
                                            ColorPicker("Color", selection: $nightLight.singleLightColor)
                                        }
                }
                
                    
                    
                }
        
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView(nightLight: .constant(NightLight(currentLight: .singleColor, singleLightColor: Color(.sRGB, red: 0.2, green: 0.8, blue: 0.1), singleLightColorHistory: [Color(.sRGB, red: 0.2, green: 0.2, blue: 0.1)])))
    }
}
