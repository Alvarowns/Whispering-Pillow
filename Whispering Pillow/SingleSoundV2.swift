//
//  SingleSoundV2.swift
//  Whispering Pillow
//
//  Created by Alvaro Santos Orellana on 30/10/24.
//

import SwiftUI
import AVFAudio

struct SingleSoundV2: View {
    @EnvironmentObject private var viewModel: SoundsVM
    
    @State private var volume: Float = 0.0
    @State private var volumeWhenMuted: Float = 0
    @State private var mute: Bool = false
    
    var audioPlayer: AVAudioPlayer
    var title: String
    var image: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: image)
                .font(.custom("", size: 60))
            
            Text(title.capitalized)
                .bold()
                .font(.title3)
            
            Slider(value: $volume, in: 0...2) { _ in
                audioPlayer.volume = volume
            }
            .frame(height: 10)
            .tint(.white)
            .padding(.horizontal)
        }
        .opacity(mute || volume == 0 ? 0.3 : 1.0)
        .foregroundStyle(.white)
        .onAppear {
            audioPlayer.volume = volume
            audioPlayer.numberOfLoops = -1
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(SoundsVM())
}
