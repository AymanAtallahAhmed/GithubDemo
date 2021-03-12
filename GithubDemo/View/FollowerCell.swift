//
//  FollowerCell.swift
//  GithubDemo
//
//  Created by Ayman Ata on 3/6/21.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
 
    static let reuseID = "FollowerCellId"
    
    var follower: Follower? {
        didSet {
            avatarImageView.image = #imageLiteral(resourceName: "gh-logo")
            usernameLabel.text = follower?.login
            avatarImageView.setImageWith(url: follower?.avatar_url ?? "")
        }
    }
    
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
        
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "gh-logo")
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        _ = [avatarImageView, usernameLabel].map { addSubview($0) }
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
        
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
