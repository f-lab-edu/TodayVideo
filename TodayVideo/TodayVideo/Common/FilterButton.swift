//
//  FilterButton.swift
//  TodayVideo
//
//  Created by iOS Dev on 1/16/25.
//

import UIKit

final class FilterButton: UIButton {
    let height: CGFloat = 50.0
    private let leftRightMargin: CGFloat = 60.0
    private let fontSize: CGFloat = 17
    private let height: CGFloat = 50.0
    private let leftRightMargin: CGFloat = 70.0
    private var title = ""
    
    init(title: String) {
        super.init(frame: .zero)
        
        self.title = title
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: fontSize)
        self.layer.cornerRadius = height / 2
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func width() -> CGFloat {
        let titleWidth = title.width(size: fontSize)
        let titleWidth = title.width(size: 20)
        return titleWidth + leftRightMargin
    }
    
    func updateState() {
        if isSelected {
            changeColor(title: .buttonSelectedText, background: .buttonSelectedBackground)
        } else {
            changeColor(title: .buttonDefaultText, background: .buttonDefaultBackground)
        }
    }
    
    private func changeColor(title: UIColor, background: UIColor) {
        self.setTitleColor(title, for: .normal)
        self.backgroundColor = background
    }
}
