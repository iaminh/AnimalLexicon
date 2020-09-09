//
//  DashboardVC.swift
//  Lexicon
//
//  Created by Minh on 11/8/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import UIKit
import RealmSwift

class DashboardVC: BaseTableVC {
    let searchResultsVC = ResultsVC.instantiate()
    
    var searchController: UISearchController!
    var datasource: [Animal] = []
    var dbManager : DBManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extendedLayoutIncludesOpaqueBars = true

        title = "Seznam všech zvířat"
        tableView.backgroundColor = UIColor.clear
        view.backgroundColor = UIColor.clear
        configureDatasource()
        configureSearchBar()
        
        
        definesPresentationContext = true
    }

    func configureSearchBar() {
        searchController = UISearchController(searchResultsController: searchResultsVC)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.barTintColor = UIColor.Lexikon.Orange
        searchController.searchBar.backgroundColor = UIColor.Lexikon.Orange
        searchController.searchBar.tintColor = UIColor.white
        
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor.white
        textFieldInsideSearchBarLabel?.text = "Hledat"
        
        tableView.tableHeaderView = searchController.searchBar
        searchResultsVC.didSelectAction = { [weak self] (animal) in
            guard let `self` = self else { return }

            self.searchController.resignFirstResponder()
            let detailVC = AnimalDetailVC.instantiate()
            detailVC.animal = animal
            self.navigationController?.pushViewController(detailVC, animated: true)
        }

    }
    
    func configureDatasource() {
        tableView.rowHeight = 520
        tableView.registerCell(AnimalFeedTVCell.self)
        
        dbManager = DBManager()
        dbManager.getAnimals() { [weak self] (animals) in
            mainQueue {
                self?.datasource = animals
                self?.tableView?.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: AnimalFeedTVCell.self, indexPath: indexPath)!
        cell.configureWithAnimal(animal: datasource[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = AnimalDetailVC.instantiate()
        detailVC.animal = datasource[indexPath.row]
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension DashboardVC: UISearchResultsUpdating {
    func filterContentForSearchText(searchText: String) {
        searchResultsVC.filteredAnimals = datasource.filter { animal in
            return animal.name.lowercased().contains(searchText.lowercased())
        }
        
        searchResultsVC.tableView?.reloadData()
    }
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            filterContentForSearchText(searchText: text)
        }
    }
}
