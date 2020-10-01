//
//  CreateCompanyController+UIImagePickerController.swift
//  Companies
//
//  Created by William Yeung on 9/30/20.
//

import UIKit

extension CreateCompanyController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        profileImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}
