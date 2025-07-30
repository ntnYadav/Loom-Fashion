//
//  LMGlobal.swift
//  LoomApp
//
//  Created by Flucent tech on 09/05/25.
//

import UIKit

class LMGlobal {
    static let shared = LMGlobal()

    private init() {
        // Private to prevent direct initialization
        print("Singleton Initialized")
    }

    func removeDecimal(from number: Double) -> String {
        return String(Int(number))
    }
    func doSomething() {
        print("Doing something...")
    }
    // Convert color string to UIColor
    
    func colorFromString(_ value: String) -> UIColor {
//
//        static func from(name: String) -> UIColor {
            switch value.lowercased() {
            // Basic Colors
            case "black": return .black
            case "white": return .white
            case "red": return .red
            case "green": return .green
            case "blue": return .blue
            case "yellow": return .yellow
            case "orange": return .orange
            case "purple": return .purple
            case "brown": return .brown
            case "gray", "grey": return .gray
            case "lightgray": return .lightGray
            case "darkgray": return .darkGray
            case "clear": return .clear
            case "cyan": return .cyan
            case "magenta": return .magenta

            // System Colors
            case "systemred": return .systemRed
            case "systemgreen": return .systemGreen
            case "systemblue": return .systemBlue
            case "systemorange": return .systemOrange
            case "systemyellow": return .systemYellow
            case "systempink": return .systemPink
            case "systempurple": return .systemPurple
            case "systemteal": return .systemTeal
            case "systemindigo": return .systemIndigo
            case "systemgray": return .systemGray

            // Shades
            case "lightred": return UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 1.0)
            case "darkred": return UIColor(red: 0.5, green: 0.0, blue: 0.0, alpha: 1.0)
            case "lightgreen": return UIColor(red: 0.7, green: 1.0, blue: 0.7, alpha: 1.0)
            case "darkgreen": return UIColor(red: 0.0, green: 0.4, blue: 0.0, alpha: 1.0)
            case "lightblue": return UIColor(red: 0.68, green: 0.85, blue: 0.9, alpha: 1.0)
            case "darkblue": return UIColor(red: 0.0, green: 0.0, blue: 0.5, alpha: 1.0)

            // Fashion Colors
            case "terracotta": return UIColor(red: 0.89, green: 0.45, blue: 0.36, alpha: 1.0)     // #E2725B
            case "rust": return UIColor(red: 0.72, green: 0.25, blue: 0.05, alpha: 1.0)           // #B7410E
            case "mustard", "mustard yellow": return UIColor(red: 1.0, green: 0.86, blue: 0.35, alpha: 1.0) // #FFDB58
            case "olive", "olive green": return UIColor(red: 0.44, green: 0.51, blue: 0.22, alpha: 1.0)     // #708238
            case "sage", "sage green": return UIColor(red: 0.70, green: 0.67, blue: 0.53, alpha: 1.0)       // #B2AC88
            case "navy", "navy blue": return UIColor(red: 0.10, green: 0.14, blue: 0.49, alpha: 1.0)        // #1A237E
            case "ice blue": return UIColor(red: 0.84, green: 0.94, blue: 1.0, alpha: 1.0)                  // #D7EFFF
            case "mint", "mint green": return UIColor(red: 0.60, green: 1.0, blue: 0.60, alpha: 1.0)        // #98FF98
            case "teal": return UIColor(red: 0.0, green: 0.5, blue: 0.5, alpha: 1.0)                        // #008080
            case "lavender": return UIColor(red: 0.71, green: 0.49, blue: 0.86, alpha: 1.0)                 // #B57EDC
            case "coral": return UIColor(red: 1.0, green: 0.44, blue: 0.38, alpha: 1.0)                     // #FF6F61
            case "emerald", "emerald green": return UIColor(red: 0.31, green: 0.78, blue: 0.47, alpha: 1.0) // #50C878
            case "royal blue": return UIColor(red: 0.25, green: 0.41, blue: 0.88, alpha: 1.0)               // #4169E1
            case "bright yellow": return UIColor(red: 1.0, green: 0.92, blue: 0.23, alpha: 1.0)             // #FFEB3B

            // Default
            default: return .black
            }
        }
    

    
