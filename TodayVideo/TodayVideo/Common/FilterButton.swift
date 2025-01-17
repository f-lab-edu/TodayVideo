//
//  FilterButton.swift
//  TodayVideo
//
//  Created by iOS Dev on 1/16/25.
//

import UIKit

class FilterButton: UIButton {
    let height = 50.0
    var title = ""
    
    init(title: String) {
        super.init(frame: .zero)
        
        self.title = title
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = height / 2
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func width() -> CGFloat {
        let titleWidth = title.width(size: 20)
        let leftRightMargin = 70.0
        return titleWidth + leftRightMargin
    }
    
    func updateState() {
        if isSelected {
            self.setTitleColor(.buttonSelectedText, for: .normal)
            self.backgroundColor = .buttonSelectedBackground
        } else {
            self.setTitleColor(.buttonDefaultText, for: .normal)
            self.backgroundColor = .buttonDefaultBackground
        }
    }
}
