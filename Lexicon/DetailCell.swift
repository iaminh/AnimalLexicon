//
//  DetailCell.swift
//  Lexicon
//
//  Created by Minh on 12/6/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
    }
}
