//
//  AnimalClassVC.swift
//  Lexicon
//
//  Created by Minh on 12/8/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import UIKit

class AnimalClassVC: BaseVC {
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.registerCell(AnimalClassTVCell.self)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = 120
        }
    }
    
    var datasource : [AnimalClass] = []
    let dbManager = DBManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatasource()
        
        title = "animal class".uppercased()
    }
    
    
    func configureDatasource() {
        dbManager.getAnimalClass() { [weak self] (classes) in
            mainQueue {
                self?.datasource = classes
                self?.tableView.reloadData()
            }
        }
    }
}

extension AnimalClassVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: AnimalClassTVCell.self, indexPath: indexPath)!
        cell.configureWithClass(aClass: datasource[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let id : Int =  Int(datasource[indexPath.row].id) {
            let animals = dbManager.getAnimalListWithClassID(id: id)
            let listVC = AnimalListVC.instantiate()
            listVC.datasource = animals
            navigationController?.pushViewController(listVC, animated: true)
        }
       
        
        
    }
}
