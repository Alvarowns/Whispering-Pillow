//
//  SettingsView.swift
//  Whispering Pillow
//
//  Created by Alvaro Santos Orellana on 30/10/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var viewModel: SoundsVM
    
    var body: some View {
        VStack {
            ForEach(viewModel.audioPlayers, id: \.self) { audioPlayer in
                Button {
                    if !viewModel.audioPlayersSelected.contains(audioPlayer) {
                        viewModel.audioPlayersSelected.append(audioPlayer)
                    } else {
                      //Añadir borrar audioplayer
                    }
                } label: {
                    HStack {
                        Image(systemName: "square")
                        
                        Text(audioPlayer.name.capitalized)
                        
                        Spacer()
                    }
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .font(.title2)
                }
            }
            
            Spacer()
        }
        .background {
            Image(.background)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(SoundsVM())
}
