//
//  Tabbar.swift
//  LoomApp
//
//  Created by Flucent tech on 02/04/25.
//


import UIKit

@IBDesignable class TabBarWithCorners: UITabBar {
    @IBInspectable var color: UIColor?
    @IBInspectable var radii: CGFloat = 18
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        addShape()
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = color?.cgColor ?? UIColor.white.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.shadowColor = UIColor.white.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: -2);
        shapeLayer.shadowOpacity = 0.21
        shapeLayer.shadowRadius = 8
        shapeLayer.shadowPath =  UIBezierPath(roundedRect: bounds, cornerRadius: radii).cgPath
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    private func createPath() -> CGPath {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radii, height: 0.0))
        
        return path.cgPath
    }
    
    override func layoutSubviews() {
//        let window = UIApplication.shared.currentScene?.keyWindow
//            let topPadding = window.safeAreaInsets.top
//            let bottomPadding = window.safeAreaInsets.bottom
//        
        
//        var topSafeAreaHeight: CGFloat = 0
//        var bottomSafeAreaHeight: CGFloat = 0
//
//          if #available(iOS 11.0, *) {
//            let window = UIApplication.shared.windows[0]
//            let safeFrame = window.safeAreaLayoutGuide.layoutFrame
//            topSafeAreaHeight = safeFrame.minY
//            bottomSafeAreaHeight = window.frame.maxY - safeFrame.maxY
//          }
        
        
        
        super.layoutSubviews()
        self.isTranslucent = true
        var tabFrame = self.frame
        tabFrame.size.height = 65 + 10
        tabFrame.origin.y = self.frame.origin.y + self.frame.height - 65 - 10
        self.layer.cornerRadius = 18
        self.frame = tabFrame
        self.items?.forEach({ $0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -5.0) })
    }
    
}
