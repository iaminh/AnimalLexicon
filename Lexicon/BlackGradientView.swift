//
//  BlackGradientView.swift
//  Lexicon
//
//  Created by Minh on 12/10/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import UIKit

class BlackGradientView: UIView {
    
    init() {
        
        super.init(frame: CGRect.zero)
        prepareGradientLayer()
    }
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        prepareGradientLayer()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        prepareGradientLayer()
    }
    
    
    func prepareGradientLayer() {
        
        backgroundColor = UIColor.clear
        layer.insertSublayer(bottomGradientLayer, at: 0)
    }
    
    
    lazy var bottomGradientLayer: CALayer = {
        
        let layer = CAGradientLayer()
        
        layer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        
        layer.startPoint = CGPoint(x: 0, y: 1)
        layer.endPoint = CGPoint(x: 0, y: 0)
        
        return layer
        
    }()
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        bottomGradientLayer.frame = bounds
    }
}
