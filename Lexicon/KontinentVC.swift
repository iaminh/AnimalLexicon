//
//  KontinentVC.swift
//  Lexicon
//
//  Created by Minh on 12/9/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import UIKit

class KontinentVC: BaseVC {
    var datasource = [
        (id: 1, animals: [Animal](), title: "Afrika", image: #imageLiteral(resourceName: "africa")),
        (id: 2, animals: [Animal](), title: "Ásie", image: #imageLiteral(resourceName: "asia")),
        (id: 3, animals: [Animal](), title: "Jižní Amerika", image: #imageLiteral(resourceName: "south-america")),
        (id: 4, animals: [Animal](), title: "Severní Amerika", image: #imageLiteral(resourceName: "north-america")),
        (id: 5, animals: [Animal](), title: "Austrálie", image: #imageLiteral(resourceName: "australia")),
        (id: 7, animals: [Animal](), title: "Evropa", image: #imageLiteral(resourceName: "europe")),
        ]

    var continentRelationShip : [ContinentRelation] = []
    @IBOutlet weak var cvHeader: UICollectionView! {
        didSet {
            cvHeader.registerCell(ContinentTVCell.self)
            cvHeader.delegate = self
            cvHeader.dataSource = self
        }
    }
   
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerCell(AnimalListTVCell.self)
            tableView.rowHeight = 100
            tableView.dataSource = self
            tableView.delegate = self
            tableView.backgroundColor = UIColor.clear
        }
    }

    @IBOutlet weak var pageControl: UIPageControl!
    
    private let dbManager = DBManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Lexikon.Base
        
        // set initial datasource
        // with africa animals
        pageControl.numberOfPages = datasource.count
        pageControl.currentPage = 0
        
        showActivityIndicator()
        dbManager.getContinentRelationShip {[weak self] (relations) in
            
            self?.tableView.reloadData()
            self?.configureDatasourceWithContinentRelations(relations: relations)
            self?.hideActivityIndicator()
        }
    }
    
    func configureDatasourceWithContinentRelations(relations: [ContinentRelation]) {
        for (index, dataset) in datasource.enumerated() {
            // get animal ids
            let animalsID = relations.filter { $0.continentID == dataset.id }
                .map { $0.animalId }
            
            datasource[index].animals = dbManager.getAnimalListWithID(ids: animalsID)
        }
    }
}

extension KontinentVC : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource[pageControl.currentPage].animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: AnimalListTVCell.self, indexPath: indexPath)!
        cell.loadWithAnimal(animal: datasource[pageControl.currentPage].animals[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = AnimalDetailVC.instantiate()
        detailVC.animal = datasource[pageControl.currentPage].animals[indexPath.row]
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension KontinentVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: ContinentTVCell.self, indexPath: indexPath)!
        cell.mainImageView.image = datasource[indexPath.row].image
        cell.titleLabel.text = datasource[indexPath.row].title

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cvHeader.bounds.size
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == cvHeader else {
            return
        }
        
        let x = cvHeader.contentOffset.x
        let w = cvHeader.bounds.size.width
        let currentPage = Int(ceil(x/w))
        
        if currentPage != pageControl.currentPage {
            pageControl.currentPage = currentPage
            tableView.reloadData()
            
//            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
}
