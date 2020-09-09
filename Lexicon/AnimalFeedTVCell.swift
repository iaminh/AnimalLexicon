//
//  AnimalFeedTVCell.swift
//  Lexicon
//
//  Created by Minh on 12/4/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import UIKit

class AnimalFeedTVCell: UITableViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gradientView: BlackGradientView!
    
    @IBOutlet weak var latinNameLabel: UILabel!
    @IBOutlet weak var latinNameValueLabel: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var foodValueLabel: UILabel!
    @IBOutlet weak var attractionLabel: UILabel!
    @IBOutlet weak var attractionValueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
    }
    
    override func prepareForReuse() {
        mainImageView.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureWithAnimal(animal: Animal) {
        latinNameValueLabel.text = animal.latinName
        nameLabel.text = animal.name
        foodValueLabel.text = animal.foodNote
        
        do {
            let regex =  "<[^>]+>"
            let expr = try NSRegularExpression(pattern: regex, options: NSRegularExpression.Options.caseInsensitive)
            let replacement = expr.stringByReplacingMatches(in: animal.attractions, options: [], range: NSMakeRange(0, animal.attractions.count), withTemplate: "")
            //replacement is the result
            
            attractionValueLabel.text = replacement

        } catch {
            _ = log.error("Bad regex",error: nil)
        }
        
        let urlString = animal.getImageURL()
        _ = log.message("---\(urlString)------")
        mainImageView.downloadedFrom(link: urlString)

        
       
    }
}
