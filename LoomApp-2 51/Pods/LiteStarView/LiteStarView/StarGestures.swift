//
//  StarGestures.swift
//  StarView
//
//  Created by Mitchell Tucker on 11/27/20.
//

import UIKit


extension StarView {
    // Gesture Recognizers
    @objc func starGestureTap(recognizer: UITapGestureRecognizer){
        userRating(location: recognizer.location(in: self).x)
    }
    
    @objc func starGesturePanned(recognizer: UIPanGestureRecognizer) {
        userRating(location: recognizer.location(in: self).x)
    }
    
    private func userRating(location:CGFloat){
        // Use tap location divide by view height (view height = star width) new star rating
        var fraction = Float(location / bounds.height)
        if fraction.isLess(than: 0.0) {return} // cant have a rating less then zero
        if Int(fraction) > starCount {return} // check if greater then amount of stars
        
        if Int(fraction) != Int(rating){
            hapticFeedback.impactOccurred()//commit out if hapticFeedback is not desired
        }
        
        var format = "%.1f"
        if roundRating{
            fraction = fraction.rounded()
            format = "%.0f"
        }
        
        // if greater then number set to numberOfStars
        if fraction > Float(starCount) {
            subCounter!.text = String(format:format, Float(starCount))
            // NOTE: changing the rating will also update the view
            rating = CGFloat(starCount)
        }else{
            subCounter!.text = String(format:format, fraction)
            rating = CGFloat(fraction)
        }
        
    }
}
