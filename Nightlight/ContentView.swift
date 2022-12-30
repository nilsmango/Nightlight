//
//  ContentView.swift
//  Nightlight
//
//  Created by Simon Lang on 28.12.22.
//

import SwiftUI




struct ContentView: View {
    
    @Binding var nightLight: NightLight
    
    @State private var showOptions = true

    var body: some View {
        ZStack {
            BackgroundView(color: nightLight.singleLightColor)
                .ignoresSafeArea()
        }
        .onTapGesture {
            withAnimation() {
                showOptions.toggle()
            }
            
        }
        
        .sheet(isPresented: $showOptions) {
            OptionsView(nightLight: $nightLight)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.hidden)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(nightLight: .constant(NightLight(currentLight: .singleColor, singleLightColor: Color(.sRGB, red: 0.2, green: 0.8, blue: 0.4), singleLightColorHistory: [Color(.sRGB, red: 0.8, green: 0.4, blue: 0.1)])))
    }
}
