//
//  Global.swift
//  Fonts
//
//  Created by Huzaifa Ameen on 12/06/2021.
//

import Foundation
import UIKit

func textX(_ key: String) -> CGFloat {
    var size = THconstant.size[key] ?? 17
    size = size * THconstant.scaleFactorWidth
    return size
}
// Convert color string to UIColor
func colorFromString(_ value: String) -> UIColor {
    let lower = value.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    
    switch lower {
    case "Black": return .black
    case "black": return .black
    case "White": return .white
    case "white": return .white
    case "Blue": return .blue
    case "blue": return .blue
    case "red": return .red
    case "green": return .green
    case "yellow": return .yellow
    case "gray", "grey": return .gray
    case "purple": return .purple
    case "orange": return .orange
    case "brown": return .brown
    case "clear": return .clear
    default:
        return colorFromHexString(lower) ?? .lightGray
    }
}

// Convert hex string to UIColor
func colorFromHexString(_ hex: String) -> UIColor? {
    var hex = hex.replacingOccurrences(of: "#", with: "").replacingOccurrences(of: "0x", with: "")
    guard hex.count == 6 || hex.count == 8 else { return nil }
    var rgb: UInt64 = 0
    Scanner(string: hex).scanHexInt64(&rgb)

    if hex.count == 6 {
        return UIColor(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    } else {
        return UIColor(
            red: CGFloat((rgb & 0xFF000000) >> 24) / 255.0,
            green: CGFloat((rgb & 0x00FF0000) >> 16) / 255.0,
            blue: CGFloat((rgb & 0x0000FF00) >> 8) / 255.0,
            alpha: CGFloat(rgb & 0x000000FF) / 255.0
        )
    }
}

// Convert UIColor to Hex String
func hexStringFromColor(_ color: UIColor) -> String {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0

    color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

    let r = Int(red * 255)
    let g = Int(green * 255)
    let b = Int(blue * 255)

    return String(format: "#%02X%02X%02X", r, g, b)
}
func stringToFormattedDouble(_ value: String?, symbol: String = "₹", decimalPlaces: Int = 2) -> String {
    guard let stringValue = value,
          let doubleValue = Double(stringValue) else {
        return "\(symbol)0.\(String(repeating: "0", count: decimalPlaces))"
    }
    return String(format: "\(symbol)%.\(decimalPlaces)f", doubleValue)
}
