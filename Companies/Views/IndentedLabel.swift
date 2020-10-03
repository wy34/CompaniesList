//
//  IndentedLabel.swift
//  Companies
//
//  Created by William Yeung on 10/2/20.
//

import UIKit

class IndentedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let inset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        let customRect = rect.inset(by: inset)
        super.drawText(in: customRect)
    }
}
