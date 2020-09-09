//
//  BaseVC.swift
//  Movez
//
//  Created by Minh on 8/28/16.
//  Copyright © 2016 Movez. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        setNavigationBarAppearance()
    }
}


class BaseTableVC: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Lexikon.Base
        setNavigationBarAppearance()
    }
}
