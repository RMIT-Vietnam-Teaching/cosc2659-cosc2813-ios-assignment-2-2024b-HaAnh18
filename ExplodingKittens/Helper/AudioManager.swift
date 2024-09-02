//
//  AudioManager.swift
//  ExplodingKittens
//
//  Created by Nana on 26/8/24.
//
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2024B
  Assessment: Assignment 2
  Author: Nguyen Tran Ha Anh
  ID: s3938490
  Created  date: 06/08/2024
  Last modified: 03/09/2024
  Acknowledgement:
*/

import Foundation
import SwiftUI
import AVFoundation

// A class to manage audio playback for background music and sound effects.
class AudioManager: ObservableObject {
    // Player for background music.
    private var backgroundMusicPlayer: AVAudioPlayer?
    
    // Player for sound effects.
    private var soundEffectPlayer: AVAudioPlayer?

    // Function to play background music from a specified file.
    func playBackgroundMusic(fileName: String, fileType: String) {
        if backgroundMusicPlayer?.isPlaying == true {
            // Check if background music is already playing.
            return // Do nothing if the music is already playing
        }

        // Get the file path for the specified music file.
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
            do {
                // Initialize the background music player with the file URL.
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                backgroundMusicPlayer?.numberOfLoops = -1 // Loop indefinitely
                backgroundMusicPlayer?.play() // Start playing the music.
            } catch {
                print("Error playing background music: \(error.localizedDescription)")
            }
        }
    }

    // Function to stop playing background music.
    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
    }
    
    // Function to play a sound effect from a specified file.
    func playSoundEffect(sound: String, type: String) {
        // Get the file path for the specified sound effect file.
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                // Initialize the sound effect player with the file URL.
                soundEffectPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                soundEffectPlayer?.play()
            } catch {
                print("ERROR: Could not find and play the sould file!")
            }
        }
    }
}
