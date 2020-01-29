//
//  SoundPlayer.swift
//  Snake3D
//
//  Created by Nemo on 2020/1/29.
//  Copyright © 2020 Nemo. All rights reserved.
//

import AVFoundation

class SoundPlayer {
    var bgMusicPlayer: AVAudioPlayer!
    var soundEffectMusicPlayer: AVAudioPlayer!
    
    func playBGM() {
        let bgMusicURL =  Bundle.main.url(forResource: "Super Mario Bros", withExtension: "mp3")!
        try! bgMusicPlayer = AVAudioPlayer (contentsOf: bgMusicURL)
        bgMusicPlayer.numberOfLoops = -1
        bgMusicPlayer.prepareToPlay()
        bgMusicPlayer.play()
    }
    
    func playOneUp() {
        let oneUpMusicURL =  Bundle.main.url(forResource: "1-Up", withExtension: "mp3")!
        try! soundEffectMusicPlayer = AVAudioPlayer (contentsOf: oneUpMusicURL)
        soundEffectMusicPlayer.numberOfLoops = 1
        soundEffectMusicPlayer.prepareToPlay()
        soundEffectMusicPlayer.play()
    }
    
    func gameOver() {
        bgMusicPlayer.stop()
        let oneUpMusicURL =  Bundle.main.url(forResource: "Game Over", withExtension: "mp3")!
        try! soundEffectMusicPlayer = AVAudioPlayer (contentsOf: oneUpMusicURL)
        soundEffectMusicPlayer.numberOfLoops = 1
        soundEffectMusicPlayer.prepareToPlay()
        soundEffectMusicPlayer.play()
    }
}
