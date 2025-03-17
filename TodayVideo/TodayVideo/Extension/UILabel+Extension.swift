//
//  UILabel+Extension.swift
//  TodayVideo
//
//  Created by iOS Dev on 3/17/25.
//

import UIKit

extension UILabel {
    func height() -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: .greatestFiniteMagnitude))
        label.numberOfLines = self.numberOfLines
        label.lineBreakMode = self.lineBreakMode
        label.font = self.font
        label.textAlignment = self.textAlignment
        label.attributedText = self.attributedText
        label.sizeToFit()
        return label.frame.height
    }
}
