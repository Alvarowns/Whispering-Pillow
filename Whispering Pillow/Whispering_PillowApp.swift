//
//  Whispering_PillowApp.swift
//  Whispering Pillow
//
//  Created by Alvaro Santos Orellana on 14/7/24.
//

import SwiftUI
import AVFAudio

@main
struct Whispering_PillowApp: App {
    @StateObject private var viewModel = SoundsVM()
    var body: some Scene {
        WindowGroup {
            AppStateView()
                .environmentObject(SoundsVM())
        }
    }
}
