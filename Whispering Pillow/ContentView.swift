//
//  ContentView.swift
//  Whispering Pillow
//
//  Created by Alvaro Santos Orellana on 14/7/24.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @EnvironmentObject private var viewModel: SoundsVM
    
    @State private var isPlaying: Bool = false
    
    var body: some View {
            VStack {
                Text("Whispering Pillow")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
                    .shadow(color: .eggplant, radius: 2)
                    .shadow(color: .eggplant, radius: 2)
                    .opacity(0.9)
                
                Spacer()
                
                VStack {
                    ForEach(viewModel.audioPlayers, id: \.self) { audioPlayer in
                        SingleSoundView(audioPlayer: audioPlayer.player, title: audioPlayer.name.capitalized)
                    }
                }
                .padding(.bottom, 40)
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .background {
                Image(.background)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
    }
}

#Preview {
    ContentView()
        .environmentObject(SoundsVM())
}
