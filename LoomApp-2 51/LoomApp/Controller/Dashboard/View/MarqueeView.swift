//
//  MarqueeView.swift
//  LoomApp
//
//  Created by Flucent tech on 26/05/25.
//

import UIKit

class MarqueeView: UIView {
    private let marqueeLabel = UILabel()
    private var animationDuration: TimeInterval = 30.0
    private var timer: Timer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMarquee()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupMarquee()
    }

    private func setupMarquee() {
        clipsToBounds = true
        addSubview(marqueeLabel)
        marqueeLabel.textColor = .white
        marqueeLabel.font = UIFont(name: ConstantFontSize.regular, size: 16)
    }

    func startMarquee(text: String, duration: TimeInterval = 30.0) {
        animationDuration = duration
        marqueeLabel.text = text
        marqueeLabel.sizeToFit()

        // Start from right edge
        marqueeLabel.frame.origin = CGPoint(x: bounds.width, y: (bounds.height - marqueeLabel.frame.height)/2)

        // Start timer to repeat animation
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(animateMarquee), userInfo: nil, repeats: false)
    }

    @objc private func animateMarquee() {
        UIView.animate(withDuration: animationDuration, delay: 0, options: [.curveLinear], animations: {
            self.marqueeLabel.frame.origin.x = -self.marqueeLabel.frame.width
        }) { _ in
            // Restart
            self.startMarquee(text: self.marqueeLabel.text ?? "", duration: self.animationDuration)
        }
    }

    deinit {
        timer?.invalidate()
    }
}
