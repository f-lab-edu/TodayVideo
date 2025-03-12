//
//  UIScrollView+Extension.swift
//  TodayVideo
//
//  Created by iOS Dev on 3/12/25.
//

import UIKit

// 출처: https://stackoverflow.com/questions/12005187/ios-changing-uiscrollview-scrollbar-color-to-different-colors
extension UIScrollView {
    var scrollIndicators: (horizontal: UIView?, vertical: UIView?) {
        guard self.subviews.count >= 2 else {
            return (horizontal: nil, vertical: nil)
        }

        func viewCanBeScrollIndicator(view: UIView) -> Bool {
            let viewClassName = NSStringFromClass(type(of: view))
            if viewClassName == "_UIScrollViewScrollIndicator" || viewClassName == "UIImageView" {
                return true
            }
            return false
        }

        let horizontalScrollViewIndicatorPosition = self.subviews.count - 2
        let verticalScrollViewIndicatorPosition = self.subviews.count - 1

        var horizontalScrollIndicator: UIView?
        var verticalScrollIndicator: UIView?

        let viewForHorizontalScrollViewIndicator = self.subviews[horizontalScrollViewIndicatorPosition]
        if viewCanBeScrollIndicator(view: viewForHorizontalScrollViewIndicator) {
            horizontalScrollIndicator = viewForHorizontalScrollViewIndicator.subviews[0]
        }

        let viewForVerticalScrollViewIndicator = self.subviews[verticalScrollViewIndicatorPosition]
        if viewCanBeScrollIndicator(view: viewForVerticalScrollViewIndicator) {
            verticalScrollIndicator = viewForVerticalScrollViewIndicator.subviews[0]
        }
        
        return (horizontal: horizontalScrollIndicator, vertical: verticalScrollIndicator)
    }
}
