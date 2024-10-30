//
//  SingleSoundView.swift
//  Whispering Pillow
//
//  Created by Alvaro Santos Orellana on 14/7/24.
//

import SwiftUI
import AVFAudio

struct SingleSoundView: View {
    @EnvironmentObject private var viewModel: SoundsVM
    
    @State private var volume: Float = 0.0
    @State private var volumeWhenMuted: Float = 0
    @State private var mute: Bool = false
    
    var audioPlayer: AVAudioPlayer
    var title: String
    
    var body: some View {
        withAnimation {
            HStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.medium)
                    .frame(width: 100)
                
                Slider(value: $volume, in: 0...2) { _ in
                    audioPlayer.volume = volume
                }
                .tint(.white.opacity(0.8))
                .frame(height: 20)
                .disabled(mute ? true : false)
                
                Button {
                    if !mute {
                        volumeWhenMuted = volume
                        volume = 0
                        audioPlayer.volume = 0
                        mute = true
                    } else {
                        audioPlayer.volume = volumeWhenMuted
                        volume = volumeWhenMuted
                        mute = false
                    }
                } label: {
                    Image(systemName: mute ? "speaker.slash.fill" : "speaker.fill")
                        .font(.title)
                        .fontWeight(.medium)
                }
                .padding(.horizontal)
            }
            .foregroundStyle(.white)
            .opacity(mute || volume == 0 ? 0.3 : 1.0)
            .padding()
        }
        .animation(.easeInOut, value: mute)
        .onAppear {
            audioPlayer.volume = volume
//            audioPlayer.play()
            audioPlayer.numberOfLoops = -1
        }
    }
}
