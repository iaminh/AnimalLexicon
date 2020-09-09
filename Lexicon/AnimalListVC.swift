//
//  AnimalListVC.swift
//  Lexicon
//
//  Created by Minh on 12/9/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import UIKit
class AnimalListVC: UIViewController {
    var datasource : [Animal] = []
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.registerCell(AnimalListTVCell.self)
            tableView.rowHeight = 100
            tableView.dataSource = self
            tableView.delegate = self
            tableView.backgroundColor = UIColor.clear
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.Lexikon.Base
    }
    
    static func instantiate() -> AnimalListVC {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AnimalListVC") as! AnimalListVC
    }
}


extension AnimalListVC : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: AnimalListTVCell.self, indexPath: indexPath)!
        cell.loadWithAnimal(animal: datasource[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = AnimalDetailVC.instantiate()
        detailVC.animal = datasource[indexPath.row]
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
