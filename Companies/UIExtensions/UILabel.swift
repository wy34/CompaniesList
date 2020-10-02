//
//  UILabel.swift
//  Companies
//
//  Created by William Yeung on 10/1/20.
//

import UIKit

extension UILabel {
    static func createBasicLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        return label
    }
}
