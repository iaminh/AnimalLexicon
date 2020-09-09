//
//  AnimalClassTVCell.swift
//  Lexicon
//
//  Created by Minh on 12/8/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import UIKit

class AnimalClassTVCell: UITableViewCell {
    @IBOutlet weak var alphabetTitle: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWithClass(aClass: AnimalClass) {
        guard let firstChar = aClass.title.first else {
            return
        }
        descriptionLabel.text = aClass.title
        
        alphabetTitle.text = String(firstChar)

        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.computeColorFromInt(int: Int(aClass.id) ?? 1, alpha: 0.5)
    }
    
}
