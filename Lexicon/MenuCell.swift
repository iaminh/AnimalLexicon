//
//  MenuCell.swift
//  Movez
//
//  Created by Minh on 8/29/16.
//  Copyright © 2016 Movez. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    @IBOutlet weak var iconView: UIImageView! {
        didSet {
            iconView.tintColor = UIColor.white
        }
    }

    @IBOutlet var constructionIconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        if selected {
            self.titleLabel.textColor = UIColor.Lexikon.Base
            iconView.tintColor = UIColor.Lexikon.Base
        }
        else {
            self.titleLabel.textColor = UIColor.white
            iconView.tintColor = UIColor.white
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.titleLabel.textColor = UIColor.Lexikon.Base
            iconView.tintColor = UIColor.Lexikon.Base
        }
        else {
            self.titleLabel.textColor = UIColor.white
            iconView.tintColor = UIColor.white

        }
    }
    
    func loadItem(_ item: MenuItem) {
        iconView.image = UIImage(named: item.iconName)!.withRenderingMode(.alwaysTemplate)
        titleLabel.text = item.title
    }
    
}
