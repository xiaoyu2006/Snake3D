//
//  SoundPlayer.swift
//  Snake3D
//
//  Created by Yi Cao on 2020/1/29.
//  Copyright © 2020 Yi Cao. All rights reserved.
//

import AVFoundation

class SoundPlayer {
    var soundEffectMusicPlayer: AVAudioPlayer!
    
    func playOneUp() {
        let oneUpMusicURL =  Bundle.main.url(forResource: "1-Up", withExtension: "mp3")!
        try! soundEffectMusicPlayer = AVAudioPlayer (contentsOf: oneUpMusicURL)
        soundEffectMusicPlayer.numberOfLoops = 0
        soundEffectMusicPlayer.prepareToPlay()
        soundEffectMusicPlayer.play()
    }
    
    func gameOver() {
        let oneUpMusicURL =  Bundle.main.url(forResource: "Game Over", withExtension: "mp3")!
        try! soundEffectMusicPlayer = AVAudioPlayer (contentsOf: oneUpMusicURL)
        soundEffectMusicPlayer.numberOfLoops = 0
        soundEffectMusicPlayer.prepareToPlay()
        soundEffectMusicPlayer.play()
    }
}
