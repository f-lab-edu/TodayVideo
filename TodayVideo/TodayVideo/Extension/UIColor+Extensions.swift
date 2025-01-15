//
//  UIColor+Extensions.swift
//  TodayVideo
//
//  Created by iOS Dev on 1/15/25.
//

import UIKit

extension UIColor {
    // SplashView
    static let background = UIColor(hex: "#070202") ?? .black
    static let title1 = UIColor(hex: "#4AFFF3") ?? .red
    static let title2 = UIColor(hex: "#264CA5") ?? .red
    static let title3 = UIColor(hex: "#000000") ?? .black
}

extension UIColor {
    public convenience init?(hex: String) {
        let hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        guard hexFormatted.count == 6,
              let hexNumber = UInt64(hexFormatted, radix: 16) else {
            return nil
        }
        let red = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hexNumber & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
