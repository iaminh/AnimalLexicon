//
//  ImageParser.swift
//  Lexicon
//
//  Created by Minh on 12/4/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import Foundation

class ImageParser: NSObject {
    
    
    var completion : ((_ source : String?, _ imageURL: String?) -> Void)?
    var parser : XMLParser!
    var animalID: Int
    
    init(string: String, animalID: Int) {
        self.animalID = animalID
        super.init()

        if let data = string.data(using: .utf8) {
            parser = XMLParser(data: data)
            parser.delegate = self
            parser.shouldProcessNamespaces = true
            parser.shouldReportNamespacePrefixes = true
            parser.shouldResolveExternalEntities = true
        }
    }
    
    
    func startParsing(completion: @escaping (_ source : String?, _ imageURL: String?) -> Void) {
        self.completion = completion
        parser.parse()
    }
    

}

extension ImageParser : XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
//        if(elementName == "img"){
//            completion?(attributeDict["alt"], attributeDict["src"])
//        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
}

