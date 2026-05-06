//
//  SoundService.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import AVFoundation
import Foundation
import Combine

enum SoundEffect: String {
    case cardFlip = "card_flip"
    case cardShuffle = "card_shuffle"
    case cardDraw = "card_draw"
    case ambientMystic = "ambient_mystic"
    case bellChime = "bell_chime"
    case success = "success"
    case whoosh = "whoosh"
    case click = "click"
    case fire = "fire"
    case magicButton = "magic_button"
    case reverse = "reverse"
    case toggle = "toggle"
}

class SoundService: NSObject, ObservableObject {
    static let shared = SoundService()
    
    @Published var isSoundEnabled: Bool = UserDefaults.standard.object(forKey: "isSoundEnabled") as? Bool ?? true {
        didSet {
            UserDefaults.standard.set(isSoundEnabled, forKey: "isSoundEnabled")
        }
    }
    
    private var soundPlayers: [String: AVAudioPlayer] = [:]
    private var ambientPlayer: AVAudioPlayer?
    
    private override init() {
        super.init()
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to setup audio session: \(error)")
        }
    }
    
    func preloadSounds() {
        for sound in [SoundEffect.cardFlip, .cardShuffle, .cardDraw, .bellChime, .success, .whoosh, .magicButton, .ambientMystic, .click, .fire, .reverse, .toggle] {
            preloadSound(sound)
        }
    }
    
    private func preloadSound(_ sound: SoundEffect) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3") ??
                        Bundle.main.url(forResource: sound.rawValue, withExtension: "wav") ??
                        Bundle.main.url(forResource: sound.rawValue, withExtension: "m4a") else {
            print("Sound file not found: \(sound.rawValue)")
            return
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            soundPlayers[sound.rawValue] = player
        } catch {
            print("Failed to preload sound \(sound.rawValue): \(error)")
        }
    }
    
    func play(_ sound: SoundEffect, volume: Float = 1.0) {
        guard isSoundEnabled else { return }
        
        if let player = soundPlayers[sound.rawValue] {
            player.volume = volume
            player.currentTime = 0
            player.play()
        } else {
            // Try to load and play if not preloaded
            guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3") ??
                            Bundle.main.url(forResource: sound.rawValue, withExtension: "wav") ??
                            Bundle.main.url(forResource: sound.rawValue, withExtension: "m4a") else {
                return
            }
            
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.volume = volume
                player.prepareToPlay()
                player.play()
                soundPlayers[sound.rawValue] = player
            } catch {
                print("Failed to play sound \(sound.rawValue): \(error)")
            }
        }
    }
    
    func stop(_ sound: SoundEffect) {
        soundPlayers[sound.rawValue]?.stop()
    }
    
    func playAmbient(_ sound: SoundEffect, volume: Float = 0.3, loop: Bool = true) {
        guard isSoundEnabled else { return }
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3") ??
                        Bundle.main.url(forResource: sound.rawValue, withExtension: "wav") ??
                        Bundle.main.url(forResource: sound.rawValue, withExtension: "m4a") else {
            return
        }
        
        do {
            ambientPlayer = try AVAudioPlayer(contentsOf: url)
            ambientPlayer?.volume = volume
            ambientPlayer?.numberOfLoops = loop ? -1 : 0
            ambientPlayer?.prepareToPlay()
            ambientPlayer?.play()
        } catch {
            print("Failed to play ambient sound: \(error)")
        }
    }
    
    func stopAmbient(fadeOut: Bool = true) {
        if fadeOut {
            fadeOutAmbient()
        } else {
            ambientPlayer?.stop()
            ambientPlayer = nil
        }
    }
    
    private func fadeOutAmbient(duration: TimeInterval = 1.0) {
        guard let player = ambientPlayer else { return }
        
        let startVolume = player.volume
        let steps = 20
        let stepDuration = duration / Double(steps)
        
        for i in 0..<steps {
            DispatchQueue.main.asyncAfter(deadline: .now() + (stepDuration * Double(i))) {
                player.volume = startVolume * Float(steps - i) / Float(steps)
                
                if i == steps - 1 {
                    player.stop()
                    self.ambientPlayer = nil
                }
            }
        }
    }
}
