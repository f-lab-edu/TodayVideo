//
//  UIAlertController+Extension.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/21/25.
//

import UIKit

extension UIAlertController {
    func fail(error: Error, target: UIViewController) {
        let alert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { action in
            alert.dismiss(animated: true)
        }
        alert.addAction(ok)
        target.present(alert, animated: true)
    }
}
