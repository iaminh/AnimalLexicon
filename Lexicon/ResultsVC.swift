//
//  ResultsVC.swift
//  Lexicon
//
//  Created by Minh on 12/13/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import UIKit

class ResultsVC: UIViewController {
    var didSelectAction: ((_ animal: Animal) -> Void)?
    var filteredAnimals: [Animal] = []
    
    static func instantiate() -> ResultsVC {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultsVC") as! ResultsVC
    }

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.rowHeight = 80
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerCell(AnimalListTVCell.self)
            tableView.backgroundColor = UIColor.Lexikon.Orange
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extendedLayoutIncludesOpaqueBars = false
        edgesForExtendedLayout = UIRectEdge()
    }
}

extension ResultsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAnimals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: AnimalListTVCell.self, indexPath: indexPath)!
        cell.loadWithAnimal(animal: filteredAnimals[indexPath.row])
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectAction?(filteredAnimals[indexPath.row])
    }
}
