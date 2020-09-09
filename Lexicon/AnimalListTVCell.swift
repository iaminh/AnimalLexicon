//
//  AnimalListTVCell.swift
//  Lexicon
//
//  Created by Minh on 12/11/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import UIKit
class RoundedImageView : UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.height/2
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2.0
    }
}


class AnimalListTVCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var latinNameLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    
    
    override func prepareForReuse() {
        mainImageView.image = nil
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
    }

    func loadWithAnimal(animal: Animal) {
        latinNameLabel.text = animal.latinName
        nameLabel.text = animal.name
        
        let urlString = animal.getImageURL()
        mainImageView.downloadedFrom(link: urlString)
    }

}
