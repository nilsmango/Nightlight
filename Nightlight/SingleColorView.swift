//
//  BackgroundView.swift
//  Nightlight
//
//  Created by Simon Lang on 30.12.22.
//

import SwiftUI

struct SingleColorView: View {
    
    var color: Color
    
    var body: some View {
            Rectangle()
                .foregroundColor(color)
    }
}

struct SingleColorView_Previews: PreviewProvider {
    static var previews: some View {
        SingleColorView(color: Color(.sRGB, red: 0.2, green: 0.8, blue: 0.1))
    }
}
