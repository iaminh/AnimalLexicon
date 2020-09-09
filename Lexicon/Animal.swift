//
//  Animal.swift
//  Lexicon
//
//  Created by Minh on 11/28/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

public enum HTMLNodeType : String {
    case HTMLUnkownNode     = ""
    case HTMLHrefNode       = "href"
    case HTMLTextNode       = "text"
    case HTMLCodeNode       = "code"
    case HTMLSpanNode       = "span"
    case HTMLPNode          = "p"
    case HTMLLiNode         = "li"
    case HTMLUiNode         = "ui"
    case HTMLImageNode      = "image"
    case HTMLOlNode         = "ol"
    case HTMLStrongNode     = "strong"
    case HTMLPreNode        = "pre"
    case HTMLBlockQuoteNode = "blockquote"
}

enum Food: Int {
    case seed = 0
    case grass
}

class ContinentRelation: Object {
    @objc dynamic var continentID: Int = 0
    @objc dynamic var animalId: Int = 0
    
    static func new (json: JSON) -> ContinentRelation {
        let relation = ContinentRelation()
        relation.continentID = json["id_c"].intValue
        relation.animalId = json["id"].intValue
        
        return relation
    }
    
    override class func primaryKey() -> String? {
        return "animalId"
    }
}

class FoodRelation: Object {
    @objc dynamic var foodID: Int = 0
    @objc dynamic var animalId: Int = 0
    
    static func new (json: JSON) -> FoodRelation {
        let relation = FoodRelation()
        relation.foodID = json["id_f"].intValue
        relation.animalId = json["id"].intValue
        
        return relation
    }
    
    override class func primaryKey() -> String? {
        return "animalId"
    }
}


class Animal: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var animalClass: Int = 0
    @objc dynamic var latinName: String = ""
    @objc dynamic var order : Int = 0
    @objc dynamic var spread: String = ""
    @objc dynamic var biotopNote: String = ""
    @objc dynamic var foodNote: String  = ""
    @objc dynamic var attractions: String = ""
    @objc dynamic var animalDescription: String = ""
    @objc dynamic var breeding: String = ""
    @objc dynamic var reproduction: String = ""
    
    
    // custom initializer does not work
    static func new(json: JSON) -> Animal {
        let animal = Animal()
        animal.id = json["id"].intValue
        animal.name = json["title"].stringValue
        animal.animalClass = json["class"].intValue
        animal.latinName = json["latin_title"].stringValue
        animal.order = json["order"].intValue
        animal.spread = json["spread"].stringValue.replacingOccurrences(of:"<[^>]+>", with: "", options: .regularExpression, range: nil)
        animal.biotopNote = json["biotopes_note"].stringValue.replacingOccurrences(of:"<[^>]+>", with: "", options: .regularExpression, range: nil)
        animal.foodNote = json["food_note"].stringValue.replacingOccurrences(of:"<[^>]+>", with: "", options: .regularExpression, range: nil)
        animal.attractions = json["attractions"].stringValue.replacingOccurrences(of:"<[^>]+>", with: "", options: .regularExpression, range: nil)
        animal.animalDescription = json["description"].stringValue
        animal.breeding = json["breeding"].stringValue.replacingOccurrences(of:"<[^>]+>", with: "", options: .regularExpression, range: nil)
        animal.reproduction = json["reproduction"].stringValue.replacingOccurrences(of:"<[^>]+>", with: "", options: .regularExpression, range: nil)
    
        return animal
    }
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    
    func getImageSource() -> String {
        let pattern = "alt=\"([^\"]+)\""
        let searchString = animalDescription
        return getStringFromPattern(pattern: pattern, searchString: searchString)
    }
    
    func getImageURL() -> String {
        let pattern = "src=\"([^\"]+)\""
        let searchString = animalDescription
        
        var urlString = getStringFromPattern(pattern: pattern, searchString: searchString).addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        
        if !urlString.contains("https://zoopraha.cz/") {
            urlString = "https://zoopraha.cz/" + urlString
        }
        
        
        return urlString
    }
    
    
    private func getStringFromPattern(pattern: String, searchString : String) -> String {
        let range = NSMakeRange(0, searchString.count)
        
        let regex : NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: UInt(0)))
            let matches = regex.matches(in: searchString, options: NSRegularExpression.MatchingOptions(rawValue: UInt(0)), range: range)
            
            if let match = matches.first {
                let matchString = (searchString as NSString).substring(with: match.range(at: 1))
                return matchString.trimmingCharacters(in: .whitespaces)
            }
            
            
        } catch {
            _ = log.error("Regex search error", error: nil)
        }
        
        return ""
    }
}
