//
//  BackgroundView.swift
//  Nightlight
//
//  Created by Simon Lang on 30.12.22.
//

import SwiftUI

struct SingleColorView: View {
    
    var color: Color
    var opacity: Double
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
            Rectangle()
                .foregroundColor(color)
                .opacity(opacity)
            
            
        }
            
                
    }
}

struct SingleColorView_Previews: PreviewProvider {
    static var previews: some View {
        SingleColorView(color: Color(.sRGB, red: 0.2, green: 0.8, blue: 0.1), opacity: 0.1)
    }
}
