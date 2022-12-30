//
//  BackgroundView.swift
//  Nightlight
//
//  Created by Simon Lang on 30.12.22.
//

import SwiftUI

struct BackgroundView: View {
    
    var color: Color
    
    var body: some View {
        Rectangle()
            .foregroundColor(color)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(color: Color(.sRGB, red: 0.2, green: 0.8, blue: 0.1))
    }
}
