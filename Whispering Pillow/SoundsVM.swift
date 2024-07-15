//
//  SoundsVM.swift
//  Whispering Pillow
//
//  Created by Alvaro Santos Orellana on 14/7/24.
//

import SwiftUI
import AVFAudio

@Observable
class SoundsVM: ObservableObject {
    var audioPlayers: [SoundPlayer] = []
    
    init() {
        setupAudioSession()
        loadMultipleSounds()
    }
    
    deinit {
            NotificationCenter.default.removeObserver(
                self,
                name: AVAudioSession.interruptionNotification,
                object: AVAudioSession.sharedInstance()
            )
            try? AVAudioSession.sharedInstance().setActive(false)
            print("SoundsVM is being deinitialized, cleaning up resources.")
        }
    
    @objc private func handleAudioSessionInterruption(notification: Notification) {
        guard let info = notification.userInfo,
              let typeValue = info[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: typeValue) else { return }
        
        if type == .began {
            stopSounds()
        } else if type == .ended {
            if let optionsValue = info[AVAudioSessionInterruptionOptionKey] as? UInt,
               AVAudioSession.InterruptionOptions(rawValue: optionsValue).contains(.shouldResume) {
                playSounds()
            }
        }
    }
    
    func setupAudioSession() {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                NotificationCenter.default.addObserver(
                            self,
                            selector: #selector(handleAudioSessionInterruption),
                            name: AVAudioSession.interruptionNotification,
                            object: AVAudioSession.sharedInstance()
                        )
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print("Failed to set audio session category: \(error)")
            }
        }
    
    func loadSound(from filename: String) {
        guard let soundFile = NSDataAsset(name: filename) else { return }
        
        do {
            let newAudio = try AVAudioPlayer(data: soundFile.data)
            let soundPlayer = SoundPlayer(name: filename, player: newAudio)
            audioPlayers.append(soundPlayer)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func loadMultipleSounds() {
        let filenames = ["water", "rain", "waves", "storm", "wind", "fire", "nature", "crowd"]
        for filename in filenames {
            loadSound(from: filename)
        }
    }
    
    func playSounds() {
        for audioPlayer in audioPlayers {
            audioPlayer.player.play()
            audioPlayer.player.numberOfLoops = -1
        }
    }
    
    func stopSounds() {
        for audioPlayer in audioPlayers {
            audioPlayer.player.stop()
        }
        
        try? AVAudioSession.sharedInstance().setActive(false)
    }
    
    func pauseSound(audioPlayer: AVAudioPlayer) {
        audioPlayer.pause()
    }
    
    func playSound(audioPlayer: AVAudioPlayer) {
        audioPlayer.play()
        audioPlayer.numberOfLoops = -1
    }
}
