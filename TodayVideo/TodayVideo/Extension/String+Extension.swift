//
//  String+Extension.swift
//  TodayVideo
//
//  Created by iOS Dev on 1/17/25.
//

import UIKit

extension String {
    func width(size: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: size)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        return self.size(withAttributes: attributes).width
    }
    
    func height(size: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: size)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        return self.size(withAttributes: attributes).height
    }
}
