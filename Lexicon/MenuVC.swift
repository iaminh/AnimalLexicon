//
//  MenuVCViewController.swift
//  Movez
//
//  Created by Minh on 8/28/16.
//  Copyright © 2016 Movez. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    let datasource : [MenuItem] = [
        MenuItem(title: "seznam všech zvířat".uppercased(),iconName: "home-page", storyboardName: "Main"),
        MenuItem(title: "mapa zoo".uppercased(),iconName: "earth", storyboardName: "Map"),
        MenuItem(title: "zvířata podle tříd".uppercased(),iconName: "elephant-alone", storyboardName: "AnimalClass"),
        MenuItem(title: "zvířata podle kontinentů".uppercased(),iconName: "italy", storyboardName: "Locality"),
        MenuItem(title: "zvířata podle potravy".uppercased(),iconName: "grass", storyboardName: "Food"),
        MenuItem(title: "informace".uppercased(),iconName: "info", storyboardName: "Info"),
    ]
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerCell(MenuCell.self)
            tableView.rowHeight = 50
            tableView.delegate = self
            tableView.dataSource = self
            tableView.hideEmptyCells()
            tableView.backgroundColor = UIColor.clear
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MenuVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: MenuCell.self, indexPath: indexPath)!
        cell.loadItem(datasource[(indexPath as NSIndexPath).row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if datasource[indexPath.row].storyboardName.isEmpty {
            return
        }
        let vc = UIStoryboard(name:datasource[indexPath.row].storyboardName, bundle: nil).instantiateInitialViewController()
        
        (UIApplication.shared.delegate as? AppDelegate)?.sideMenuVC?.setContentViewController(vc, animated: true)
        (UIApplication.shared.delegate as? AppDelegate)?.sideMenuVC?.hideViewController()

    }
    
}