//    func colorFromString(_ value: String) -> UIColor {
//        let lower = value.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
//        
//        switch lower {
//         
//                    // Basic Colors
//                    case "black": return .black
//                    case "white": return .white
//                    case "red": return .red
//                    case "green": return .green
//                    case "blue": return .blue
//                    case "yellow": return .yellow
//                    case "orange": return .orange
//                    case "purple": return .purple
//                    case "brown": return .brown
//                    case "gray", "grey": return .gray
//                    case "lightgray", "light grey": return .lightGray
//                    case "darkgray", "dark grey": return .darkGray
//                    case "cyan": return .cyan
//                    case "magenta": return .magenta
//                    case "clear": return .clear
//
//                    // System Colors
//                    case "systemred"   : return .systemRed
//                    case "systemgreen" : return .systemGreen
//                    case "systemblue"  : return .systemBlue
//                    case "systemorange": return .systemOrange
//                    case "systemyellow": return .systemYellow
//                    case "systempink"  : return .systemPink
//                    case "systempurple": return .systemPurple
//                    case "systemteal"  : return .systemTeal
//                    case "systemindigo": return .systemIndigo
//                    case "systemgray"  : return .systemGray
//
//                    // Extra Web-like Colors
//                    case "gold"     : return UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
//                    case "silver"   : return UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
//                    case "beige"    : return UIColor(red: 0.96, green: 0.96, blue: 0.86, alpha: 1.0)
//                    case "ivory"    : return UIColor(red: 1.0, green: 1.0, blue: 0.94, alpha: 1.0)
//                    case "navy"     : return UIColor(red: 0.0, green: 0.0, blue: 0.5, alpha: 1.0)
//                    case "maroon"   : return UIColor(red: 0.5, green: 0.0, blue: 0.0, alpha: 1.0)
//                    case "olive"    : return UIColor(red: 0.5, green: 0.5, blue: 0.0, alpha: 1.0)
//                    case "lime"     : return UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
//                    case "aqua"     : return UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
//                    case "teal"     : return UIColor(red: 0.0, green: 0.5, blue: 0.5, alpha: 1.0)
//                    case "coral"    : return UIColor(red: 1.0, green: 0.5, blue: 0.31, alpha: 1.0)
//                    case "salmon"   : return UIColor(red: 0.98, green: 0.5, blue: 0.45, alpha: 1.0)
//                    case "chocolate": return UIColor(red: 0.82, green: 0.41, blue: 0.12, alpha: 1.0)
//                    case "plum"     : return UIColor(red: 0.87, green: 0.63, blue: 0.87, alpha: 1.0)
//                    case "crimson"  : return UIColor(red: 0.86, green: 0.08, blue: 0.24, alpha: 1.0)
//                    case "indigo"   : return UIColor(red: 0.29, green: 0.0, blue: 0.51, alpha: 1.0)
//        default:
//            return colorFromHexString(lower) ?? .lightGray
//        }
//    }

    
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
    func formatDateString(_ isoDate: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        if let date = isoFormatter.date(from: isoDate) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "dd MMM yyyy, hh:mm a"
            displayFormatter.timeZone = TimeZone.current // Use device timezone
            return displayFormatter.string(from: date)
        }
        return isoDate // Fallback to original if parsing fails
    }
    // MARK: - Header Titles
    func createPriceAttributedTextWithout(discountPercent: Int, originalPrice: Double, discountedPrice: Double) -> NSAttributedString {
        let attributedText = NSMutableAttributedString()

        // Discount arrow + percentage
//        let discountString = "↓ \(discountPercent)% "
//        let discountAttributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.systemGreen,
//            .font: UIFont(name: ConstantFontSize.regular, size: 13)
//        ]
//        attributedText.append(NSAttributedString(string: discountString, attributes: discountAttributes))

        // Original price with strikethrough
//        let originalPriceString = "₹\(Int(originalPrice))"
//        let originalPriceAttributes: [NSAttributedString.Key: Any] = [
//            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
//            .foregroundColor: UIColor.gray,
//            .font: UIFont(name: ConstantFontSize.regular, size: 14)
//        ]
//        attributedText.append(NSAttributedString(string: originalPriceString, attributes: originalPriceAttributes))

        // Discounted price
        let discountedPriceString = " ₹\(Int(discountedPrice))"
        let discountedPriceAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: ConstantFontSize.Semibold, size: 14)
        ]
        attributedText.append(NSAttributedString(string: discountedPriceString, attributes: discountedPriceAttributes))

        return attributedText
    }
    
    func createPriceAttributedText(discountPercent: Int, originalPrice: Double, discountedPrice: Double) -> NSAttributedString {
        let attributedText = NSMutableAttributedString()

        // Discount arrow + percentage
    //        let discountString = "↓ \(discountPercent)% "
    //        let discountAttributes: [NSAttributedString.Key: Any] = [
    //            .foregroundColor: UIColor.systemGreen,
    //            .font: UIFont(name: ConstantFontSize.regular, size: 13)
    //        ]
    //        attributedText.append(NSAttributedString(string: discountString, attributes: discountAttributes))

        // Original price with strikethrough
        let originalPriceString = "₹\(Int(originalPrice))"
        let originalPriceAttributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.gray,
            .font: UIFont(name: ConstantFontSize.regular, size: 14)
        ]
        attributedText.append(NSAttributedString(string: originalPriceString, attributes: originalPriceAttributes))

        // Discounted price
        let discountedPriceString = " ₹\(Int(discountedPrice))"
        let discountedPriceAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: ConstantFontSize.Semibold, size: 14)
        ]
        attributedText.append(NSAttributedString(string: discountedPriceString, attributes: discountedPriceAttributes))

        return attributedText
    }

}
