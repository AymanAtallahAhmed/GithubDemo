//
//  UIHelper.swift
//  GithubDemo
//
//  Created by Ayman Ata on 3/7/21.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import UIKit


struct UIHelper {
    static func creat3ColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.frame.width  // he made it bounds instead of frame
        let padding: CGFloat = 12
        let minimumSpacing: CGFloat = 10
        let avilableWidth = width - (padding*2 + minimumSpacing*2)
        let cellWidth = avilableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth+40)
        
        return flowLayout
    }
}

