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
}
