//
//  AppStateView.swift
//  Whispering Pillow
//
//  Created by Alvaro Santos Orellana on 14/7/24.
//

import SwiftUI

struct AppStateView: View {
    @State private var start: Bool = false
    @State private var size: Double = 0.8
    @State private var textSize: Double = 0.8
    @State private var opacity: Double = 0.5
    @State private var textOpacity: Double = 0.0
    
    var body: some View {
        if !start {
            VStack {
                Image(.whisperingPillowLogoSinFondo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200)
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.5)) {
                            self.size = 1.5
                            self.opacity = 1.0
                        }
                    }
                
                Text("Whispering Pillow")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
                    .shadow(color: .eggplant, radius: 2)
                    .shadow(color: .eggplant, radius: 2)
                    .scaleEffect(textSize)
                    .opacity(textOpacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 2)) {
                            self.textSize = 1.2
                            self.textOpacity = 1.0
                        }
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Image(.background)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.start = true
                }
            }
        } else {
            ContentView()
        }
    }
}

#Preview {
    AppStateView()
        .environmentObject(SoundsVM())
}
