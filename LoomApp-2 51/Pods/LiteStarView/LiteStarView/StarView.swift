//
//  StarView.swift
//  RecipesCanDo
//
//  Created by Mitchell Tucker on 11/18/20.
//  Copyright © 2020 Tucker. All rights reserved.
//

import UIKit

public class StarView:UIView, UIGestureRecognizerDelegate {
    
    // MARK: Modifiers
    // Total number of stars
    @IBInspectable var starCount : Int = 5
    @IBInspectable public var ratingCount : Int = 0 {
        didSet {
            if clipStarView != nil {
                // Only need to update the label
                subCounter!.text = ""
                updateStar()
            }
        }
    }
    @IBInspectable public var rating : CGFloat = 0.0 {
        didSet {
            if clipStarView != nil {
                // Update the stars to new rating
                updateStar()
            }
        }
    }
    // Round rating
    @IBInspectable var roundRating:Bool = false
    // Star colors
    @IBInspectable var fillColor: UIColor = UIColor.systemYellow
    @IBInspectable var strokeColor: UIColor = UIColor.black
    

    // Increments center points between stars DONT MOD
    private var dynamicWidth:CGFloat = 0.0

    // MARK: Sub Views & Layers
    // Layers for each star
    private var starLayers:[CAShapeLayer] = []
    // Clips the star for float ratings
    private var clipStarView:UIView?
    // Layer used for clipping
    private var clipLayer:CAShapeLayer?
    // Label for number
    var subCounter:UILabel?
    
    // Haptic feedback
    lazy var hapticFeedback: UIImpactFeedbackGenerator = {
        return UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.medium)
    }()

    // MARK: Gestures
    private lazy var tapGesture: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(starGestureTap(recognizer:)))
        recognizer.delegate = self
        return recognizer
    }()
    
    private lazy var panGesture: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(starGesturePanned(recognizer:)))
        recognizer.delegate = self
        return recognizer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        // clean up before deinit
        removeGestureRecognizer(tapGesture)
        removeGestureRecognizer(panGesture)
    }
    
    // MARK: draw
    public override func draw(_ rect: CGRect) {
        if clipStarView == nil { // Check if star has been drawn
            drawStar()
        }
        // Update star with IBInspectable varables
        updateStar()
        // add gestureRecognizer
        self.addGestureRecognizer(panGesture)
        self.addGestureRecognizer(tapGesture)
    }
    
    // MARK: drawStar
    // Creates, draws sub views and layers
    // NOTE: Only called once from draw
    private func drawStar() {

        dynamicWidth = frame.height / 2
        
        for _ in 0...starCount - 1 {
            let emtpyLayer = CAShapeLayer()
            
            // Get UIBeziserPath of star
            let star = starBezier(superView: self,x: dynamicWidth)
            
            // Create empty star
            emtpyLayer.path = star.cgPath
            emtpyLayer.fillColor = UIColor.clear.cgColor // keep clear color
            emtpyLayer.lineWidth = 0.5
            emtpyLayer.strokeColor = strokeColor.cgColor
            self.layer.addSublayer(emtpyLayer)
            starLayers.append(emtpyLayer)
            
            // Keep are stars spaceout
            dynamicWidth += (bounds.height)
        }
        
        // Check read me for more info about clipping stars
        let startingRect = CGRect(x: bounds.height / 2, y: bounds.minY, width: 0, height: bounds.height) // just used for init
        clipStarView = UIView(frame: startingRect) // Clipped stars
        clipStarView!.backgroundColor = .clear // must be clear
        clipStarView!.clipsToBounds = true // must be true for layers to be clipped
        
        // create new starBezier
        let newStar = starBezier(superView: self,x: clipStarView!.bounds.height / 2)
        
        // CA layer for clip star View
        clipLayer = CAShapeLayer()
        clipLayer!.path = newStar.cgPath
        clipLayer!.strokeColor = strokeColor.cgColor
        clipLayer!.fillColor = fillColor.cgColor
        clipLayer!.lineWidth = 0.5
        clipStarView!.layer.addSublayer(clipLayer!)
        self.addSubview(clipStarView!)
        
        // Create a label for ratingCounter or rating
        subCounter = UILabel(frame: CGRect(x: dynamicWidth - (bounds.height / 2), y: bounds.minY, width: bounds.height * 2, height: bounds.height))
        subCounter!.text = ""
        if isUserInteractionEnabled && !roundRating {
            subCounter!.text = ""
        }
        subCounter!.textColor = strokeColor
        subCounter!.textAlignment = .center
        subCounter!.font = subCounter!.font.withSize(12)
        subCounter!.adjustsFontSizeToFitWidth = true
        subCounter!.adjustsFontForContentSizeCategory = true
        subCounter!.baselineAdjustment = .alignCenters
        self.addSubview(subCounter!)
    }
    
    // MARK: updateStar
    // Updates sub layers and views
    public func updateStar() {
        if clipStarView == nil {return} // check if view has been drawn
        clipStarView!.isHidden = true // keep hidden until we need it
        
        // Check README for more info on dynamicWidth
        dynamicWidth = bounds.height / 2
        var wholeStars = Int(rating) // Full(Whole Number) stars count
        var remainder = rating - CGFloat(wholeStars) // Remainder of stars as CGFloat
        
        // Loop for each star
        for index in 0...starCount - 1{
            let emtpyLayer = starLayers[index]
            
            // Create empty star
            emtpyLayer.fillColor = UIColor.clear.cgColor
        
            // Check for whole numbers(stars)
            if wholeStars != 0 {
                emtpyLayer.fillColor = fillColor.cgColor // add fill color to make star whole
                wholeStars -= 1
                
            // Check for remainder
            } else if remainder != 0.0 {
                clipStarView!.isHidden = false
                
                // Use for star dimensions
                let star = starBezier(superView: self,x: dynamicWidth)
                
                // Calculate percent remainder from width
                // This is also the amount the star is clipped
                let width = star.bounds.width * remainder
                
                // Create new bounds for clipView
                let rect = CGRect(x: dynamicWidth - (bounds.height / 2), y: star.bounds.minY, width: width, height: bounds.height)
                clipStarView!.frame =  rect
                
                // Create starLayer use for clipping
                let newStar = starBezier(superView: self,x: (bounds.height / 2))
                clipLayer!.path = newStar.cgPath
                
                // Subtract remainder (should only run once after whole stars)
                remainder -= remainder
            }
            // Keep stars spaceout
            dynamicWidth += (frame.height)
        }
    }
}


