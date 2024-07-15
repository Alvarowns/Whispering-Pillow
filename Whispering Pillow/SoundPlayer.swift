//
//  SoundPlayer.swift
//  Whispering Pillow
//
//  Created by Alvaro Santos Orellana on 14/7/24.
//

import Foundation
import AVFAudio

struct SoundPlayer: Hashable {
    let name: String
    var player: AVAudioPlayer
}
