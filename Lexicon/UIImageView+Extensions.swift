//
//  UIImageView+Extensions.swift
//  Lexicon
//
//  Created by Minh on 12/13/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        self.layer.masksToBounds = true
        contentMode = mode

        self.sd_setImage(with: url, placeholderImage:#imageLiteral(resourceName: "placeholder"))

    }
    func downloadedFrom(link: String?, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        
        guard let link = link, let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

extension UIImage {
    
    func colorized(color : UIColor) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            context.setBlendMode(.multiply)
            context.translateBy(x: 0, y: self.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.draw(self.cgImage!, in: rect)
            context.clip(to: rect, mask: self.cgImage!)
            context.setFillColor(color.cgColor)
            context.fill(rect)
        }
        
        let colorizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return colorizedImage!
        
    }
}
