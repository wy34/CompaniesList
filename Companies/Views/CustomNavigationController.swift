//
//  CustomNavigationController.swift
//  Companies
//
//  Created by William Yeung on 9/26/20.
//

import UIKit

class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
