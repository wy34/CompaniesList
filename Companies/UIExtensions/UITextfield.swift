//
//  UITextfield.swift
//  Companies
//
//  Created by William Yeung on 10/1/20.
//

import UIKit

extension UITextField {
    static func createBasicTextField(withPlaceholder ph: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = ph
        return tf
    }
}
