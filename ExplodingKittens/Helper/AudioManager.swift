//
//  AudioManager.swift
//  ExplodingKittens
//
//  Created by Nana on 26/8/24.
//

import Foundation
import SwiftUI
import AVFoundation

class AudioManager: ObservableObject {
    private var backgroundMusicPlayer: AVAudioPlayer?
    private var soundEffectPlayer: AVAudioPlayer?

    func playBackgroundMusic(fileName: String, fileType: String) {
        if backgroundMusicPlayer?.isPlaying == true {
            return // Do nothing if the music is already playing
        }

        if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                backgroundMusicPlayer?.numberOfLoops = -1 // Loop indefinitely
                backgroundMusicPlayer?.play()
            } catch {
                print("Error playing background music: \(error.localizedDescription)")
            }
        }
    }

    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
    }
    
    func playSoundEffect(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                soundEffectPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                soundEffectPlayer?.play()
            } catch {
                print("ERROR: Could not find and play the sould file!")
            }
        }
    }
}
