//
//  CustomPageControl.swift
//  CustomPageControl
//
//  Created by Shivaditya Kumar on 2022-12-01.
//

import UIKit


class MarqueeLabel: UIView {
    private let label = UILabel()
    private var textWidth: CGFloat = 0.0
  //  private var animationDuration: TimeInterval = 0.7
    private var animationDuration: TimeInterval = 15.0 // increase this for slower scroll

//    self.animationDuration = Double(textWidth) / 20.0 // adjust "20.0" to control speed

    var text: String? {
        didSet {
            label.text = text
            label.sizeToFit()
            textWidth = label.frame.width
            startScrolling()
        }
    }
    
    var textColor: UIColor {
        get { return label.textColor }
        set { label.textColor = newValue }
    }
    
    var font: UIFont {
        get { return label.font }
        set { label.font = newValue }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        clipsToBounds = true
        label.frame.origin = CGPoint(x: bounds.width, y: 0)
        addSubview(label)
    }
    
    private func startScrolling() {
        label.layer.removeAllAnimations()
        
        label.frame.origin.x = bounds.width
        
        // Dynamic speed: pixels per second
        let speed: CGFloat = 30.0
        animationDuration = TimeInterval((textWidth + bounds.width) / speed)
        UIView.animate(withDuration: animationDuration, delay: 0, options: [.curveLinear, .repeat], animations: {
            self.label.frame.origin.x = -self.textWidth
        })
    }

    
//    private func startScrolling() {
//        label.layer.removeAllAnimations()
//        
//        label.frame.origin.x = bounds.width
//      //  UIView.animate(withDuration: 12.0, delay: 1, options: ([.curveLinear, .repeat]), animations: {() -> Void in
//
//        UIView.animate(withDuration: animationDuration, delay: 1, options: [.curveLinear, .repeat], animations: {
//            self.label.frame.origin.x = -self.textWidth
//        })
//    }
}

