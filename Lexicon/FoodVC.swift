//
//  FoodVCViewController.swift
//  Lexicon
//
//  Created by Minh on 12/8/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import UIKit

class FoodVC: BaseVC {
    var datasource = [
        (id: 1, animals: [Animal]()),
        (id: 2, animals: [Animal]()),
        (id: 3, animals: [Animal]()),
        (id: 4, animals: [Animal]()),
        (id: 5, animals: [Animal]()),
        (id: 6, animals: [Animal]()),
        (id: 7, animals: [Animal]()),
        (id: 8, animals: [Animal]()),
        (id: 9, animals: [Animal]()),
        ]
    
    private let dbManager = DBManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Dělení zvířat podle potravy"
        
        showActivityIndicator()
        dbManager.getFoodRelationShip {[weak self] (relations) in
            self?.configureDatasourceWithFoodRelations(relations: relations)
            self?.hideActivityIndicator()
        }
    }
    
    func configureDatasourceWithFoodRelations(relations: [FoodRelation]) {
        for (index, dataset) in datasource.enumerated() {
            // get animal ids
            let animalsID = relations.filter { $0.foodID == dataset.id }
                .map { $0.animalId }
            
            datasource[index].animals = dbManager.getAnimalListWithID(ids: animalsID)
        }
    }

    @IBAction func fruitButtonTapped(_ sender: AnyObject) {
        let listVC = AnimalListVC.instantiate()
        listVC.datasource = datasource[8].animals
        navigationController?.pushViewController(listVC, animated: true)
    }
    
    @IBAction func doubleLeafButtonTapped(_ sender: AnyObject) {
        let listVC = AnimalListVC.instantiate()
        listVC.datasource = datasource[0].animals
        navigationController?.pushViewController(listVC, animated: true)

    }
    
    @IBAction func fishButtonTapped(_ sender: AnyObject) {
        let listVC = AnimalListVC.instantiate()
        listVC.datasource = datasource[6].animals
        navigationController?.pushViewController(listVC, animated: true)

    }
    
    @IBAction func ladyBugButtonTapped(_ sender: AnyObject) {
        let listVC = AnimalListVC.instantiate()
        listVC.datasource = datasource[5].animals
        navigationController?.pushViewController(listVC, animated: true)

    }

    @IBAction func leafButtonTapped(_ sender: AnyObject) {
        let listVC = AnimalListVC.instantiate()
        listVC.datasource = datasource[8].animals
        navigationController?.pushViewController(listVC, animated: true)

    }

    @IBAction func meatButtonTapped(_ sender: AnyObject) {
        let listVC = AnimalListVC.instantiate()
        listVC.datasource = datasource[2].animals
        navigationController?.pushViewController(listVC, animated: true)

    }
    
    @IBAction func planktonButtonTapped(_ sender: AnyObject) {
        let listVC = AnimalListVC.instantiate()
        listVC.datasource = datasource[3].animals
        navigationController?.pushViewController(listVC, animated: true)

    }

    @IBAction func seedButtonTapped(_ sender: AnyObject) {
        let listVC = AnimalListVC.instantiate()
        listVC.datasource = datasource[7].animals
        navigationController?.pushViewController(listVC, animated: true)

    }
    
    @IBAction func steakButtonTapped(_ sender: AnyObject) {
        let listVC = AnimalListVC.instantiate()
        listVC.datasource = datasource[1].animals
        navigationController?.pushViewController(listVC, animated: true)

    }
    
    
}
