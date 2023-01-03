//
//  ExperimentalColorShifts.swift
//  Nightlight
//
//  Created by Simon Lang on 02.01.23.
//

import SwiftUI

struct ExperimentalColorShifts: View {
    @State private var theColor = Color(.sRGB, red: 0.2, green: 0.8, blue: 0.1)
    
    @State private var theOpacity = 1.0
    
    var changeTheColor = true
    
    var body: some View {
        
        Rectangle()
            .foregroundColor(theColor)
            .opacity(theOpacity)
            .frame(width: 200, height: 200)
            .onTapGesture {
                withAnimation(.spring(response: 0.55, dampingFraction: 0.45, blendDuration: 0.2)) {
                    theColor = Color(.sRGB, red: Double.random(in: 0.00...1.00), green: Double.random(in: 0.00...1.00), blue: Double.random(in: 0.00...1.00))
                    theOpacity = Double.random(in: 0.00...1.00)
                }
                        
                    
                   
                
                    
            }
    }
}

struct ExperimentalColorShifts_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentalColorShifts()
    }
}
