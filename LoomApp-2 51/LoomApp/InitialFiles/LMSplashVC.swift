//
//  ViewController.swift
//  Demo alomofire
//
//  Created by chetu on 3/20/25.
//


import UIKit
import AVFoundation

import UIKit
import AVFoundation

class LMSplashVC: UIViewController {
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        playSplashVideo()

        // ✅ Observe app becoming active
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }

    private func playSplashVideo() {
        guard let path = Bundle.main.path(forResource: "1750079959282-343765128", ofType: "mp4") else {
            goToNextScreen()
            return
        }

        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        player?.volume = 0

        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = view.bounds
        playerLayer?.videoGravity = .resizeAspect

        if let playerLayer = playerLayer {
            view.layer.addSublayer(playerLayer)
        }

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(videoDidEnd),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem
        )

        player?.play()
    }

    @objc private func videoDidEnd(notification: Notification) {
        goToNextScreen()
    }

    // ✅ Resume playback when app comes back to foreground
    @objc private func appDidBecomeActive() {
        if let player = player, player.timeControlStatus != .playing {
            player.play()
        }
    }

    private func goToNextScreen() {
        // Stop and remove video
        player?.pause()
        playerLayer?.removeFromSuperlayer()
        player = nil
        playerLayer = nil

        NotificationCenter.default.removeObserver(self)

        // Replace with your actual navigation logic
        self.NavigationController(navigateFrom: self, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
