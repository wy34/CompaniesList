//
//  UIView.swift
//  Companies
//
//  Created by William Yeung on 9/26/20.
//

import UIKit

extension UIViewController {
    func setupNavBarStyle(withTitle title: String) {
        let newAppearance = UINavigationBarAppearance()
        newAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        newAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        newAppearance.backgroundColor = .lightRed

        navigationController?.navigationBar.scrollEdgeAppearance = newAppearance
        navigationController?.navigationBar.standardAppearance = newAppearance
        navigationController?.navigationBar.compactAppearance = newAppearance
        
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
    }
    
    func setupAddButtonInNavBar(withSelector selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: selector)
    }
    
    func setupSaveButtonInNavBar(withSelector selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: selector)
    }
    
    func setupCancleButtonInNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupNameBackgroundView(withHeightMultipleOf mult: CGFloat) -> UIView {
        let nameBackgroundView = UIView()
        nameBackgroundView.backgroundColor = .lightBlue
        
        view.addSubview(nameBackgroundView)
        nameBackgroundView.anchor(top: view.topAnchor, right: view.rightAnchor, left: view.leftAnchor)
        nameBackgroundView.setDimension(height: view.heightAnchor, hMult: mult)
        
        return nameBackgroundView
    }
}
