//
//  InfoVC.swift
//  Lexicon
//
//  Created by Minh on 12/9/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import UIKit

class InfoVC: BaseTableVC {

    let datasource = [
        (title: "Grass - freepik, flaticon.com", icon: ""),
        (title: "Italy - freepik, flaticon.com", icon: ""),
        (title: "SimpleIcon - simpleIcon, flaticon.com", icon: ""),
        (title: "Elephant alone - freepik, flaticon.com", icon: ""),
        (title: "Information - freepik, flaticon.com", icon: ""),
        (title: "Home page - freepik, flaticon.com", icon: ""),
        (title: "Paw print - freepik, flaticon.com", icon: ""),
        (title: "Seed - freepik, flaticon.com", icon: ""),
        (title: "Berry - freepik, flaticon.com", icon: ""),
        (title: "Double Leaf - freepik, flaticon.com", icon: ""),
        (title: "Fish - freepik, flaticon.com", icon: ""),
        (title: "Ladybug - freepik, flaticon.com", icon: ""),
        (title: "Leaf - freepik, flaticon.com", icon: ""),
        (title: "Meat - freepik, flaticon.com", icon: ""),
        (title: "Science icon - freepik, flaticon.com", icon: ""),
        (title: "Steak - freepik, flaticon.com", icon: ""),
        (title: "Europe -  freeimages.com", icon: ""),
        (title: "North America -  freeimages.com", icon: ""),
        (title: "South America -  freeimages.com", icon: ""),
        (title: "Australia -  freeimages.com", icon: ""),
        (title: "Asia - freeimages.com", icon: ""),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Informace"
        view.backgroundColor = UIColor.Lexikon.Base
        tableView.backgroundColor = UIColor.Lexikon.Base
        
        tableView.registerCell(MenuCell.self)
        tableView.rowHeight = 50
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Zdroje obrázků použité v aplikaci s licencí common creative"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: MenuCell.self, indexPath: indexPath)!
        
        cell.titleLabel.text = datasource[indexPath.row].title
        cell.iconView.image = UIImage(named: datasource[indexPath.row].icon)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    

    
}
