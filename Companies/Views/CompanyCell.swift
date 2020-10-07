//
//  CompanyCell.swift
//  Companies
//
//  Created by William Yeung on 9/30/20.
//

import UIKit

class CompanyCell: UITableViewCell {
    // MARK: - Properties
    static let reuseId = "CompanyCell"
    
    var company: Company? {
        didSet {
            guard let company = company else { return }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            let foundedDateString = dateFormatter.string(from: company.founded ?? Date())

            nameDateLabel.text = "\(company.name ?? "") - Founded \(foundedDateString)"

            if let imageData = company.image {
                profileImageView.image = UIImage(data: imageData)
            } else {
                profileImageView.image = #imageLiteral(resourceName: "select")
            }
        }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "select"))
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = (UIScreen.main.bounds.width * 0.1) / 2
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.darkBlue.cgColor
        iv.clipsToBounds = true
        return iv
    }()
    
    private let nameDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Apple - Founded: Oct 27, 2017"
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configCell() {
        backgroundColor = .tealColor
        
        addSubviews(profileImageView, nameDateLabel)
        
        profileImageView.center(to: self, by: .centerY)
        profileImageView.center(to: self, by: .centerX, withMultiplierOf: 0.2)
        profileImageView.setDimension(width: widthAnchor, height: widthAnchor, wMult: 0.1, hMult: 0.1)
        
        nameDateLabel.center(to: profileImageView, by: .centerY)
        nameDateLabel.anchor(right: rightAnchor, left: profileImageView.rightAnchor, paddingRight: 10, paddingLeft: 10)
    }
}
