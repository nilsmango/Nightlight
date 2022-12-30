//
//  NightlightApp.swift
//  Nightlight
//
//  Created by Simon Lang on 28.12.22.
//

import SwiftUI

@main
struct NightlightApp: App {
    
    @ObservedObject private var lightData = LightData()
    
    var body: some Scene {
        WindowGroup {
            ContentView(nightLight: $lightData.nightLight)
        }
    }
}
