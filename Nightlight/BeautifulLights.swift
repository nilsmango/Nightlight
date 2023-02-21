//
//  BeautifulLights.swift
//  Nightlight
//
//  Created by Simon Lang on 20.02.23.
//

import SwiftUI

struct BeautifulLights: View {
    var body: some View {
        FloatingClouds()
    }
}
class CloudProvider {
    let offset: CGSize
    let frameHeightRatio: CGFloat
    
    init() {
        frameHeightRatio = CGFloat.random(in: 0.3..<4)
        offset = CGSize(width: CGFloat.random(in: -150..<150), height: CGFloat.random(in: -150..<150))
    }
}


struct Cloud: View {
    // Using @State as we need to look for changes, but don't have to get any info back to the provider.
    @State private var provider = CloudProvider()
    @State private var move = false
    
    let rotationStart: Double
    let duration: Double
    let alignment: Alignment
    let proxy: GeometryProxy
    let color: Color
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(height: proxy.size.height / provider.frameHeightRatio)
            .offset(provider.offset)
            .rotationEffect(.init(degrees: move ? rotationStart : rotationStart + 360))
            .animation(.linear(duration: duration).repeatForever(autoreverses: false), value: move)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
            .opacity(0.8)
            .onAppear {
                move.toggle()
            }
    }
}





struct FloatingClouds: View {
    @Environment(\.colorScheme) var scheme
    let blurRadius: CGFloat = 90
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Cloud(rotationStart: 0, duration: 60, alignment: .topLeading, proxy: proxy, color: Theme.ellipsesTopLeading(forScheme: scheme))
                Cloud(rotationStart: 240, duration: 50, alignment: .topTrailing, proxy: proxy, color: Theme.ellipsesTopTrailing(forScheme: scheme))
                Cloud(rotationStart: 120, duration: 80, alignment: .bottomLeading, proxy: proxy, color: Theme.ellipsesBottomLeading(forScheme: scheme))
                Cloud(rotationStart: 180, duration: 70, alignment: .bottomTrailing, proxy: proxy, color: Theme.ellipsesBottomTrailing(forScheme: scheme))
                    }
            .blur(radius: blurRadius)
            .background(Theme.generalBackground)
            .ignoresSafeArea()
        }
        
    }
}

struct Theme {
    static var generalBackground: Color {
        Color(red: 0.043, green: 0.467, blue: 0.494)
    }
    
    static func ellipsesTopLeading(forScheme scheme: ColorScheme) -> Color {
        let any = Color(red: 0.039, green: 0.388, blue: 0.502, opacity: 0.81)
        let dark = Color(red: 0.000, green: 0.176, blue: 0.216, opacity: 80.0)
        
        switch scheme {
                case .light:
                    return any
                case .dark:
                    return dark
                @unknown default:
                    return any
                }
            }

            static func ellipsesTopTrailing(forScheme scheme: ColorScheme) -> Color {
                let any = Color(red: 0.196, green: 0.796, blue: 0.329, opacity: 0.5)
                let dark = Color(red: 0.408, green: 0.698, blue: 0.420, opacity: 0.61)
                
                switch scheme {
                case .light:
                    return any
                case .dark:
                    return dark
                @unknown default:
                    return any
                }
            }

            static func ellipsesBottomTrailing(forScheme scheme: ColorScheme) -> Color {
                Color(red: 0.541, green: 0.733, blue: 0.812, opacity: 0.7)
            }

            static func ellipsesBottomLeading(forScheme scheme: ColorScheme) -> Color {
                let any = Color(red: 0.196, green: 0.749, blue: 0.486, opacity: Double.random(in: 0.4...0.8))
                let dark = Color(red: 0.525, green: 0.859, blue: 0.655, opacity: 0.45)
               
                switch scheme {
                case .light:
                    return any
                case .dark:
                    return dark
                @unknown default:
                    return any
                }
            }
        }



struct BeautifulLights_Previews: PreviewProvider {
    static var previews: some View {
        BeautifulLights()
    }
}
