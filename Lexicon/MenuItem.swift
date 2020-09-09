//
//  MenuItem.swift
//  Movez
//
//  Created by Minh on 8/29/16.
//  Copyright © 2016 Movez. All rights reserved.
//

import Foundation

struct MenuItem {
    let title : String
    let iconName : String
    let storyboardName: String
    
    init(title: String, iconName: String, storyboardName: String) {
        self.title = title
        self.iconName = iconName
        self.storyboardName = storyboardName
    }
}