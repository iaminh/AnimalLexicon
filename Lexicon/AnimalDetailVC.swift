//
//  AnimalDetailVC.swift
//  Lexicon
//
//  Created by Minh on 12/6/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import UIKit
private enum CellType: Int {
    case LatinName
    case Food
    case Breed
    case Reproduction
    case Detail
    
    static let count = 5
}


class AnimalDetailVC: UIViewController {
    static func instantiate() -> AnimalDetailVC {
        return UIStoryboard(name: "AnimalDetail", bundle: nil).instantiateInitialViewController() as! AnimalDetailVC
    }
    
    var animal: Animal!
    
    @IBOutlet weak var imageHeaderView: UIImageView!
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 80
            tableView.registerCell(DetailCell.self)
            tableView.backgroundColor = UIColor.clear
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = animal.name
        imageHeaderView.downloadedFrom(link: animal.getImageURL())
    }

    @IBAction func searchInZooButtonTapped(_ sender: AnyObject) {
    }

}

extension AnimalDetailVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellType.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: DetailCell.self, indexPath: indexPath)!
        switch CellType(rawValue: indexPath.row)! {
        case .LatinName:
            cell.titleLabel.text = "Latinský název"
            cell.valueLabel.text = animal.latinName
        case .Food:
            cell.titleLabel.text = "Potrava"
            cell.valueLabel.text = animal.foodNote
        case .Breed:
            cell.titleLabel.text = "Chov"
            cell.valueLabel.text = animal.breeding
        case .Reproduction:
            cell.titleLabel.text = "Rozmnožování"
            cell.valueLabel.text = animal.reproduction == "" ? "Unknown" : animal.reproduction
        case .Detail:
            cell.titleLabel.text = "Zajímavosti"
            cell.valueLabel.text = animal.attractions
        }
        
        return cell
    }
    
}
