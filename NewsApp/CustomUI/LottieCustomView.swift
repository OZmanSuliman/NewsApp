//
//  Lottie.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import UIKit
import Lottie

class LottieCustomView: UIView {
    var animationView = LottieAnimationView()

    func play(from: AnimationFrameTime? = nil,
              to: AnimationFrameTime? = nil,
              loopMode: LottieLoopMode? = nil,
              completion: LottieCompletionBlock? = nil) {
        if let to {
            animationView.play(fromProgress: from, toProgress: to, loopMode: loopMode, completion: completion)
        } else {
            animationView.loopMode = .loop
            animationView.play(completion: completion)
        }
    }
    
    func getProgress() -> AnimationProgressTime {
        return self.animationView.currentProgress
    }
    func makeUIView(name: String) {
        animationView.animation = LottieAnimation.named(name)
        animationView.contentMode = .scaleAspectFit
        self.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            animationView.topAnchor.constraint(equalTo: topAnchor),
            animationView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
