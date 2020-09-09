//
//  AnimalClass.swift
//  Lexicon
//
//  Created by Minh on 12/4/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class AnimalClass: Object {
    @objc dynamic var id: String = "0"
    @objc dynamic var title: String = ""
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func new(json: JSON) -> AnimalClass {
        let aClass = AnimalClass()
        
        aClass.id = String(json["_id"].intValue)
        aClass.title = json["d"].stringValue
        
        return aClass
    }
}
