//
//  AppColors.swift
//  birthdayReminder
//

import UIKit

struct AppColors {
    
    // NEW 4-COLOR PALETTE HIERARCHY (From highest proportion to lowest)
    // 1. #FBF5DD (Warm Cream / Soft Gold Tint - MOST DOMINANT BACKGROUND)
    static let warmCream = UIColor(hex: "#FBF5DD")
    
    // 2. #E7E1B1 (Pastel Warm Sand - Secondary Backgrounds, Chip Fills, Soft Borders)
    static let pastelSand = UIColor(hex: "#E7E1B1")
    
    // 3. #306D29 (Rich Leaf Green - Primary CTAs, Buttons, Active Highlights)
    static let richLeafGreen = UIColor(hex: "#306D29")
    
    // 4. #0D530E (Deep Forest Dark Green - Main Headers, Title Typography, High Contrast)
    static let deepForestDarkGreen = UIColor(hex: "#0D530E")
    
    // Semantic Mapping for UI Consistency
    static let background = warmCream
    static let cardBackground = UIColor.white
    static let primaryText = deepForestDarkGreen
    static let secondaryText = deepForestDarkGreen.withAlphaComponent(0.75)
    static let primaryButton = richLeafGreen
    static let accentBorder = pastelSand
    
    // Days Remaining High-Saturation Status Colors
    static let statusUrgent = UIColor(hex: "#E53935") // Red for 0-7 days
    static let statusSoon = UIColor(hex: "#FB8C00")   // Orange for 8-30 days
    static let statusMedium = deepForestDarkGreen      // Deep Forest for 31-90 days
    static let statusFar = richLeafGreen              // Rich Leaf Green for 91+ days
}

// MARK: - UIColor Hex Helper
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

// MARK: - Sans-Serif Font Family Extension
extension UIFont {
    static func sansSerif(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
}
