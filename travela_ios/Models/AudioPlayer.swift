//
//  AudioPlayer.swift
//  travela_ios
//
//  Created by LEI SUN on 11/12/24.
//

import Foundation
import AVFoundation
import MediaPlayer

class AudioPlayer: ObservableObject {
    
    @Published var isPlaying: Bool = false
    @Published var currentTime: TimeInterval = 0
    
    var player: AVPlayer?
    private var timeObserverToken: Any?
    
    func setup(url: String) {
        guard let url2 = Bundle.main.path(forResource: "canon_in_d", ofType: "mp3") else { return }
        self.player = AVPlayer(url: URL(fileURLWithPath: url2))
        self.setupRemoteControls()
    }
    
    func play() {
        self.isPlaying = true
        player?.play()
        addTimeObserver()
    }
    
    func pause() {
        self.isPlaying = false
        player?.pause()
    }
    
    func stop() {
        player?.pause()
        player?.seek(to: .zero)
    }
    
    func goBackward() {
        let currentTime = (player?.currentTime().seconds)!
        let newTime = currentTime - 15
        let time = CMTime(seconds: newTime, preferredTimescale: 1000)
        player?.seek(to: time)
    }
    
    func goForward() {
        let currentTime = (player?.currentTime().seconds)!
        let newTime = currentTime + 15
        let time = CMTime(seconds: newTime, preferredTimescale: 1000)
        player?.seek(to: time)
    }
    
    func setupRemoteControls() {
        let remoteCommandCenter = MPRemoteCommandCenter.shared()
        
        remoteCommandCenter.playCommand.addTarget { [weak self] event in
            self?.play()
            return .success
        }
        
        remoteCommandCenter.pauseCommand.addTarget { [weak self] event in
            self?.pause()
            return .success
        }
        
        remoteCommandCenter.stopCommand.addTarget { [weak self] event in
            self?.stop()
            return .success
        }
    }
    
    private func addTimeObserver() {
        let interval: CMTime = .init(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserverToken = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let self else { return }
            self.currentTime = time.seconds
        }
    }
    
    private func removeTimeObserver() {
        if let token = timeObserverToken {
            player?.removeTimeObserver(token)
            timeObserverToken = nil
        }
    }
}
