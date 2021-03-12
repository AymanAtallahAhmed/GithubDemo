//
//  UIImageView+Extensions.swift
//  GithubDemo
//
//  Created by Ayman Ata on 3/11/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import UIKit
import RxAlamofire

extension UIImageView {
    
    private var cache: NSCache<NSString, UIImage>? {
        NSCache<NSString, UIImage>()
    }
    
    func setImageWith(url: String) {
        guard let URL = URL(string: url) else { return }
        
        let cacheKey = NSString(string: url)
        if let image = self.cache?.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        _ = data(.get, URL)
            .subscribe(onNext: { [weak self] (data) in
                if let image = UIImage(data: data) {
                    if let JbegData = image.jpegData(compressionQuality: 0.01),
                        let compressedImage = UIImage(data: JbegData) {
                        self?.cache?.setObject(compressedImage, forKey: cacheKey)
                        self?.image = compressedImage
                    }
                }
            })
    }
}
