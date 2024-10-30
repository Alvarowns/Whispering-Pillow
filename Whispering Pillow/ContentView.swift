//
//  ContentView.swift
//  Whispering Pillow
//
//  Created by Alvaro Santos Orellana on 14/7/24.
//

import SwiftUI
import AVFAudio
import Combine

struct ContentView: View {
    @EnvironmentObject private var viewModel: SoundsVM
    
    @State private var isPlaying: Bool = false
    @State private var timer: Bool = false
    @State private var clockTime: Date = .now
    @State private var timerRunning: Bool = false
    
    let timerPublisher = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
    //                Text("Whispering Pillow")
    //                    .font(.largeTitle)
    //                    .fontWeight(.heavy)
    //                    .foregroundStyle(.white)
    //                    .shadow(color: .eggplant, radius: 2)
    //                    .shadow(color: .eggplant, radius: 2)
    //                    .opacity(0.9)
                    
                    Spacer()
                    
                    VStack {
                        ForEach(viewModel.audioPlayers, id: \.self) { audioPlayer in
                            SingleSoundView(audioPlayer: audioPlayer.player, title: audioPlayer.name.capitalized)
                        }
                    }
                    .disabled(timer ? true : false)
                    .blur(radius: timer ? 3.0 : 0.0)
                    
                    Button {
                        if !isPlaying {
                            isPlaying = true
                            viewModel.playSounds()
                        } else {
                            isPlaying = false
                            viewModel.stopSounds()
                        }
                    } label: {
                        Image(systemName: isPlaying ? "pause" : "play")
                            .symbolVariant(.fill)
                            .foregroundStyle(.white)
                            .font(.custom("", size: 60))
                            .frame(maxHeight: 40)
                            .shadow(radius: 5)
                    }
                    
                    Spacer()
                    
                    Text("Playing until: \(clockTime.formatted(.dateTime.hour().minute()))")
                        .bold()
                        .font(.title2)
                        .foregroundStyle(.white)
                        .opacity(timerRunning ? 1.0 : 0.0)
                    
                    Button {
                        if clockTime > .now {
                            clockTime = .now
                            timerRunning = false
                        } else {
                            timer.toggle()
                        }
                    } label: {
                        Text(clockTime > .now ? "Stop timer" : "Set a timer")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(clockTime > .now ? .red : .blue)
                }
                .frame(maxHeight: .infinity)
                
                VStack {
                    DatePicker("", selection: $clockTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .padding(.trailing)
                    
                    HStack {
                        Button {
                            timer = false
                            timerRunning = true
                        } label: {
                            Text("Set")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                        
                        Button(role: .destructive) {
                            clockTime = .now
                            timer = false
                            timerRunning = false
                        } label: {
                            Text("Cancel")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.white)
                        .padding()
                }
                .opacity(timer ? 1.0 : 0.0)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "cart.fill")
                                .foregroundStyle(.white)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
            .onReceive(timerPublisher) { _ in
                checkTimeAndStopSounds()
            }
            .background {
                Image(.background)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
        }
    }
    
    func checkTimeAndStopSounds() {
            let now = Date()
            let calendar = Calendar.current
            let nowComponents = calendar.dateComponents([.hour, .minute], from: now)
            let setComponents = calendar.dateComponents([.hour, .minute], from: clockTime)
            
            if nowComponents.hour == setComponents.hour && nowComponents.minute == setComponents.minute {
                viewModel.stopSounds()
                isPlaying = false
                timerRunning = false
            }
        }
}

#Preview {
    ContentView()
        .environmentObject(SoundsVM())
}
